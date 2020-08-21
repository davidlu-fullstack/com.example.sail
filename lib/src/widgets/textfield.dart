import 'package:flutter/material.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/styles/textfields.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextInputType keyboard;
  final void Function(String) onChanged;
  final bool hidden;
  final String errorText;

  TextFieldWidget(
      {this.hint,
      this.icon,
      this.onChanged,
      this.keyboard,
      this.hidden = false,
      this.errorText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: BaseStyles.standardInset,
      child: TextField(
        cursorColor: TextFieldStyles.goldCursor,
        style: TextStyles.blackText,
        decoration: TextFieldStyles.textBox(hint, icon, errorText),
        keyboardType: keyboard,
        obscureText: hidden,
        onChanged: onChanged,
      ),
    );
  }
}
