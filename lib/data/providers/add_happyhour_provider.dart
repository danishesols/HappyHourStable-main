import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

class AddHappyHourProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  List<HappyHourModel> happyHourModelDataList = [];

  final happyhourFetchingQuery = FirebaseFirestore.instance
      .collection("happyhours")
      .orderBy('id', descending: true)
      .orderBy('addHappyhourTime', descending: true)
      .withConverter<HappyHourModel>(
        fromFirestore: (snapshot, _) =>
            HappyHourModel.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (happyHourData, _) => happyHourData.toJson(),
      );
//*============Edit Screen Querry =========*//
  final editFetchingQuery = FirebaseFirestore.instance
      .collection("happyhours")
      .where("id", isEqualTo: Get.find<AuthController>().user.uid)
      // .orderBy('promoted', descending: true)
      .orderBy('addHappyhourTime', descending: true)

      //.where("promoted", whereIn: [true & false])
      .withConverter<HappyHourModel>(
        fromFirestore: (snapshot, _) =>
            HappyHourModel.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (happyHourData, _) => happyHourData.toJson(),
      );

  //*============Claim Screen Querry =========*//
  final claimedFetchingQuery = FirebaseFirestore.instance
      .collection("happyhours")
      .where("claimed_users_ids",
          arrayContains: Get.find<AuthController>().user.uid)
      .orderBy('addHappyhourTime', descending: true)
      .withConverter<HappyHourModel>(
        fromFirestore: (snapshot, _) =>
            HappyHourModel.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (happyHourData, _) => happyHourData.toJson(),
      );

  //*============Subcription Fetch Screen Querry =========*//
  final subcriptionFetchingQuery = FirebaseFirestore.instance
      .collection("happyhours")
      .where("claimed_users_ids",
          arrayContains: Get.find<AuthController>().user.uid)
      .orderBy('addHappyhourTime', descending: true)
      .withConverter<HappyHourModel>(
        fromFirestore: (snapshot, _) =>
            HappyHourModel.fromJson(snapshot.data()!, snapshot.id),
        toFirestore: (happyHourData, _) => happyHourData.toJson(),
      );

  final geo = Geoflutterfire();

  // Stream<List<SearchModel>> fetchSearchHours() {
  //   return _firebaseFirestore
  //       .collection("happyhours")
  //       .limit(10)
  //       .snapshots()
  //       .map((QuerySnapshot querySnapshot) {
  //     List<SearchModel> hourList = [];

  //     for (var doc in querySnapshot.docs) {
  //       hourList.add(SearchModel.fromDocument(doc));
  //     }
  //     return hourList;
  //   });
  // }

  Future<void> getAllHoursData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("happyhours").get();
    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    print("My Happy Hours List length is ${allData.length}");
    //print("hfdsfkhdkjhskjhgfdf ghskjlfdhks");
    for (var element in allData) {
      HappyHourModel user = HappyHourModel.fromDoc(Map.from(element as Map));
      happyHourModelDataList.add(user);
      // print(user.businessAddress);
    }
  }

  Future uploadToFirebaseStorage({
    String? accountType,
    String? id,
    String? businessName,
    String? businessAddress,
    String? description,
    String? phoneNumber,
    String? businessCard,
    String? businessLogo,
    String? businessImage,
    String? menuImage,
    String? menuImage2,
    String? paid,
    List? fromTimeToTime,
    List? dayTime,
    List? daytimeLate,
    List? time,
    List? foodNames,
    List? drinkitemNames,
    List? amenities,
    List? barType,
    List? dailySpecial,
    List? event,
    required Map<String, dynamic> latLong,
    GeoFirePoint? position,
  }) async {
    await _firebaseFirestore.collection("happyhours").add({
      'accountType': accountType,
      "id": id,
      "businessName": businessName,
      "businessAddress": businessAddress,
      "description": description,
      "phoneNumber": phoneNumber,
      "businessCard": businessCard,
      "businessLogo": businessLogo,
      "businessImage": businessImage,
      "menuImage": menuImage,
      "menuImage2": menuImage2,
      "fromTimeToTime": fromTimeToTime,
      "position": position!.data,
      'day': dayTime,
      'day_late': daytimeLate,
      'time': time,
      'foodName': foodNames,
      'drinkitemName': drinkitemNames,
      "dailyspecial": dailySpecial,
      "amenities": amenities,
      "barType": barType,
      "event": event,
      "favorite_users": [],
      "latitude": latLong["latitude"],
      "longitude": latLong["longitude"],
      "status": "pending",
      "addHappyhourTime": DateTime.now(),
      "paid": paid,
    });
  }

  // Future uploadMenuImageImageToFirebaseStorage(
  //     {required String menuImage}) async {
  //   //for generating the unique id
  //   final DateTime now = DateTime.now();
  //   final int millSeconds = now.microsecondsSinceEpoch;
  //   final String imagename = (millSeconds.toString());
  //   //Converting the imageurl into the file
  //   File imageFile = File(menuImage);
  //   // Get.find<AddHappyhourController>().isLoading = true;
  //   //Upload the menuImage to the firebase Storage
  //   firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
  //       .FirebaseStorage.instance
  //       .ref('menu_images/$imagename')
  //       .putFile(imageFile);
  //   String menuImageAccessUrl = await taskSnapshot.ref.getDownloadURL();
  //   // Get.find<AddHappyhourController>().isLoading = false;
  //   return menuImageAccessUrl;
  // }

  // Future uploadGuestBusinessImageToFirebaseStorage(
  //     {required String businessImage}) async {
  //   //for generating the unique id
  //   final DateTime now = DateTime.now();
  //   final int millSeconds = now.microsecondsSinceEpoch;
  //   final String imagename = (millSeconds.toString());
  //   //Converting the imageurl into the file
  //   File imageFile = File(businessImage);
  //   // Get.find<AddHappyhourController>().isLoading = true;
  //   //Upload the businessImage to the firebase Storage
  //   firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
  //       .FirebaseStorage.instance
  //       .ref('business_Image/$imagename')
  //       .putFile(imageFile);
  //   String guestBusinessImageAccessUrl =
  //       await taskSnapshot.ref.getDownloadURL();
  //   // Get.find<AddHappyhourController>().isLoading = false;
  //   return guestBusinessImageAccessUrl;
  // }

  Future uploadBusinessCardImageToFirebaseStorage(
      {required String businessCard}) async {
    //for generating the unique id
    final DateTime now = DateTime.now();
    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file
    File imageFile = File(businessCard);
    //Get.find<AddHappyhourBusinessController>().isLoading = true;
    //Upload the Business Card Image to the firebase Storage
    firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('business_card/$imagename')
        .putFile(imageFile);
    String businessCardAccessUrl = await taskSnapshot.ref.getDownloadURL();

    // Get.find<AddHappyhourBusinessController>().isLoading = false;
    return businessCardAccessUrl;
  }

  Future uploadBusinessLogoToFirebaseStorage(
      {required String businessLogo}) async {
    //for generating the unique id
    final DateTime now = DateTime.now();
    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file
    File imageFile = File(businessLogo);
    // Get.find<AddHappyhourBusinessController>().isLoading = true;
    //Upload the Business Logo Image to the firebase Storage
    firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('business_logo/$imagename')
        .putFile(imageFile);
    String businessLogoAccessUrl = await taskSnapshot.ref.getDownloadURL();
    //Get.find<AddHappyhourBusinessController>().isLoading = false;
    return businessLogoAccessUrl;
  }

  Future uploadBusinessImageToFirebaseStorage(
      {required String businessImage}) async {
    //for generating the unique id
    final DateTime now = DateTime.now();
    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file
    File imageFile = File(businessImage);
    // Get.find<AddHappyhourBusinessController>().isLoading = true;
    //Upload the BusinessImage to the firebase Storage
    firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('business_Image/$imagename')
        .putFile(imageFile);
    String businessImageAccessUrl = await taskSnapshot.ref.getDownloadURL();

    //Get.find<AddHappyhourBusinessController>().isLoading = false;
    return businessImageAccessUrl;
  }

  Future uploadBusinessMenuImageImageToFirebaseStorage(
      {required String menuImage}) async {
    //for generating the unique id
    final DateTime now = DateTime.now();
    final int millSeconds = now.microsecondsSinceEpoch;
    final String imagename = (millSeconds.toString());
    //Converting the imageurl into the file
    File imageFile = File(menuImage);
    // Get.find<AddHappyhourBusinessController>().isLoading = true;
    //Upload the menuImage to the firebase Storage
    firebase_storage.TaskSnapshot taskSnapshot = await firebase_storage
        .FirebaseStorage.instance
        .ref('menu_images/$imagename')
        .putFile(imageFile);
    String menuImageAccessUrl = await taskSnapshot.ref.getDownloadURL();
    // Get.find<AddHappyhourBusinessController>().isLoading = false;
    return menuImageAccessUrl;
  }

  Stream<List<HappyHourModel>> fetchHours() {
    return _firebaseFirestore
        .collection("happyhours")
        .limit(20)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      List<HappyHourModel> hourList = [];

      for (var doc in querySnapshot.docs) {
        hourList.add(HappyHourModel.mapDocument(doc));
      }
      return hourList;
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> fetchAllHappyhours() {
    return _firebaseFirestore.collection("happyhours").snapshots();
  }

  Stream<List<DocumentSnapshot>> fetchHourInradius(
      {required double rad, lat, long}) {
    var queryRef = _firebaseFirestore
        .collection("happyhours")
        .where('status', isEqualTo: "approve");
    String field = 'position';
    return geo.collection(collectionRef: queryRef).within(
        center: geo.point(latitude: lat, longitude: long),
        radius: rad,
        field: field,
        strictMode: true);
  }

  Future<void> addFieldToAllDocuments() async {
    QuerySnapshot querySnapshot =
        await _firebaseFirestore.collection("happyhours").get();
    querySnapshot.docs.forEach((document) async {
      // Create a Map with the field you want to add
      Map<String, dynamic> dataToUpdate = {
        'status': 'approve',
      };

      // Update the document with the new field
      await _firebaseFirestore
          .collection("happyhours")
          .doc(document.id)
          .update(dataToUpdate);
    });
  }

  Stream<List<DocumentSnapshot>> fetchFindHourInradius(
      {required double rad, lat, long}) {
    DateTime dateTime = DateTime.now();
    print(dateTime.day);
    var queryRef = _firebaseFirestore
        .collection("happyhours")
        .where("day", arrayContains: {'Hday': "Thursday"});
    String field = 'position';
    return geo.collection(collectionRef: queryRef).within(
        center: geo.point(latitude: lat, longitude: long),
        radius: rad,
        field: field,
        strictMode: true);
  }

  Future deleteHour(String id) async {
    try {
      await _firebaseFirestore.collection("happyhours").doc(id).delete();
    } catch (e) {
      return false;
    }
  }
  // Stream<DocumentSnapshot<Map<String, dynamic>>> getHour(
  //     {required String hourId}) {
  //   return _firebaseFirestore.collection("happyhours").doc(hourId).snapshots();
  // }

  Future<Map<String, dynamic>> updateHourInFirebase({
    required String docId,
    String? id,
    String? businessName,
    String? businessAddress,
    String? description,
    String? phoneNumber,
    String? businessCard,
    String? businessLogo,
    String? businessImage,
    String? menuImage,
    required String? menuImage2,
    List? fromTimeToTime,
    List? dayTime,
    List? time,
    List? foodNames,
    List? daytimeLate,
    List? drinkitemNames,
    List? amenities,
    List? barType,
    List? dailySpecial,
    List? event,
    required Map<String, dynamic> latLong,
    GeoFirePoint? position,
  }) async {
    Map<String, dynamic> json = {
      "id": id,
      "businessName": businessName,
      "businessAddress": businessAddress,
      "description": description,
      "phoneNumber": phoneNumber,
      "businessCard": businessCard,
      "businessLogo": businessLogo,
      "businessImage": businessImage,
      "menuImage": menuImage,
      "menuImage2": menuImage2,
      "fromTimeToTime": fromTimeToTime,
      "position": position!.data,
      'day': dayTime,
      'day_late': daytimeLate,
      'time': time,
      'foodName': foodNames,
      'drinkitemName': drinkitemNames,
      "dailyspecial": dailySpecial,
      "amenities": amenities,
      "barType": barType,
      "event": event,
      "latitude": latLong["latitude"],
      "longitude": latLong["longitude"],
      "addHappyhourTime": DateTime.now(),
    };

    await _firebaseFirestore.collection("happyhours").doc(docId).update(json);
    var snap =
        await _firebaseFirestore.collection("happyhours").doc(docId).get();

    return snap.data() as Map<String, dynamic>;
  }
}

