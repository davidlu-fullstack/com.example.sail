import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/buyer_bloc.dart';
import 'package:sail/src/blocs/owner_bloc.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/blocs/schedule_bloc.dart';
import 'package:sail/src/routes.dart';
import 'package:sail/src/screens/buyer.dart';
import 'package:sail/src/screens/landing.dart';
import 'package:sail/src/screens/login.dart';
import 'package:sail/src/screens/owner.dart';
import 'package:sail/src/screens/service.dart';
import 'package:sail/src/screens/state.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/widgets/navigation/service/geolocator_service.dart';

final authBloc = AuthBloc(); //*Helper BLoC for firebase functions
final addressBloc = OwnerBloc();
final buyerBloc = BuyerBloc();
final scheduleBloc = ScheduleBloc();
final locatorService = GeoLocatorService();
var state;
var role;
String type;

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => authBloc),
        Provider(
          create: (context) => addressBloc,
        ),
        Provider(
          create: (context) => buyerBloc,
        ),
        Provider(
          create: (context) => scheduleBloc,
        ),
        FutureProvider(
          create: (context) => authBloc.isLoggedIn(),
        ),
      ],
      child: PlatformApp(),
    );
  }

  @override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }
}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLoggedIn = Provider.of<bool>(context);

    authBloc.stateCheck().then((value) {
      state = value;
    });

    authBloc.roleCheck().then((value) {
      role = value;
    });

    authBloc.userType().then((value) {
      type = value;
    });

    return MaterialApp(
      home: (isLoggedIn == false)
          ? Login()
          : (isLoggedIn == true && state == false)
              ? StateScreen() //![2] See Login()
              : (isLoggedIn == true && state == true && role == false)
                  ? Landing()
                  : (type == 'owner')
                      ? OwnerScreen()
                      : (type == 'buyer')
                          ? BuyerScreen()
                          : (type == 'service')
                              ? ServiceScreen()
                              : BaseStyles
                                  .loadingScreen(), //![x] We need to change this to the users homepage
      onGenerateRoute: Routes.materialRoutes,
    );
  }
}
