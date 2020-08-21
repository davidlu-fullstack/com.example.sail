import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/widgets/button.dart';

/*
!TODO:  Create init state to listen for option if buyer, seller, or service.
!       similar to save product, when user chooses owner/buyer/seller we save
!       to firebase under the userID. This screen will have a listener that
!       navigates to new screen depending on value received from firebase
!       user should also have option to change the value EX: (buyer wants to become seller)
*/
class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context); //![1]
    return Scaffold(body: pageBody(context, authBloc)); //![1] add authBloc
  }

  Widget pageBody(BuildContext context, AuthBloc authBloc) {
    //![1] add authBloc
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonWidget(
          label: 'Home Owner',
          onPressed: () {
            Navigator.pushNamed(context, '/owner');
            authBloc.saveUserType('owner');
          },
        ),
        ButtonWidget(
          label: 'Home Buyer',
          onPressed: () {
            Navigator.pushNamed(context, '/buyer');
            authBloc.saveUserType('buyer');
          },
        ),
        ButtonWidget(
          label: 'Service',
          onPressed: () {
            Navigator.pushNamed(context, '/service');
            authBloc.saveUserType('service');
          },
        ),
      ],
    );
  }
}
