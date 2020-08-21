import 'package:flutter/material.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/styles/textfields.dart';

class TextFieldControllerWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  TextFieldControllerWidget({@required this.controller, this.label});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        child: Row(
          children: <Widget>[
            Text(
              '$label: ', //! must pass in title
              style: TextStyles.blackText,
            ),
            Flexible(
              child: TextField(
                cursorColor: TextFieldStyles.goldCursor,
                style: TextStyles.blackText,
                controller: controller, //! must pass in controller
                decoration: InputDecoration(
                  //! icon with bool passed in?
                  contentPadding: EdgeInsets.all(8.0),
                  hintStyle: TextStyles.suggestion,
                  focusedBorder: TextFieldStyles.borderBlue,
                  enabledBorder: TextFieldStyles.borderGold,
                  focusedErrorBorder: TextFieldStyles.borderBlue,
                  errorBorder: TextFieldStyles.borderError,
                ),
              ),
            ),
          ],
        ));
  }
}
