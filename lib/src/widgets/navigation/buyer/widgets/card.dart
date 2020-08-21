import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.yellowAccent,
              height: 200,
              width: MediaQuery.of(context).size.width / 2,
            ),
          ),
          Column(
            children: <Widget>[
              Center(
                child: Text('Address Here'),
              ),
              Center(
                child: Text('Rooms and stuff here'),
              ),
              Center(
                child: Text('Price'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
