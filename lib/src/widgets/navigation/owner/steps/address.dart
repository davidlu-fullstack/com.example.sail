import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/owner_bloc.dart';
import 'package:sail/src/blocs/auth_bloc.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/services/transformers.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/styles/text.dart';
import 'package:sail/src/widgets/button.dart';
import 'package:sail/src/widgets/ctrl_textfield.dart';
import 'package:sail/src/widgets/navigation/navigation.dart';
import 'package:sail/src/widgets/navigation/owner/steps/address_dialog.dart';
import 'package:sail/src/widgets/stfl_textfield.dart';

//! You probably don't need to store street, city, state. You can just use regular controllers and then changeAddress using geocoder
class ListingAddress extends StatefulWidget {
  //* constructor here for if editing product
  final String listingId;
  ListingAddress({this.listingId});

  @override
  _ListingAddressState createState() => _ListingAddressState();
}

class _ListingAddressState extends State<ListingAddress> {
  //* Testing getting string value
  final streetController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();

  //* init state here to listen when product is saved
  @override
  void initState() {
    //* listens for save event and pops screen off stack
    var addressBloc = Provider.of<OwnerBloc>(context, listen: false);
    addressBloc.saveListing.listen((event) {
      if (event != null && event == true)
        Navigator.of(context).pushNamed('/owner');
    });
    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    streetController.dispose();
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var addressBloc = Provider.of<OwnerBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);
    return FutureBuilder<ListingModel>(
      future: addressBloc.fetchListing(widget.listingId),
      builder: (context, snapshot) {
        //*Condition if data is loading to screen
        if (!snapshot.hasData && widget.listingId != null) {
          return BaseStyles.loadingWidget();
        }

        ListingModel existingModel = snapshot.data;

        //* Conditional check for edit or add
        if (widget.listingId != null) {
          print(widget.listingId);
          List<String> addressBin =
              TransformerService.stringToList(existingModel.address, ',');
          List<String> stateTemp =
              TransformerService.stringToList(addressBin[2], ' ');
          print(stateTemp);
          streetController.text = addressBin[0];
          cityController.text = addressBin[1];
          stateController.text = stateTemp[1];
          loadValues(addressBloc, existingModel, authBloc.userId);
        } else {
          loadValues(addressBloc, null, authBloc.userId);
        }

        return NavBarWidget.sliverNavBar(
            title: (existingModel != null) ? 'Edit Address' : 'New Address',
            body: pageBuilder(addressBloc, context, existingModel),
            context: context);
      },
    );
  }

  //TODO: change some values to constant values [Home Type, $ signs in front of value, etc]
  //TODO: create error handling conditions for textfields
  //TODO: Create a edit photos button that will change the imageURL stream to edit
  Widget pageBuilder(
      OwnerBloc addressBloc, BuildContext context, ListingModel existingModel) {
    return ListView(
      children: <Widget>[
        TextStyles.headerTitle('Address'),
        BaseStyles.divider,
        TextFieldControllerWidget(
          controller: streetController,
          label: 'Street',
        ),
        StreamBuilder<String>(
          stream: addressBloc.unit,
          builder: (context, snapshot) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextfieldStateFulWidget(
                label: 'Unit',
                initalText: (existingModel != null) ? existingModel.unit : null,
                onChanged: addressBloc.changeUnit,
              ),
            );
          },
        ),
        TextFieldControllerWidget(
          controller: cityController,
          label: 'City',
        ),
        TextFieldControllerWidget(
          controller: stateController,
          label: 'State',
        ),
        BaseStyles.divider,
        ButtonWidget(
          label: 'Home Value',
          onPressed: () =>
              DialogBoxWidget.showValuationDialog(context, addressBloc),
        ),
        ButtonWidget(
          label: 'Add Photos',
          onPressed: () => DialogBoxWidget.showAddPhotos(context, addressBloc),
        ),

        //TODO: Disable button if Street City and State are empty
        Padding(
          padding: BaseStyles.standardInset,
          child: ButtonTheme(
            height: 50.0,
            minWidth: double.infinity,
            child: RaisedButton(
                color: ColorStyle.logoGold,
                child: Text(
                  'Save Product',
                  style: TextStyles.blackText,
                ),
                elevation: 7.5,
                onPressed: () async {
                  //TODO: Find out how to create function that can take in multiple references under one variable
                  Address address = await test(
                      '${streetController.text}, ${cityController.text}, ${stateController.text}');
                  DialogBoxWidget.showVerifySave(context, addressBloc, address);
                }),
          ),
        ),
      ],
    );
  }

  test(String query) async {
    var address = await Geocoder.local.findAddressesFromQuery(query);
    var first = address.first;
    return first;
  }

  //TODO: Load all info for editing
  loadValues(OwnerBloc addressBloc, ListingModel listing, String userId) {
    addressBloc.changeListing(listing);
    addressBloc.changeUserId(userId);

    if (listing != null) {
      //edit
      addressBloc.changeUnit(listing.unit);
    } else {
      //add
      addressBloc.changeUnit(null);
      addressBloc.changeLatitude(null);
      addressBloc.changeLongitude(null);
    }
  }
}
