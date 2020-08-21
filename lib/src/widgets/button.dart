import 'package:flutter/material.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';

class ButtonWidget extends StatefulWidget {
  final String label;
  final Button button;
  final void Function() onPressed;
  ButtonWidget({@required this.label, this.button, this.onPressed});
  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    TextStyle style;
    Color color;

    switch (widget.button) {
      case Button.Disabled:
        style = TextStyles.disabledText;
        color = ColorStyle.disabledColor;
        break;
      case Button.Error:
        style = TextStyles.blackText;
        color = ColorStyle.error;
        break;
      case Button.Standard:
        style = TextStyles.blackText;
        color = ColorStyle.complimentBlue;
        break;
      default:
        style = TextStyles.blackText;
        color = ColorStyle.logoGold;
    }

    return AnimatedContainer(
      padding: EdgeInsets.only(
          top: (selected) ? BaseStyles.offsetTop : BaseStyles.insetVerticle,
          bottom:
              (selected) ? BaseStyles.offsetBottom : BaseStyles.insetVerticle,
          left: BaseStyles.insetHorizontal,
          right: BaseStyles.insetHorizontal),
      child: GestureDetector(
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: color,
              boxShadow: (selected)
                  ? BaseStyles.boxShadowPress
                  : BaseStyles.boxShadow),
          child: Center(
            child: Text(widget.label, style: style),
          ),
        ),
        onTapDown: (details) {
          setState(() {
            if (widget.button != Button.Disabled) selected = !selected;
          });
        },
        onTapUp: (details) {
          setState(() {
            if (widget.button != Button.Disabled) selected = !selected;
          });
        },
        onTap: () {
          if (widget.button != Button.Disabled) {
            //widget.onPressed();
            widget.onPressed();
          }
        },
      ),
      duration: Duration(milliseconds: 25),
    );
  }
}

enum Button { Error, Disabled, Standard }
