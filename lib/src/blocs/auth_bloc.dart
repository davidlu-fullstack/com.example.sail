import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sail/src/models/user.dart';
import 'package:sail/src/services/firestore_services.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _user = BehaviorSubject<User>();
  final _errorMessage = BehaviorSubject<String>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  final _userTypeBool = PublishSubject<bool>(); //![1]
  final _saveStateBool = PublishSubject<bool>(); //![2]

  String get userId => _user.value.userId;
  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(email, password, (email, password) => true);
  Stream<User> get user => _user.stream;
  Stream<String> get errorMessage => _errorMessage.stream;
  Stream<bool> get userTypeBool => _userTypeBool.stream; //![1]
  Stream<bool> get saveStateBool => _saveStateBool.stream; //![2]

  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose() {
    _email.close();
    _password.close();
    _user.close();
    _errorMessage.close();
    _userTypeBool.close(); //![1]
    _saveStateBool.close(); //![2]
  }

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (regExpEmail.hasMatch(email.trim())) {
      sink.add(email.trim());
    } else {
      sink.addError('Must Be Valid Email Address');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 8) {
      sink.add(password.trim());
    } else {
      sink.addError('8 Character Minimum');
    }
  });

  signUpEmail() async {
    print('signing up with username and password');
    try {
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = User(userId: authResult.user.uid, email: _email.value.trim());
      await _firestoreService.addUser(user);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  loginEmail() async {
    print('logging in with username and password');
    try {
      AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: _email.value.trim(), password: _password.value.trim());
      var user = await _firestoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } on PlatformException catch (error) {
      print(error);
      _errorMessage.sink.add(error.message);
    }
  }

  logout() async {
    await _auth.signOut();
    _user.sink.add(null);
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) {
      return false;
    } else {
      var user = await _firestoreService.fetchUser(firebaseUser.uid);
      if (user == null) {
        return false;
      } else {
        _user.sink.add(user);
        return true;
      }
    }
  }

  clearErrorMessage() {
    _errorMessage.sink.add('');
  }

  //![1]
  Future<void> saveUserType(String type) async {
    var user = User(userId: _user.value.userId);

    return _firestoreService.setUserType(user, type);
  }

  //![2]
  Future<void> saveState(String userState) async {
    var user = User(userId: _user.value.userId);

    return _firestoreService.setUserState(user, userState);
  }

  //![2]
  Future<bool> stateCheck() async {
    var firebaseUser = await _auth.currentUser();
    var user = await _firestoreService.fetchUser(firebaseUser.uid);
    if (user.userState == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> roleCheck() async {
    var firebaseUser = await _auth.currentUser();
    var user = await _firestoreService.fetchUser(firebaseUser.uid);
    if (user.userType == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<String> userType() async {
    var firebaseUser = await _auth.currentUser();
    var user = await _firestoreService.fetchUser(firebaseUser.uid);
    return user.userType;
  }
}
