import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/widgets/navigation/buyer/file.dart';
import 'package:sail/src/widgets/navigation/buyer/home.dart';
import 'package:sail/src/widgets/navigation/buyer/profile.dart';
import 'package:sail/src/widgets/navigation/buyer/search.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';

class BuyerScreen extends StatefulWidget {
  @override
  _BuyerScreenState createState() => _BuyerScreenState();

  static TabBar get tabBar {
    return TabBar(
      unselectedLabelColor: ColorStyle.backgroundColor,
      labelColor: ColorStyle.complimentBlue,
      indicatorColor: ColorStyle.complimentBlue,
      tabs: <Widget>[
        Tab(
          icon: Icon(FontAwesomeIcons.home),
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.search),
        ),
        Tab(
          icon: Icon(FontAwesomeIcons.folder),
        ),
        Tab(icon: Icon(FontAwesomeIcons.user))
      ],
    );
  }
}

class _BuyerScreenState extends State<BuyerScreen> {
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
      length: 4,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              NavBarWidget.androidNavBar(
                  title: 'Buyer Name', tabBar: BuyerScreen.tabBar)
            ];
          },
          body: TabBarView(children: <Widget>[
            BuyerHome(),
            Search(),
            File(),
            BuyerProfile(),
          ]),
        ),
      ),
    );
  }
}
