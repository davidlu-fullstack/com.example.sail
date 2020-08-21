import 'package:flutter/material.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';

class ListingInformation extends StatelessWidget {
  final ListingModel listing;
  ListingInformation({@required this.listing});
  @override
  Widget build(BuildContext context) {
    return NavBarWidget.sliverNavBar(
        title: listing.address, body: pageBuilder(), context: context);
  }

  Widget pageBuilder() {
    return Placeholder();
  }
}

/* _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    ); */
