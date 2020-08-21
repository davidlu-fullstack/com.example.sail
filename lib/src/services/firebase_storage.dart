import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final storage = FirebaseStorage.instance;

  Future<String> uploadImage(File file, String fileName) async {
    var snapshot = await storage
        .ref()
        .child('homeImages/$fileName')
        .putFile(file)
        .onComplete;

    return await snapshot.ref.getDownloadURL();
  }
}
