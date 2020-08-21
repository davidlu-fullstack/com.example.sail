import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sail/src/blocs/owner_bloc.dart';
import 'package:sail/src/blocs/schedule_bloc.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/models/schedule.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/widgets/button.dart';
import 'package:sail/src/widgets/stfl_textfield.dart';
import 'package:sail/src/services/transformers.dart';

//!Create styles file for dialog boxes
//!Integrate firebase store into the below textbox widgets

abstract class DialogBoxWidget {
  static Future<void> showValuationDialog(
      BuildContext context, OwnerBloc addressBloc) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Don\'t Sell yourself short',
                style: TextStyles.blueTitle,
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Padding(
                    padding: BaseStyles.standardInset,
                    child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            text: 'Hire a ',
                            style: TextStyles.blackText,
                            children: [
                              TextSpan(
                                  text: 'Professional',
                                  style: TextStyles.blueText,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => print('Services'))
                            ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        'Or',
                        style: TextStyles.suggestion,
                      ),
                    ),
                  ),
                  StreamBuilder<Object>(
                      stream: addressBloc.homeValue,
                      builder: (context, snapshot) {
                        return TextfieldStateFulWidget(
                          label: 'Home Value',
                          onChanged: addressBloc.changeHomeValue,
                        );
                      }),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Done',
                    style: TextStyles.blackText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  } //Navigator.of(context).pop(),
                  )
            ],
          );
        });
  }

  static Future<void> showVerifySave(
      BuildContext context, OwnerBloc addressBloc, Address address) async {
    Set<Marker> marker = {
      Marker(
          markerId: MarkerId('Home'),
          position: LatLng(
              address.coordinates.latitude, address.coordinates.longitude))
    };

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(0.0), //Removes dialog padding
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Map UI
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(boxShadow: BaseStyles.boxShadow),
                    child: GoogleMap(
                      markers: Set<Marker>.from(marker),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(address.coordinates.latitude,
                              address.coordinates.longitude),
                          zoom: 17.5),
                    ),
                  ),
                  //Address UI
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      '${address.addressLine}',
                      style: TextStyles.blackText,
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              //Action pops dialog message back to screen
              FlatButton(
                  child: Text(
                    'Incorrect',
                    style: TextStyles.errorText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  } //Navigator.of(context).pop(),
                  ),
              //Action saves address to firebase and changes bloc stream to true which is checked by screen
              FlatButton(
                  child: Text(
                    'Correct',
                    style: TextStyles.goldText,
                  ),
                  onPressed: () {
                    addressBloc.changeAddress('${address.addressLine}');
                    addressBloc.changeLatitude(
                        address.coordinates.latitude.toString());
                    addressBloc.changeLongitude(
                        address.coordinates.longitude.toString());
                    addressBloc.save();
                    Navigator.of(context).pop();
                  } //Navigator.of(context).pop(),
                  )
            ],
          );
        });
  }

  //TODO: add a spinning widget for loading screen
  //TODO: Try to make the save into firebase associated with onpress for 'DONE' widget instead of 'ADD' widget
  //TODO: add a delete functionality
  //! There is a delay between first add and second add
  static Future<void> showAddPhotos(
      BuildContext context, OwnerBloc addressBloc) async {
    //! Error when only one value in list
    List<String> imageBin = List<String>();
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: BaseStyles.dialogTitle('Photos'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  StreamBuilder<bool>(
                      stream: addressBloc.listBool,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Column(
                            children: <Widget>[
                              ButtonWidget(
                                  label: 'Add Gallary Image',
                                  button: Button.Standard,
                                  onPressed: () {
                                    addressBloc
                                        .createImageList()
                                        .then((String value) {
                                      //!if value is null then do not add to imagebin
                                      imageBin.add(value);
                                      print(
                                          'This is Image Bin Length: ${imageBin.length}');
                                    });
                                  }),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Center(
                                  child: Text(
                                    'Or',
                                    style: TextStyles.suggestion,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: BaseStyles.standardInset,
                                child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                        text: 'Hire a ',
                                        style: TextStyles.blackText,
                                        children: [
                                          TextSpan(
                                              text: 'Professional',
                                              style: TextStyles.blueText,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap =
                                                    () => print('Services'))
                                        ])),
                              ),
                            ],
                          );
                        } else if (snapshot.data == false) {
                          return BaseStyles.loadingWidget();
                        } else {
                          return Column(
                            children: <Widget>[
                              ButtonWidget(
                                label: 'Add Image',
                                button: Button.Standard,
                                onPressed: () {
                                  addressBloc
                                      .createImageList()
                                      .then((String value) {
                                    //!if value is null then do not add to imagebin
                                    imageBin.add(value);
                                    print(
                                        'This is Image Bin Length: ${imageBin.length}');
                                  });
                                },
                              ),
                              ButtonWidget(
                                label: 'Done',
                                button: Button.Standard,
                                onPressed: () {
                                  String hello =
                                      TransformerService.listToString(
                                          imageBin, ',');
                                  print('This is hello: $hello');
                                  addressBloc.changeImageUrl(hello);
                                  // List<String> test =
                                  //TransformerService.stringToList(hello, ',');
                                  //print('This is test: ${test[1]}');
                                  //addressBloc.saveImages(test);
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                      }),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Exit',
                    style: TextStyles.blackText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  } //Navigator.of(context).pop(),
                  )
            ],
          );
        });
  }

  static Future<void> showMarkerDialog(
      BuildContext context, OwnerBloc addressBloc, ListingModel listing) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: BaseStyles.dialogTitle(listing.address),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  ButtonWidget(
                    label: 'Edit Home',
                    onPressed: () => Navigator.of(context)
                        .pushNamed('/listingaddress/${listing.listingId}'),
                  ),
                  ButtonWidget(
                      label: 'Preview Home', onPressed: () => print('Preview')),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'Done',
                    style: TextStyles.blackText,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  } //Navigator.of(context).pop(),
                  )
            ],
          );
        });
  }
}
