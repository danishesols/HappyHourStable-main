import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/user_model.dart';
import 'package:happy_hour_app/data/providers/add_review_provider.dart';
import 'package:happy_hour_app/data/providers/user_provider.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../edit_happyhour_screen/edit_happyhour_screen_controller.dart';

class CheckOutClaimScreenController extends GetxController {
  final id = Get.arguments;
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final RxBool _checkBoxmonthly = false.obs;
  bool get monthly => _checkBoxmonthly.value;
  set monthly(value) => _checkBoxmonthly.value = value;

  final RxBool _checkBoxAnnually = false.obs;
  bool get annually => _checkBoxAnnually.value;
  set annually(value) => _checkBoxAnnually.value = value;

  onPromotedClick() {
    _addReviewProvider.promoted(hourId: id, isPromoted: true);

    Get.find<EditHappyHourScreenController>().update();

    update();
    Get.back();
    Get.back();
    Get.find<GlobalGeneralController>().successSnackbar(
        title: "Promoted", description: "Happy Hour Promoted ");
  }

  void selectmonthly(bool value) {
    monthly = !monthly;
    annually = false;
  }

  void selectannually(bool value) {
    annually = !annually;
    monthly = false;
  }

  // * instances
  final UserProvider _userProvider = UserProvider();

  // * methods
  onSubscribeOrUnsubscribeTap() async {
    final _user = Get.find<AuthController>().user;

    if (_user.hasSubscription) {
      Get.defaultDialog(
        title: "Confirm",
        middleText: "Are you sure? This action will revert your subscription!",
        barrierDismissible: false,
        onCancel: () {},
        radius: 8,
        textConfirm: "Confirm",
        onConfirm: () async {
          // * cancel from stripe.
          final result = await _cancelStripeSubscription(_user);

          if (result["status"] == "canceled") {
            // * change status on firebase.
            await _userProvider.updateSubscriptionStatusInFirebase(
              userId: Get.find<AuthController>().user.uid,
              status: false,
            );

            Get.back();
            Get.find<GlobalGeneralController>().successSnackbar(
              title: "Success",
              description: "Your subscription has been cancelled.",
            );
          } else {
            Get.back();
            Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Failed",
              description: "Report this issue to support.",
            );
          }
        },
        confirmTextColor: Colors.black,
      );
    } else {
      final result = await _createStripeSession(_user);

      Get.toNamed(Routes.checkOutScreen, arguments: result.data);
    }
  }

  _createStripeSession(UserModel user) async {
    HttpsCallable callable2 =
        FirebaseFunctions.instance.httpsCallable('createSession');

    // * result will be the session id for stripe checkout.
    return await callable2.call(
      {
        "customer_id": user.stripeCustomerId,
      },
    );
  }

  _cancelStripeSubscription(UserModel user) async {
    final String? _id = await _userProvider.userStripeSubscriptionId(
        stripeCustomerId: user.stripeCustomerId ?? "");

    if (_id == null) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Failed",
        description: "Report this issue to support.",
      );
    } else {
      HttpsCallable callable2 =
          FirebaseFunctions.instance.httpsCallable('cancelSubscription');

      // * result will be the session id for stripe checkout.
      final result = await callable2.call(
        {
          "subscription_id": _id,
        },
      );

      return result.data;
    }
  }
}
