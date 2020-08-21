import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sail/src/styles/colors.dart';

abstract class TextStyles {
  static TextStyle get blackText => GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w300, fontSize: 16.0));
  static TextStyle get goldText => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.logoGold,
          fontWeight: FontWeight.w700,
          fontSize: 16.0));
  static TextStyle get suggestion => GoogleFonts.lato(
      textStyle: TextStyle(
          color: Colors.black.withOpacity(0.25),
          fontWeight: FontWeight.w300,
          fontSize: 14.0));
  static TextStyle get disabledText => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.disabledTextColor,
          fontWeight: FontWeight.w300,
          fontSize: 16.0));

  static TextStyle get errorTitle => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.error,
          fontWeight: FontWeight.bold,
          fontSize: 30.0));

  static TextStyle get errorText => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.error,
          fontWeight: FontWeight.w300,
          fontSize: 16.0));

  static TextStyle get blueText => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.complimentBlue,
          fontWeight: FontWeight.w300,
          fontSize: 16.0));

  static TextStyle get blueTitle => GoogleFonts.lato(
      textStyle: TextStyle(
          color: ColorStyle.complimentBlue,
          fontWeight: FontWeight.bold,
          fontSize: 16.0));

  static Padding headerTitle(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: ColorStyle.complimentBlue,
              fontSize: 25.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  static Padding labelGold(String text) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: ColorStyle.logoGold,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
