import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sail/src/blocs/buyer_bloc.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/services/transformers.dart';
import 'package:sail/src/styles/base.dart';
import 'package:sail/src/styles/colors.dart';
import 'package:sail/src/widgets/button.dart';
import 'package:sail/src/widgets/navigation/buyer/listing_info.dart';

List<ListingModel> listings =
    List<ListingModel>(); //*holds listings retrieved from database
Firestore _db = Firestore
    .instance; //*instance of database to retrieve entire listings in database
Set<Marker> markers = Set(); //*Marker set used in googlemaps
int selected; //*Selected value from dropdown button

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  void initState() {
    //*Function to retrieve listings from db and add to native list [Listings]
    _db.collection('listing').getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((e) {
        ListingModel test = ListingModel.fromFirestore(e.data);
        listings.add(test);
      });
    });

    //TODO Initialize the markers so they populate on the map prior to search

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var buyerBloc = Provider.of<BuyerBloc>(context);
    return Scaffold(
      backgroundColor: ColorStyle.backgroundColor,
      body: pageBody(context, buyerBloc),
    );
  }

  Widget pageBody(BuildContext context, BuyerBloc buyerBloc) {
    List<ListingModel> allProducts = new List<
        ListingModel>(); //*temp listing bin used to produce filtered marker set
    List<ListingModel> testingMarkers =
        List<ListingModel>(); //*list returned from filter
    ValueNotifier<bool> _pressed = ValueNotifier<bool>(true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //TODO: we should create controllers and then check if controllers have values with bools if using textfields for filtering
        //TODO: bool values will be passed into cases for button to call functions
        //TODO: Map should be streambuilder listener to search button.
        //TODO: Function will compare generated lists to original. if list 1 element not in list 2 then remove element from list

        //*Dropdown button for value filter
        DropdownButton(
          items: <String>[
            '\$100,000',
            '\$1,000,000',
            '\$10,000,000',
            '\$100,000,000'
          ].map((value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
          onChanged: (value) {
            selected = int.parse(value.replaceAll(new RegExp(r'[^\w\s]+'),
                '')); //*parse string value from dropdown to int value used in filter class call and set to local global [selected]
          },
        ),

        //*Search button that initates filtering
        ButtonWidget(
          label: 'Search',
          onPressed: () {
            allProducts = new List<ListingModel>.from(
                listings); //*Create COPY of listing for filtering
            //*conditional check if selected != null, we execute filtering process
            if (selected != null) {
              //!This might need to be switch case? however, the filtering will eventually be cumulative
              //* testingMarkers receives filtered list values from class function [MarkerFunction(...).testing]
              testingMarkers =
                  MarkerFunction(search: 'value', inputValue: selected)
                      .filteredList;
              //* listFunction compares filtered list to allproducts list and generates new filtered list
              //! Consider adding this local listFunction into MarkerFunction class
              listFunction(allProducts, testingMarkers);
              //* markers holds filtered markers set from class function call [MarkerFunction(...).marker]
              markers =
                  MarkerFunction(list: allProducts, context: context).marker;
            }
            //* we use this as a listanble variable to update map on value change
            _pressed.value = !_pressed.value;
          },
        ),

        //! If statement for inital listings and if pressed then we show the value listenable builder
        //*Listner builds map from changes to _press value from search button
        ValueListenableBuilder(
          valueListenable: _pressed,
          builder: (context, _pressed, child) {
            //*Currently, we build the map on both bool values
            if (_pressed == false) {
              //*conditional statement builds map if there are products in the database
              if (listings != null) {
                return Flexible(
                  child: GoogleMap(
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(41.8781, -87.62980), zoom: 11.5),
                  ),
                  flex: 1,
                );
              }
            }

            if (_pressed == true) {
              if (listings != null) {
                return Flexible(
                  child: GoogleMap(
                    markers: markers,
                    initialCameraPosition: CameraPosition(
                        target: LatLng(41.8781, -87.62980), zoom: 11.5),
                  ),
                  flex: 1,
                );
              }
            }
            return CircularProgressIndicator();
          },
        ),
      ],
    );
  }

  //* listFunction changes local list
  listFunction(List<ListingModel> first, List<ListingModel> second) {
    var toRemove = []; //* variable holds values to be removed
    //*function loops for each element in list passed into function
    first.forEach((element) {
      //*conditional checks if element is NOT in second list and adds element to be removed
      if (!second.contains(element)) {
        toRemove.add(element);
      }
    });

    //* function to 'filter' local list
    first.removeWhere((element) => toRemove.contains(element));
  }
}

//* MarkerFunction class holds getter producing functions
class MarkerFunction {
  String search;
  int inputValue;
  List<ListingModel> list;
  BuildContext context;
  MarkerFunction({this.search, this.inputValue, this.list, this.context});

  List<ListingModel> temp = List<ListingModel>();
  Set<Marker> markers = Set();

  //! Filter by price
  List<ListingModel> get filteredList {
    listings.forEach((element) {
      if (element.homeValue < inputValue) {
        temp.add(element);
      }
    });
    return temp;
  }

  //! Return marker set
  Set<Marker> get marker {
    list.forEach((element) {
      Marker resultMarker = Marker(
          onTap: () {
            List<String> images =
                TransformerService.stringToList(element.imageUrl, ',');
            showModalBottomSheet(
                context: context,
                builder: (context) => GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ListingInformation(
                              listing: element,
                            ),
                          )),
                      child: Container(
                        height: 250.0,
                        color: ColorStyle.logoGold,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: BaseStyles.boxShadow,
                                color: ColorStyle.backgroundColor,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      height: 250,
                                      width: 250,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(images[0]),
                                              fit: BoxFit.fill),
                                          boxShadow: BaseStyles.boxShadow,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                            child: Text(
                                          element.address,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold,
                                              color: ColorStyle.complimentBlue),
                                        )),
                                        SizedBox(
                                          height: 20.0,
                                        ),
                                        Center(
                                            child: Text(
                                          '\$${element.homeValue}',
                                          style: TextStyle(
                                              color: ColorStyle.logoGold),
                                        )),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          },
          markerId: MarkerId(element.address),
          position: LatLng(
              double.parse(element.latitude), double.parse(element.longitude)));
      markers.add(resultMarker);
    });
    return markers;
  }
}
