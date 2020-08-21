import 'package:flutter/material.dart';

class File extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageBody(),
    );
  }

  Widget pageBody() {
    return Center(child: Text('Buyer Checklist'));
  }
}
