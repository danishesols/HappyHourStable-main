import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/user_model.dart';
import '../../global_controller/auth_controller.dart';
import '../../global_controller/global_general_controller.dart';

class UserProvider {
  // * instances
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> createBusinessUser({required UserModel user}) async {
    try {
      await firestore.collection("users").doc(user.uid).set(
        {
          "profile_image": user.profileImage,
          "firstname": user.firstName,
          "lastname": user.lastName,
          "username": user.username,
          "email": user.email,
          "isBusiness": user.isBusiness
        },
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> createStandartUser({required UserModel user}) async {
    try {
      await firestore.collection("users").doc(user.uid).set(
        {
          "profile_image": user.profileImage,
          "firstname": user.firstName,
          "lastname": user.lastName,
          "username": user.username,
          "email": user.email,
          "isBusiness": user.isBusiness,
        },
      );
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  // Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStream(
  //     {required String userId}) {
  //   return firestore.collection("users").doc(userId).snapshots();
  // }

  Future<bool> updateUserInfo({
    required String userId,
    required Map<String, dynamic> information,
  }) async {
    try {
      await firestore.collection("users").doc(userId).update(information);

      Get.find<AuthController>().user = await getUserDocById(uid: userId);

      return true;
    } on FirebaseException catch (e) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: e.code,
        description: e.message.toString(),
      );
      return false;
    }
  }

  Future<String> uploadImage({required File file, required String uid}) async {
    try {
      // * save the image in the UsersImages folder with the user id as a name.
      TaskSnapshot taskSnapshot = await FirebaseStorage.instance
          .ref("ProfileImages/$uid")
          .putFile(file);

      String _imageUrl = await taskSnapshot.ref.getDownloadURL();

      return _imageUrl;
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print(e);
      return "";
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserSnapshotById({
    required String uid,
  }) {
    return firestore.collection("users").doc(uid).snapshots();
  }

  Future<UserModel> getUserDocById({required String uid}) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await firestore.collection("users").doc(uid).get();
      return UserModel.fromDocument(doc);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<String> createStripeCustomer({
    required String name,
    required String email,
    required String phoneNumber,
  }) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('registerCustomer');

    final result = await callable.call(
      {
        "name": name,
        "email": email,
        "phone": phoneNumber,
      },
    );

    return result.data;
  }

  Future<dynamic> retrieveStripeCustomer({required String customerId}) async {
    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable('retrieveCustomer');

    final result = await callable.call(
      {
        "customer_id": customerId,
      },
    );
    return result.data;
  }

  Future<bool> userStripeSubscriptionStatus(
      {required String stripeCustomerId}) async {
    // * retrieve stripe customer first.
    final customerObject = await retrieveStripeCustomer(
      customerId: stripeCustomerId,
    );
    // * then check either the customer has any subscription or not.
    final List customerSubcriptions = customerObject["subscriptions"]["data"];

    // * if it is not empty, it means customer has subscribed the subscription.
    if (customerSubcriptions.isNotEmpty) {
      // * in that case, check the subscription status. 0 means the first item of the subscription.
      return customerObject["subscriptions"]["data"][0]["status"] == "active"
          ? true
          : false;
    }

    return false;
  }

  Future<String?> userStripeSubscriptionId(
      {required String stripeCustomerId}) async {
    // * retrieve stripe customer first.
    final customerObject = await retrieveStripeCustomer(
      customerId: stripeCustomerId,
    );
    // * then check either the customer has any subscription or not.
    final List customerSubcriptions = customerObject["subscriptions"]["data"];

    // * if it is not empty, it means customer has subscribed the subscription.
    if (customerSubcriptions.isNotEmpty) {
      // * in that case, check the subscription status. 0 means the first item of the subscription.
      return customerObject["subscriptions"]["data"][0]["id"];
    }

    return null;
  }

  updateSubscriptionStatusInFirebase(
      {required String userId, required bool status}) {
    firestore.collection("users").doc(userId).update({
      "has_subscription": status,
    });
    getUserSnapshotById(uid: Get.find<AuthController>().user.uid).listen((doc) {
      Get.find<AuthController>().user = UserModel.fromDocument(doc);
    });
  }
}
