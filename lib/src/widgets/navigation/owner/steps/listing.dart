import 'package:flutter/material.dart';
import 'package:sail/src/widgets/button.dart';

class Listing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonWidget(
          label: 'Step 1: Get Ready',
          onPressed: () {
            Navigator.of(context).pushNamed('/location');
            print('pressed preperation tasks');
          },
        ),
        ButtonWidget(
          label: 'Step 2: Reach Out',
          onPressed: () {
            print('Pressed Marketing');
          },
        ),
        ButtonWidget(
          label: 'Step 7: Sail',
          onPressed: () {
            print('pressed sell tasks');
          },
        ),
      ],
    );
  }
}
