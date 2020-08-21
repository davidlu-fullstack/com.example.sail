import 'package:flutter/foundation.dart';

class ListingModel {
  final String listingId;
  final String userId;
  final String unit;
  final String address;
  final String latitude;
  final String longitude;
  final double homeValue;
  final String imageUrl;
  final bool approved;

  ListingModel({
    @required this.approved,
    this.address,
    this.unit,
    this.latitude,
    this.longitude,
    this.listingId,
    this.userId,
    this.homeValue,
    this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'approved': approved,
      'unit': unit,
      'latitude': latitude,
      'long': longitude,
      'address': address,
      'listingId': listingId,
      'userId': userId,
      'homeValue': homeValue,
      'imageUrl': imageUrl,
    };
  }

  ListingModel.fromFirestore(Map<String, dynamic> firestore)
      : unit = firestore['unit'],
        latitude = firestore['latitude'],
        longitude = firestore['long'],
        address = firestore['address'],
        listingId = firestore['listingId'],
        userId = firestore['userId'],
        homeValue = firestore['homeValue'],
        imageUrl = firestore['imageUrl'],
        approved = firestore['approved'];
}
