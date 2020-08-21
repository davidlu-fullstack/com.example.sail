import 'package:flutter/material.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';

abstract class TextFieldStyles {
  static Color get goldCursor => ColorStyle.logoGold;

  static OutlineInputBorder get borderBlue => OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.complimentBlue, width: 1.5));

  static OutlineInputBorder get borderGold => OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.logoGold, width: 1.5));

  static OutlineInputBorder get borderError => OutlineInputBorder(
      borderSide: BorderSide(color: ColorStyle.error, width: 1.5));

  static InputDecoration textBox(String hint, IconData icon, String errorText) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8.0),
      prefixIcon: Icon(icon), // Pass in by user
      hintText: hint,
      hintStyle: TextStyles.suggestion,
      focusedBorder: TextFieldStyles.borderBlue,
      enabledBorder: TextFieldStyles.borderGold,
      errorText: errorText,
      focusedErrorBorder: TextFieldStyles.borderBlue,
      errorBorder: TextFieldStyles.borderError,
    );
  }
}
