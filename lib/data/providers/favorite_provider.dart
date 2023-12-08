import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/hour_favorite_model.dart';
import 'package:happy_hour_app/data/providers/user_provider.dart';

import '../../global_controller/auth_controller.dart';
import '../../global_controller/global_general_controller.dart';
import '../models/user_model.dart';

class FavoriteProvider {
  final UserProvider _userProvider = UserProvider();
  final FirebaseFirestore _firebase = FirebaseFirestore.instance;

  Query<HoursFavoriteModel> favoriteHoursQuery({required String userId}) {
    return _firebase
        .collection("happyhours")
        .where("favorite_users", arrayContains: userId)
    .orderBy('position', descending: true)
        .withConverter<HoursFavoriteModel>(
          fromFirestore: (snapshot, _) => HoursFavoriteModel.fromJson(snapshot),
          toFirestore: (hours, _) => {},
        );
  }

  Query<HoursFavoriteModel> claimHoursQuery({required String userId}) {
    return _firebase
        .collection("happyhours")
        .where("claimed_users_ids", arrayContains: userId)
        .withConverter<HoursFavoriteModel>(
          fromFirestore: (snapshot, _) => HoursFavoriteModel.fromJson(snapshot),
          toFirestore: (hours, _) => {},
        );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getHour(
      {required String hourId}) {
    return _firebase.collection("happyhours").doc(hourId).snapshots();
  }

  // * doing hour favorite methods starts from here

  changeHourFavoriteStatus({
    required String hourId,
    required String userId,
    required bool previousState,
  }) async {
    // * If the card's favorite previous state is true before, it means user has un-favorited the hour this time so remove him/her from the users ids collection of this hour as well as hour id from user's hour ids collection.
    if (previousState) {
      removeUserIdFromUsersIdsListOfHourDocument(
          hourId: hourId, userId: userId);
      removeHourIdFromHoursIdsListOfUserDocument(
          hourId: hourId, userId: userId);
      _userProvider
          .getUserSnapshotById(uid: Get.find<AuthController>().user.uid)
          .listen((doc) {
        Get.find<AuthController>().user = UserModel.fromDocument(doc);
      });
    }
    // * And if card's favorite previous state is false before, it means user has just favorited the hour and he/she is not in the users ids collection of Hours. So add him/her. Also add hour id is user's hours ids collection.
    else {
      addHourIdInHourIdsListOfUserDocument(hourId: hourId, userId: userId);
      addUserIdInUserIdsListOfHourDocument(hourId: hourId, userId: userId);

      _userProvider
          .getUserSnapshotById(uid: Get.find<AuthController>().user.uid)
          .listen((doc) {
        Get.find<AuthController>().user = UserModel.fromDocument(doc);
      });
    }
  }

  addUserIdInUserIdsListOfHourDocument({
    required String hourId,
    required String userId,
  }) async {
    _firebase.collection("happyhours").doc(hourId).update({
      "favorite_users": FieldValue.arrayUnion([userId])
    });
  }

  addHourIdInHourIdsListOfUserDocument({
    required String hourId,
    required String userId,
  }) async {
    await _firebase.collection("users").doc(userId).update({
      "favorite_hours": FieldValue.arrayUnion([hourId])
    });
  }

  removeUserIdFromUsersIdsListOfHourDocument({
    required String hourId,
    required String userId,
  }) async {
    _firebase.collection("happyhours").doc(hourId).update({
      "favorite_users": FieldValue.arrayRemove([userId]),
    });
  }

  removeHourIdFromHoursIdsListOfUserDocument({
    required String hourId,
    required String userId,
  }) async {
    await _firebase.collection("users").doc(userId).update({
      "favorite_hours": FieldValue.arrayRemove([hourId])
    });
  }

//*Claimed hours
  claimedHour({
    required String hourId,
    required String userId,
  }) {
    _firebase.collection("users").doc(userId).update({
      "claimed_hours": FieldValue.arrayUnion([hourId])
    });
    _firebase.collection("happyhours").doc(hourId).update({
      "claimed_users_ids": FieldValue.arrayUnion([userId]),
    }).then((value) => {
          Get.find<GlobalGeneralController>().successSnackbar(
              title: "Claimed", description: "CLaimed Happy Hour")
        });
    _userProvider
        .getUserSnapshotById(uid: Get.find<AuthController>().user.uid)
        .listen((doc) {
      Get.find<AuthController>().user = UserModel.fromDocument(doc);
    });
  }

  promoteHour({
    required String hourId,
    required String userId,
  }) {
    _firebase.collection("users").doc(userId).update({
      "promote_hour": FieldValue.arrayUnion(
        [hourId],
      )
    });
    _firebase.collection("happyhours").doc(hourId).update({
      "promote_users_ids": FieldValue.arrayUnion([userId]),
    }).then((value) => {
          Get.find<GlobalGeneralController>().successSnackbar(
              title: "Promoted", description: "Happy Hour Promoted")
        });

    _userProvider
        .getUserSnapshotById(uid: Get.find<AuthController>().user.uid)
        .listen((doc) {
      Get.find<AuthController>().user = UserModel.fromDocument(doc);
    });
  }
}
