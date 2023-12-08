import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';

import '../models/happyhour_model.dart';
import '../models/review_model.dart';

class AddReviewProvider {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Query<HoursFavoriteModel> reviewHoursQuery({required String userId}) {
  //   return _firebaseFirestore
  //       .collection("happyhours")
  //       .where("reviewId", arrayContains: userId)
  //       .withConverter<HoursFavoriteModel>(
  //         fromFirestore: (snapshot, _) => HoursFavoriteModel.fromJson(snapshot),
  //         toFirestore: (hours, _) => {},
  //       );
  // }

  Query<HappyHourModel> reviewQuery({required String userId}) {
    return _firebaseFirestore
        .collection("happyhours")
        .where("id", isEqualTo: userId)
        .withConverter<HappyHourModel>(
          fromFirestore: (snapshot, _) =>
              HappyHourModel.fromDocument(snapshot, snapshot.id),
          toFirestore: (hours, _) => {},
        );
  }

  addReviewOnHappyHour({
    required ReviewModel model,
  }) async {

    await _firebaseFirestore.collection("happyHourReviews").doc().set(
      model.toJson(),
    ).then((value) => Get.find<GlobalGeneralController>()
        .successSnackbar(title: "Review", description: "Review added"));
  }

  addCountOnHappyHour({
    required String hourId,
    required int count,
  }) async {
    await _firebaseFirestore.collection("happyhours").doc(hourId).update(
      {
        "countList": FieldValue.arrayUnion([count]),
      },
    );
  }

  reportHappyHour({
    required String hourId,
    required String userId,
    required String reportText,
    required List<String> images,
  }) async {
    await _firebaseFirestore.collection("reportedHours").doc(hourId).set({
      "reportTime": DateTime.now(),
      "reportText": reportText,
      'uid': userId,
      'hourId': hourId,
      'reportImages': images,
      'status': 'pending',
    }).then((value) => Get.find<GlobalGeneralController>()
        .successSnackbar(title: "Report", description: "Report Submitted "),);
  }

  promoted({
    required String hourId,
    required bool isPromoted,
  }) async {
    await _firebaseFirestore
        .collection("happyhours")
        .doc(hourId)
        .update({"promoted": isPromoted});
  }
}
