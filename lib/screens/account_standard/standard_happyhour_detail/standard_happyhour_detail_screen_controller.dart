import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/hour_favorite_model.dart';
import '../../../data/models/review_model.dart';
import '../../../data/models/user_model.dart';
import '../../../data/providers/favorite_provider.dart';
import '../../../global_controller/auth_controller.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../routes/app_routes.dart';

class StandardHappyhourDetailScreenController extends GetxController {
  final FavoriteProvider favoriteProvider = FavoriteProvider();
  final HappyHourModel happyHour = Get.arguments;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  HoursFavoriteModel hour = HoursFavoriteModel(
    hid: Get.arguments.hid,
    businessName: "",
    description: "",
    menuImage: "",
    businessImage: "",
  );

  //observable variables
  final _switchs = 0.obs;

  TextEditingController replyController = TextEditingController();
  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;

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

  // void hourIds() {
  //   hour = HoursFavoriteModel(
  //     hid: happyHour.id!,
  //     businessName: "",
  //     description: "",
  //     menuImage: "",
  //     businessImage: "",
  //   );
  //   update();
  // }
  List lateFoodList = [];
  List earlyFoodList = [];
  lateFoodItems() {
    for (var i = 0; i < happyHour.foodName!.length; i++) {
      if (happyHour.foodName?[i]['late'] == true) {
        lateFoodList.add(happyHour.foodName?[i]);
      }
      if (happyHour.foodName?[i]['early'] == true) {
        earlyFoodList.add(happyHour.foodName?[i]);
      }
    }
    // print(lateFoodList);
    // print(lateFoodList.length);
  }

  List lateDrinkList = [];
  List earlyDrinkList = [];
  lateDrinkItems() {
    for (var i = 0; i < happyHour.drinkitemName!.length; i++) {
      if (happyHour.drinkitemName?[i]['late'] == true) {
        lateDrinkList.add(happyHour.drinkitemName?[i]);
      }
      if (happyHour.drinkitemName?[i]['early'] == true) {
        earlyDrinkList.add(happyHour.drinkitemName?[i]);
      }
    }
    // print(lateDrinkList);
    // print(lateDrinkList.length);
  }

  List menuImageList = [];
  menuAllImages() {
    if (happyHour.menuImage != null) {
      menuImageList.add(happyHour.menuImage);
    }
    if (happyHour.menuImage2 != null) {
      menuImageList.add(happyHour.menuImage2);
    }
  }

  String id = Get.arguments.id;
  onAddreviewTap() {
    Get.toNamed(Routes.addReviewScreen, arguments: happyHour);
  }

  onAddreportTap() {
    Get.toNamed(Routes.reportScreen, arguments: hour.hid);
  }

  List sundayList = [];
  List mondayList = [];
  List tuesdayList = [];
  List wednesdayList = [];
  List thursdayList = [];
  List fridayList = [];
  List saturdayList = [];
  dailySpecialData() {
    for (var i = 0; i < happyHour.dailySpecils!.length; i++) {
      if (happyHour.dailySpecils?[i]['day'] == "Sunday") {
        sundayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Monday") {
        mondayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Tuesday") {
        tuesdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Wednesday") {
        wednesdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Thursday") {
        thursdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Friday") {
        fridayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Saturday") {
        saturdayList.add(happyHour.dailySpecils?[i]);
      }
    }
  }

  @override
  void onInit() {
    menuAllImages();
    lateFoodItems();
    lateDrinkItems();
    dailySpecialData();

    super.onInit();
  }

  final RxBool _show = false.obs;
  bool get show => _show.value;
  set show(value) => _show.value = value;

  void showReply() {
    show = !show;
  }

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not launch $url',
      );
    }
  }

  onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }

  bool makeDailySpecialVisible() {
    bool isVisible = sundayList.isNotEmpty &&
        mondayList.isNotEmpty &&
        tuesdayList.isNotEmpty &&
        wednesdayList.isNotEmpty &&
        thursdayList.isNotEmpty &&
        fridayList.isNotEmpty &&
        saturdayList.isNotEmpty;
    return isVisible;
  }

  void upgradeAccount(context) async {
    await Get.find<GlobalGeneralController>().yesOrNoDialog(
        context,
        'Upgrade Account',
        'Do you want to upgrade your account? \n Re-Login required',
        'YES',
        () async {
          await updateUserInfo(
            userId: Get.find<AuthController>().user.uid,
            information: {
              'isBusiness': true,
            },
          );
          Get.find<AuthController>().logoutUser();
        },
        'NO',
        () {
          Get.back();
        });
  }

  replyToReview(Replies reviewModel) async {
    final snap = await FirebaseFirestore.instance
        .collection('happyHourReviews')
         .where('hourId',isEqualTo: reviewModel.hourId).limit(1).get();
    if(snap.docs.isNotEmpty){
      // ReviewModel model  = ReviewModel.fromDoc(snap.docs[0].data());
      await FirebaseFirestore.instance
          .collection('happyHourReviews')
          .doc(snap.docs[0].id)
          .update({
        'replies': FieldValue.arrayUnion([
          reviewModel.toJson(),
        ]),
      });
      replyController.text ='';
      update();
    }
  }
}
