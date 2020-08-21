import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';

//! We build a list of homes the buyer has saved and they choose which one to price
//! In this screen, we offer the user our services to value the home

//! Currently using this screen as geocoding test
//! Succesful test for plugin Geocoder - Need to implement. We can remove the autocomplete
//* [1] Test geocoder on the 'Save' button widget
//* [2] If works, integrate streams into the geocode query and test again
//! [3] If passes, remove all pass by reference from details screen
//! [4] remove autocomplete from locations screen
//! [5] on the save method, implement a google maps pop up dialog box to verify address

class ListingPrice extends StatefulWidget {
  @override
  _ListingPriceState createState() => _ListingPriceState();
}

class _ListingPriceState extends State<ListingPrice> {
  static String query = '833 w 15th, chicago, il';

  @override
  void initState() {
    test(query);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavBarWidget.sliverNavBar(
        title: 'Geocoding Test', body: pageBuilder(), context: context);
  }

  Widget pageBuilder() {
    return ListView();
  }

  test(String query) async {
    var address = await Geocoder.local.findAddressesFromQuery(query);
    var first = address.first;
    print('${first.featureName} : ${first.coordinates}');
  }
}
