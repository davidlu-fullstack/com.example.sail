import 'package:flutter/material.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';

abstract class NavBarWidget {
  static SliverAppBar androidNavBar(
      {@required String title, TabBar tabBar, bool pinned}) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: ColorStyle.complimentBlue),
      title: Text(title, style: TextStyles.blueTitle),
      backgroundColor: ColorStyle.logoGold,
      bottom: tabBar,
      floating: true,
      pinned: (pinned == null) ? true : pinned,
      snap: true,
    );
  }

  static SliverAppBar testNavBar(
      {@required String title, TabBar tabBar, bool pinned}) {
    return SliverAppBar(
      iconTheme: IconThemeData(color: ColorStyle.complimentBlue),
      title: Text(title, style: TextStyles.blueTitle),
      backgroundColor: ColorStyle.logoGold,
      bottom: tabBar,
      floating: true,
      pinned: (pinned == null) ? true : pinned,
      snap: true,
    );
  }

  static Scaffold sliverNavBar({
    BuildContext context,
    String title,
    Widget body,
    String hint,
    IconData iconData,
    Function onPressed,
  }) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: ColorStyle.complimentBlue),
            title: Text(title, style: TextStyles.blueTitle),
            backgroundColor: ColorStyle.logoGold,
            floating: true,
            pinned: false,
            snap: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(iconData),
                tooltip: hint,
                onPressed: onPressed,
              )
            ],
          ),
        ];
      },
      body: body,
    ));
  }
}
