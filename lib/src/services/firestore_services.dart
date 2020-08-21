import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/models/schedule.dart';
import 'package:sail/src/models/user.dart';

class FirestoreService {
  Firestore _db = Firestore.instance;

  Future<void> addUser(User user) {
    return _db.collection('users').document(user.userId).setData(user.toMap());
  }

  Future<User> fetchUser(String userId) {
    return _db
        .collection('users')
        .document(userId)
        .get()
        .then((snapshot) => User.fromFirestore(snapshot.data));
  }

  //![1]
  Future<void> setUserType(User user, String userType) {
    return _db
        .collection('users')
        .document(user.userId)
        .updateData({'userType': userType});
  }

  //![2]
  Future<void> setUserState(User user, String userState) {
    return _db
        .collection('users')
        .document(user.userId)
        .updateData({'userState': userState});
  }

  Future<void> setListing(ListingModel listing) {
    return _db
        .collection('listing')
        .document(listing.listingId)
        .setData(listing.toMap());
  }

  Future<ListingModel> fetchListing(String listingId) {
    return _db
        .collection('listing')
        .document(listingId)
        .get()
        .then((snapshot) => ListingModel.fromFirestore(snapshot.data));
  }

  Stream<List<ListingModel>> fetchProductsByUserId(String userId) {
    return _db
        .collection('listing')
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((query) => query.documents)
        .map((snapshot) => snapshot
            .map((document) => ListingModel.fromFirestore(document.data))
            .toList());
  }

  Future<void> setListValue(
      ListingModel listing, String value, String binValue) {
    return _db
        .collection('listing')
        .document(listing.listingId)
        .updateData({'$binValue': value});
  }

  //This function might need you to add a boolean 'Approved' to the listings and then we can search where the listings are approved and show those listings on the map
  Stream<List<ListingModel>> fetchAllListing() {
    return _db
        .collection('listing')
        .snapshots()
        .map((query) => query.documents)
        .map((snapshot) => snapshot
            .map((document) => ListingModel.fromFirestore(document.data))
            .toList());
  }

  //! Testing search filter in buyer navigation
  Stream<List<ListingModel>> fetchListingByPrice(int price) {
    return _db
        .collection('listing')
        .where('homeValue', isLessThanOrEqualTo: price)
        .snapshots()
        .map((query) => query.documents)
        .map((snapshot) => snapshot
            .map((document) => ListingModel.fromFirestore(document.data))
            .toList());
  }

  Future<void> setSchedule(Schedule schedule) {
    return _db
        .collection('schedule')
        .document(schedule.userId)
        .setData(schedule.toMap());
  }

  Future<Schedule> fetchSchedule(String userId) {
    return _db
        .collection('schedule')
        .document(userId)
        .get()
        .then((snapshot) => Schedule.fromFirestore(snapshot.data));
  }
}
