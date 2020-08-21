import 'package:flutter/material.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/styles/textfields.dart';

class TextfieldStateFulWidget extends StatefulWidget {
  final void Function(String) onChanged;
  final String initalText;
  final String label;
  TextfieldStateFulWidget({this.onChanged, this.initalText, this.label});

  @override
  _TextfieldStateFulWidgetState createState() =>
      _TextfieldStateFulWidgetState();
}

class _TextfieldStateFulWidgetState extends State<TextfieldStateFulWidget> {
  TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    if (widget.initalText != null) _controller.text = widget.initalText;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            '${widget.label}: ',
            style: TextStyles.blackText,
          ),
          Expanded(
            child: TextField(
              cursorColor: TextFieldStyles.goldCursor,
              style: TextStyles.blackText,
              controller: _controller,
              onChanged: widget.onChanged,
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
}
