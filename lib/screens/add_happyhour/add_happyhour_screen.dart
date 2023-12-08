import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/custom_card.dart';

import '../../routes/app_routes.dart';

class AddHappyhourScreen extends StatelessWidget {
  const AddHappyhourScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/Group 9108.svg",
              height: 25,
              width: 25,
            )),
        title: const Text("Add Happy Hour"),
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
          const Text(
            "You can chosse between these options",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: H * 0.02,
          ),
          CustomCard(
            onPressed: () {
              Get.toNamed(Routes.addHappyHourBusinessScreen);
            },
            height: H * 0.1,
            title: "Add Happy Hour",
            image: "assets/icons/Group 11452.svg",
          ),
          SizedBox(
            height: H * 0.02,
          ),
          CustomCard(
              onPressed: () {
                Get.toNamed(Routes.claimYourBusinessScreen);
              },
              height: H * 0.1,
              title: "Claim your Business",
              image: "assets/icons/Group 11409.svg"),
        ]),
      ),
    );
  }
}
