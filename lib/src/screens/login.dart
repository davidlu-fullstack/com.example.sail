import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/widgets/alert.dart';
import 'package:sail/src/widgets/button.dart';
import 'package:sail/src/widgets/social.dart';
import 'package:sail/src/widgets/textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  StreamSubscription _userSubscription;
  StreamSubscription _errorMessageSubscription;
  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    _userSubscription = authBloc.user.listen((user) {
      if (user != null && user.userState == null) {
        Navigator.pushReplacementNamed(
            context, '/state'); //![2] Testing StateScreen (originally /landing)
      } else if (user != null &&
          user.userState != null &&
          user.userType == null) {
        Navigator.pushReplacementNamed(context,
            '/landing'); //![2] Testing StateScreen (originally /landing)
      } else if (user != null &&
          user.userState != null &&
          user.userType != null) {
        Navigator.pushReplacementNamed(context,
            '/${user.userType}'); //![2] Testing StateScreen (originally /landing)
      }
    });

    _errorMessageSubscription = authBloc.errorMessage.listen((errorMessage) {
      if (errorMessage != '') {
        AlertWidget.showErrorDialog(context, errorMessage)
            .then((_) => authBloc.clearErrorMessage());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    _errorMessageSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
        backgroundColor: ColorStyle.backgroundColor,
        body: pageBuilder(context, authBloc));
  }

  Widget pageBuilder(BuildContext context, AuthBloc authBloc) {
    return ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Image(
            image: AssetImage('assets/images/sail_logo.png'),
          ),
        ),
        StreamBuilder<String>(
            stream: authBloc.email,
            builder: (context, snapshot) {
              return TextFieldWidget(
                hint: 'Email',
                icon: FontAwesomeIcons.envelope,
                onChanged: authBloc.changeEmail,
                errorText: snapshot.error,
              );
            }),
        StreamBuilder<Object>(
            stream: authBloc.password,
            builder: (context, snapshot) {
              return TextFieldWidget(
                hint: 'Password',
                icon: FontAwesomeIcons.lock,
                hidden: true,
                onChanged: authBloc.changePassword,
                errorText: snapshot.error,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return ButtonWidget(
                label: 'Login',
                button: (snapshot.data == true) ? null : Button.Disabled,
                onPressed: authBloc.loginEmail,
              );
            }),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Center(
            child: Text(
              'Sign In With Social Media',
              style: TextStyles.suggestion,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SocialButton(
              organization: Organization.Google,
            ),
            SizedBox(
              width: 25.0,
            ),
            SocialButton(
              organization: Organization.Facebook,
            ),
          ],
        ),
        SizedBox(
          height: 125.0,
        ),
        Padding(
          padding: BaseStyles.standardInset,
          child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'New Here? ',
                  style: TextStyles.blackText,
                  children: [
                    TextSpan(
                        text: 'Signup',
                        style: TextStyles.blueText,
                        recognizer: TapGestureRecognizer()
                          ..onTap =
                              () => Navigator.pushNamed(context, '/signup'))
                  ])),
        ),
      ],
    );
  }
}
