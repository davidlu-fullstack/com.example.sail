import 'package:flutter/material.dart';
import 'package:sail/src/screens/buyer.dart';
import 'package:sail/src/screens/landing.dart';
import 'package:sail/src/screens/login.dart';
import 'package:sail/src/screens/owner.dart';
import 'package:sail/src/screens/service.dart';
import 'package:sail/src/screens/signup.dart';
import 'package:sail/src/screens/state.dart';
import 'package:sail/src/widgets/navigation/owner/home/home.dart';
import 'package:sail/src/widgets/navigation/owner/steps/address.dart';
import 'package:sail/src/widgets/navigation/owner/steps/listing_price.dart';
import 'package:sail/src/widgets/navigation/owner/steps/location.dart';

abstract class Routes {
  static MaterialPageRoute materialRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/landing':
        return MaterialPageRoute(builder: (context) => Landing());
      case '/login':
        return MaterialPageRoute(builder: (context) => Login());
      case '/signup':
        return MaterialPageRoute(builder: (context) => Signup());
      case '/owner':
        return MaterialPageRoute(builder: (context) => OwnerScreen());
      case '/buyer':
        return MaterialPageRoute(builder: (context) => BuyerScreen());
      case '/service':
        return MaterialPageRoute(builder: (context) => ServiceScreen());
      case '/state':
        return MaterialPageRoute(builder: (context) => StateScreen());
      case '/location':
        return MaterialPageRoute(builder: (context) => Location());
      case '/listingaddress':
        return MaterialPageRoute(builder: (context) => ListingAddress());
      case '/listprice':
        return MaterialPageRoute(builder: (context) => ListingPrice());
      case '/ownerhome':
        return MaterialPageRoute(builder: (context) => OwnerHome());
      default:
        var routeArray = settings.name.split('/');
        if (settings.name.contains('/listingaddress/')) {
          return MaterialPageRoute(
            builder: (context) => ListingAddress(
              listingId: routeArray[2],
            ),
          );
        }
        return MaterialPageRoute(builder: (context) => Login());
    }
  }
}
