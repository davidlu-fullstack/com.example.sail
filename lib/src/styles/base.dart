import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/styles/textfields.dart';

abstract class BaseStyles {
  static double get insetVerticle => 10.0;
  static double get insetHorizontal => 75.0;
  static double get offsetTop => BaseStyles.insetVerticle + 1.0;
  static double get offsetBottom => BaseStyles.insetVerticle - 1.0;
  static double get dividerThickness => 1.0;

  static Divider get divider => Divider(
        thickness: BaseStyles.dividerThickness,
      );

  static EdgeInsets get standardInset => EdgeInsets.symmetric(
      vertical: insetVerticle, horizontal: insetHorizontal);

  static List<BoxShadow> get boxShadow {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        offset: Offset(1.0, 2.0),
        blurRadius: 2.0,
      )
    ];
  }

  static List<BoxShadow> get boxShadowPress {
    return [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        offset: Offset(1.0, 1.0),
        blurRadius: 1.0,
      )
    ];
  }

  static Widget loadingScreen() {
    return Scaffold(
      backgroundColor: ColorStyle.backgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Widget loadingWidget() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  static Widget dialogTitle(String text) {
    return Center(
      child: Text(
        '$text ',
        style: TextStyles.blueTitle,
      ),
    );
  }

  static Widget dialogMessage(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        text,
        style: TextStyles.blackText,
      ),
    );
  }

  static Widget dialogTextFields(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            '$label: ',
            style: TextStyles.blackText,
          ),
          Expanded(
            child: TextFormField(
              cursorColor: TextFieldStyles.goldCursor,
              style: TextStyles.blackText,
              initialValue: value,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                hintStyle: TextStyles.suggestion,
                focusedBorder: TextFieldStyles.borderBlue,
                enabledBorder: TextFieldStyles.borderGold,
                focusedErrorBorder: TextFieldStyles.borderBlue,
                errorBorder: TextFieldStyles.borderError,
              ),
            ),
          )
        ],
      ),
    );
  }

  static TabBar get tabBar {
    return TabBar(
      unselectedLabelColor: ColorStyle.backgroundColor,
      labelColor: ColorStyle.complimentBlue,
      indicatorColor: ColorStyle.complimentBlue,
      tabs: <Widget>[
        Tab(
          icon: Icon(FontAwesomeIcons.home),
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.edit),
        ),
        Tab(icon: Icon(FontAwesomeIcons.user))
      ],
    );
  }
}
