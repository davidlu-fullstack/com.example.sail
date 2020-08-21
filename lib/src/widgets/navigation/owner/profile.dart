import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/widgets/button.dart';

class OwnerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageBody(context),
    );
  }

  Widget pageBody(BuildContext context) {
    var authBloc = Provider.of<AuthBloc>(context);
    return Center(
        child: Column(
      children: <Widget>[
        ButtonWidget(
          label: 'Signout',
          onPressed: () => authBloc.logout(),
        ),
        ButtonWidget(
            label: 'Change Role',
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/landing', (route) => false);
              authBloc.saveUserType(null);
            }),
        ButtonWidget(
            label: 'Change State',
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/state', (route) => false);
              authBloc.saveState(null);
            }),
      ],
    ));
  }
}
