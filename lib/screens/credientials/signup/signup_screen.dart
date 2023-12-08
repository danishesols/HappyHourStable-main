import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/account_type_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../../../global_widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: H * 0.009,
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Center(
              child: Image(
                image: const AssetImage(
                  "assets/icons/Group 11411@2x.png",
                ),
                height: H * 0.25,
                width: W * 0.6,
              ),
            ),
            const Center(
              child: Text(
                "Please select your account type",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccountTypeCard(
                title: 'Standard Account',
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Suspendisse fermentum consectetur enim",
                textsecond: "Why you should subscribe",
                button: CustomElevatedButtonWidget(
                  verticalPadding: 0,
                  onPressed: () {
                    Get.toNamed(Routes.createStandardAccountScreen,
                        arguments: "Standard Account");
                  },
                  text: 'proceed',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccountTypeCard(
                title: 'Business  Account',
                text:
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Suspendisse fermentum consectetur enim",
                textsecond: "Why you should subscribe",
                button: CustomElevatedButtonWidget(
                  verticalPadding: 0,
                  onPressed: () {
                    Get.toNamed(Routes.createBusinessAccountScreen,
                        arguments: "Business Account");
                  },
                  text: 'proceed',
                ),
              ),
            ),
            SizedBox(
              height: H * 0.009,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't Have an Account?",
                  style: TextStyle(color: blackColor),
                ),
                TextButton(
                    onPressed: () {
                      Get.toNamed(Routes.loginScreen);
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: yellowTextColor,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
            SizedBox(
              height: H * 0.02,
            ),
          ]),
        ),
      ),
    );
  }
}
