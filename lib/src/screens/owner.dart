import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';
import 'package:sail/src/widgets/navigation/owner/home/home.dart';
import 'package:sail/src/widgets/navigation/owner/profile.dart';
import 'package:sail/src/widgets/navigation/owner/steps/listing.dart';

class OwnerScreen extends StatefulWidget {
  @override
  _OwnerScreenState createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  StreamSubscription _userSubscription;
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      var authBloc = Provider.of<AuthBloc>(context, listen: false);
      _userSubscription = authBloc.user.listen((event) {
        if (event == null) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('login', (route) => false);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: pageBody(context));
  }

  Widget pageBody(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              NavBarWidget.androidNavBar(
                  title: 'Owners Name', tabBar: BaseStyles.tabBar)
            ];
          },
          body: TabBarView(children: <Widget>[
            //! We want to be able to pass a stream bool for lat/lngs of user homes into OwnerHome for user editing
            //! User will have dropdown from onClick on marker on map to either EDIT or PREVIEW LISTING
            OwnerHome(),
            Listing(),
            OwnerProfile(),
          ]),
        ),
      ),
    );
  }
}
