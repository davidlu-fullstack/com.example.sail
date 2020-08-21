import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/owner_bloc.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';

//! Create BLoC for google places functions and send the address information to firebase.
//! Change colors of buttons to green when compelted and names of buttons to 'Edit'
//! For edit product => pushNamed('listingaddress/${listing.listingId})

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  @override
  Widget build(BuildContext context) {
    var addressBloc = Provider.of<OwnerBloc>(context);
    return NavBarWidget.sliverNavBar(
        title: 'Location', body: pageBuilder(addressBloc), context: context);
  }

  //! Don't want to be able to scroll
  Widget pageBuilder(OwnerBloc addressBloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Raised button style
        Padding(
          padding: BaseStyles.standardInset,
          child: ButtonTheme(
            height: 50.0,
            minWidth: double.infinity,
            child: RaisedButton(
              color: ColorStyle.logoGold,
              child: Text(
                'Nothing',
                style: TextStyles.blackText,
              ),
              elevation: 7.5,
              onPressed: () => print('Nope'),
            ),
          ),
        ),

        //! Button will change to edit home address once value is set in firebase
        Padding(
          padding: BaseStyles.standardInset,
          child: ButtonTheme(
            height: 50.0,
            minWidth: double.infinity,
            child: RaisedButton(
              color: ColorStyle.logoGold,
              child: Text(
                'Add Home',
                style: TextStyles.blackText,
              ),
              elevation: 7.5,
              onPressed: () async {
                Navigator.of(context).pushNamed('/listingaddress');
              },
            ),
          ),
        ),
      ],
    );
  }
}
