import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/services/firestore_services.dart';

class BuyerBloc {
  final _db = FirestoreService();

  Stream<List<ListingModel>> fetchAllListings() => _db.fetchAllListing();

  Stream<List<ListingModel>> fetchSearchQuery(int value) =>
      _db.fetchListingByPrice(value);
}
