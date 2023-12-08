import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../../data/models/review_model.dart';
import '../../data/providers/add_review_provider.dart';
import '../../global_controller/global_general_controller.dart';

class AddReviewController extends GetxController {
  final HappyHourModel hourid = Get.arguments;
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final reviewController = TextEditingController();

  double star = 3;

  bool isLoading = false;

  rating(double rating) {
    star = rating;
    update();
  }

  addReviewOnHour() async {
    if (reviewController.text.isNotEmpty) {
      isLoading = true;
      update();
      ReviewModel reviewModel = ReviewModel(
          showReplies: false,
          userName: Get.find<AuthController>().user.username,
          reviewText: reviewController.text,
          ratingCount: star,
          hourId: hourid.id!,
          userId: Get.find<AuthController>().user.uid,
          replies: [],
          userImageUrl: Get.find<AuthController>().user.profileImage);
      print(reviewModel.toJson());
      await _addReviewProvider.addReviewOnHappyHour(model: reviewModel);
      reviewController.clear();
      star = 0;
      isLoading = false;
      update();
      Get.back();
    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Review", description: "Please Write The Review");
    }
  }
}
