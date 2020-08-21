import 'package:flutter/material.dart';
import 'package:sail/src/app.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/widgets/button.dart';

String type;

class StateScreen extends StatefulWidget {
  @override
  _StateScreenState createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  final selected = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.backgroundColor,
      body: pageBuilder(),
    );
  }

  Widget pageBuilder() {
    authBloc.userType().then((value) {
      type = value;
    });

    print(type);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonWidget(
            label: 'Illinois',
            onPressed: () {
              if (type == null) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/landing', (route) => false);
              }

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/$type', (route) => false);

              authBloc.saveState('Illinois');
            }),
        ButtonWidget(
            label: 'California',
            onPressed: () {
              if (type == null) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/landing', (route) => false);
              }

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/$type', (route) => false);
              authBloc.saveState('California');
            }),
        ButtonWidget(
            label: 'New York',
            onPressed: () {
              if (type == null) {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/landing', (route) => false);
              }

              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/$type', (route) => false);
              authBloc.saveState('New York');
            }),
      ],
    );
  }
}

String selectedState = '';

List<String> states = [
  'Alabama',
  'Alaska',
  'Arizona',
  'Arkansas',
  'California',
  'Colorado',
  'Connecticut',
  'Delaware',
  'Florida',
  'Georgia',
  'Hawaii',
  'Idaho',
  'Illinois',
  'Indiana',
  'Iowa',
  'Kansas',
  'Kentucky',
  'Louisiana',
  'Maine',
  'Maryland',
  'Massachusetts',
  'Michigan',
  'Minnesota',
  'Mississippi',
  'Missouri',
  'Montana',
  'Nebraska',
  'Nevada',
  'New Hampshire',
  'New Jersey',
  'New Mexico',
  'New York',
  'North Carolina',
  'North Dakota',
  'Ohio',
  'Oklahoma',
  'Oregon',
  'Pennsylvania',
  'Rhode Island',
  'South Carolina',
  'South Dakota',
  'Tennessee',
  'Texas',
  'Utah',
  'Vermont',
  'Virginia',
  'Washington',
  'West Virginia',
  'Wisconsin',
  'Wyoming',
];
