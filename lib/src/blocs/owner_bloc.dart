import 'dart:async';
import 'dart:io';

import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sail/src/models/listings.dart';
import 'package:sail/src/services/firestore_services.dart';
import 'package:uuid/uuid.dart';
import 'package:sail/src/services/firebase_storage.dart';

class OwnerBloc {
  final _unit = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();
  final _saveListing = PublishSubject<bool>();
  final _userId = BehaviorSubject<String>();
  final _listingId = BehaviorSubject<String>();
  final _listing = BehaviorSubject<ListingModel>();
  final _latitude = BehaviorSubject<String>();
  final _longitude = BehaviorSubject<String>();
  //! - Home Facts Start -
  final _homeValue = BehaviorSubject<String>();
  //! - Home Facts END -
  //! - Image Picker Start -
  final _picker = ImagePicker();
  final storageService = FirebaseStorageService();
  final _imageUrl = BehaviorSubject<String>();
  final _listBool = PublishSubject<bool>();
  final _isUploading = BehaviorSubject<bool>();
  //! - Image Picker End -
  final _db = FirestoreService();
  var uuid = Uuid();

  Stream<String> get unit => _unit.stream;
  Stream<String> get address => _address.stream;
  Stream<String> get latitude => _latitude.stream;
  Stream<String> get longitude => _longitude.stream;
  Stream<double> get homeValue => _homeValue.stream.transform(validateDouble);

  final validateDouble = StreamTransformer<String, double>.fromHandlers(
    handleData: (data, sink) {
      if (data != null) {
        try {
          sink.add(double.parse(data));
        } catch (error) {
          print(error);
        }
      }
    },
  );

  String get unitValue => _unit.value;
  Stream<String> get imageUrl => _imageUrl.stream;

  Stream<bool> get isUploading => _isUploading.stream;
  Stream<bool> get saveListing => _saveListing.stream;
  Future<ListingModel> fetchListing(String listingId) =>
      _db.fetchListing(listingId);
  Stream<List<ListingModel>> listingByuserId(String userId) =>
      _db.fetchProductsByUserId(userId);
  Stream<bool> get listBool => _listBool.stream; //!image picker list bool
  Function(String) get changeUnit => _unit.sink.add;
  Function(String) get changeAddress => _address.sink.add;
  Function(String) get changeUserId => _userId.sink.add;
  Function(String) get changeListingId => _listingId.sink.add;
  Function(String) get changeLatitude => _latitude.sink.add;
  Function(String) get changeLongitude => _longitude.sink.add;
  Function(String) get changeImageUrl => _imageUrl.sink.add; //! [image picker]
  Function(String) get changeHomeValue => _homeValue.sink.add; //![home facts]
  Function(ListingModel) get changeListing => _listing.sink.add;

  dispose() {
    _address.close();
    _listing.close();
    _saveListing.close();
    _unit.close();
    _userId.close();
    _listingId.close();
    _latitude.close();
    _longitude.close();
    _homeValue.close();
    _imageUrl.close();
    _listBool.close();
    _isUploading.close();
  }

  Future<void> save() async {
    var listing = ListingModel(
      approved: true,
      unit: _unit.value,
      listingId:
          (_listing.value == null) ? uuid.v4() : _listing.value.listingId,
      userId: _userId.value,
      longitude: _longitude.value,
      latitude: _latitude.value,
      homeValue: double.parse(_homeValue.value),
      address: _address.value,
      imageUrl: _imageUrl.value,
    );

    return _db
        .setListing(listing)
        .then((value) => _saveListing.sink.add(true))
        .catchError((onError) => _saveListing.sink.add(false));
  }

  //! -Start- adding image
  imagePicker() async {
    PickedFile image;

    await Permission.photos.request(); //asks for permission

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _picker.getImage(
          source: ImageSource
              .gallery); // Can set it up for using camera need to set permissions

      if (image != null) {
        var imageUrl =
            await storageService.uploadImage(File(image.path), uuid.v4());

        print(File(image.path));
        print(imageUrl);
      } else {
        print('No path received');
      }
    } else {
      print('Grant Permission and Try Again');
    }
    // Get image from device
  }

  //! Split this into TWO functions, one to store local file and one to save into firebase. The second function should save the string imageURL
  Future<String> createImageList() async {
    PickedFile image;
    File compressedFile; //![compression]
    File croppedFile; //![compression]

    await Permission.photos.request(); //asks for permission

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.gallery).whenComplete(
          () => _listBool.sink.add(
              false)); // Can set it up for using camera need to set permissions

      if (image != null) {
        _isUploading.sink.add(true);
        //![compression]
        // get image properties
        ImageProperties properties =
            await FlutterNativeImage.getImageProperties(image.path);
        // crop image
        if (properties.height > properties.width) {
          var yoffset = (properties.height - properties.width) / 2;

          croppedFile = await FlutterNativeImage.cropImage(image.path, 0,
              yoffset.toInt(), properties.width, properties.width);
        } else if (properties.width > properties.height) {
          var xoffset = (properties.width - properties.height) / 2;

          croppedFile = await FlutterNativeImage.cropImage(image.path,
              xoffset.toInt(), 0, properties.height, properties.height);
        } else {
          croppedFile = File(image.path);
        }

        compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 100,
            targetWidth: 600,
            targetHeight: 600);

        var imageUrl =
            await storageService.uploadImage(compressedFile, uuid.v4());

        _listBool.sink.add(true);
        return (imageUrl);
      } else {
        print('No path received');
        //_listBool.sink.add(false);
        return null;
      }
    } else {
      print('Grant Permission and Try Again');
      //_listBool.sink.add(false);
      return null;
    }
    // Get image from device
  }

  //! Need to implement second function to save
  saveImages(List<String> object) async {}

  //! Need to implement this
  cameraPicker() async {
    PickedFile image;

    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;
    if (permissionStatus.isGranted) {
      image = await _picker.getImage(source: ImageSource.camera);
      print(image.path);
    }
  }
  //! -end- adding image
}
