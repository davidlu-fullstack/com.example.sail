import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sail/src/styles/text.dart';

abstract class AlertWidget {
  static Future<void> showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Error!',
                style: TextStyles.errorTitle,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    errorMessage,
                    style: TextStyles.blackText,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Forgot Password? ',
                            style: TextStyles.errorText,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print('User Forgot Password');
                              })),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Exit',
                  style: TextStyles.blackText,
                ),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
