import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';

import '../../global_widgets/custom_card.dart';
import '../../routes/app_routes.dart';

class ClaimYourBusinessScreen extends StatelessWidget {
  const ClaimYourBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
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
        title: const Text("Claim Your Business"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
          SizedBox(
            height: H * 0.03,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "In order to claim a business you have to create a business account.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: H * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.createBusinessAccountScreen,
                  arguments: "Sign Up");
            },
            child: CustomCard(
              height: H * 0.1,
              title: "Create Business Account",
              image: "assets/icons/Group 11452.svg",
            ),
          ),
          SizedBox(
            height: H * 0.01,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.loginScreen);
            },
            child: CustomCard(
                height: H * 0.1,
                title: "Login to Business Account",
                image: "assets/icons/Group 11409.svg"),
          ),
          SizedBox(
            height: H * 0.05,
          ),
        ]),
      ),
    );
  }
}
