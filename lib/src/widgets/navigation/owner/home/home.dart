import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/blocs/owner_bloc.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/widgets/navigation/owner/steps/address_dialog.dart';
import 'package:sail/src/widgets/navigation/owner/steps/availibility.dart';

class OwnerHome extends StatefulWidget {
  @override
  _OwnerHomeState createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  @override
  Widget build(BuildContext context) {
    //TODO: Instantiate authBloc and ownerBloc and pass into page body
    //TODO: Pass userID into pagebody as type String
    var addressBloc = Provider.of<OwnerBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);
    return Scaffold(
      body: pageBody(context, addressBloc, authBloc, authBloc.userId),
    );
  }

  Widget pageBody(BuildContext context, OwnerBloc addressBloc,
      AuthBloc authBloc, String userId) {
    Set<Marker> markers = Set();
    return StreamBuilder<List<ListingModel>>(
      stream: addressBloc.listingByuserId(userId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }
        for (var i = 0; i < snapshot.data.length; i++) {
          var listing = snapshot.data[i];
          Marker resultMarker = Marker(
              onTap: () => DialogBoxWidget.showMarkerDialog(
                  context, addressBloc, listing),
              markerId: MarkerId(listing.address),
              position: LatLng(double.parse(listing.latitude),
                  double.parse(listing.longitude)));
          markers.add(resultMarker);
        }

        return Column(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(boxShadow: BaseStyles.boxShadow),
              child: GoogleMap(
                markers: markers,
                cameraTargetBounds: CameraTargetBounds(_bounds(markers)),
                //minMaxZoomPreference:
                //! Issue with zoom: Want all markers to be fitted inside window
                initialCameraPosition:
                    CameraPosition(target: LatLng(0.0, 0.0), zoom: 11.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Availibility(),
            ),
          ],
        );
      },
    );
  }
}

LatLngBounds _bounds(Set<Marker> markers) {
  if (markers == null || markers.isEmpty) return null;
  return _createBounds(markers.map((m) => m.position).toList());
}

LatLngBounds _createBounds(List<LatLng> positions) {
  final southwestLat = positions.map((p) => p.latitude).reduce(
      (value, element) => value < element ? value : element); // smallest
  final southwestLon = positions
      .map((p) => p.longitude)
      .reduce((value, element) => value < element ? value : element);
  final northeastLat = positions
      .map((p) => p.latitude)
      .reduce((value, element) => value > element ? value : element); // biggest
  final northeastLon = positions
      .map((p) => p.longitude)
      .reduce((value, element) => value > element ? value : element);
  return LatLngBounds(
      southwest: LatLng(southwestLat, southwestLon),
      northeast: LatLng(northeastLat, northeastLon));
}
