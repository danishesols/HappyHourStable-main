import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

class PasswordUpdatedScreen extends StatelessWidget {
  const PasswordUpdatedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: H * 0.05,
          ),
          Center(
            child: Image(
              image: const AssetImage(
                "assets/icons/Group 10966.png",
              ),
              height: H * 0.17,
              width: W * 0.6,
            ),
          ),
          SizedBox(
            height: H * 0.05,
          ),
          const Center(
            child: Text(
              "Password Updated",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: H * 0.03,
          ),
          const Center(
            child: Text(
              "Your Password Has been updated!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(
            height: H * 0.04,
          ),
          SizedBox(
            height: H * 0.09,
            width: W,
            child: CustomElevatedButtonWidget(
              onPressed: () {
                Get.offNamed(Routes.loginScreen);
              },
              text: "Log In",
              textColor: blackColor,
              fontSize: 24,
              verticalPadding: 0,
              borderRadius: 45,
            ),
          ),
        ]),
      ),
    );
  }
}