// getAllData() async {
//   QuerySnapshot hours =
//       await FirebaseFirestore.instance.collection("happyhours").get();
//   print(hours);
//   for (var hour in hours.docs) {
//     HappyHourModel happy =
//         HappyHourModel.fromJson(jsonDecode(hour.data().toString()), hour.id);
//     happyHourModelDataList.add(happy);
//   }
// }

// Future<List<HappyHourModel>> getAllHour() async {
//   List<HappyHourModel> hours = [];
//   try {
//     DataSnapshot snapshot =
//         await _firebaseFirestore.collection("happyhours").get();
//     if (snapshot.value != null) {
//       Map newhour = Map.from(snapshot.value);
//       newhour.forEach((key, value) {
//         HappyHourModel hourModel = HappyHourModel.fromJson(Map.from(value), key);
//         hours.add(hourModel);
//       });
//     }
//     return hours;
//   } catch (e) {
//     rethrow;
//   }
// }

// final happyhourSearchQuery = FirebaseFirestore.instance
//     .collection("happyhours")
//     // .orderBy("latitude")
//     // .orderBy("longitude")
//     .orderBy("addHappyhourTime", descending: true)
//     .withConverter(
//       fromFirestore: (snapshot, _) =>
//           HappyHourModel.fromJson(snapshot.data()!, snapshot.id),
//       toFirestore: (happyHourData, _) => happyHourData.toJson(),
//     );
