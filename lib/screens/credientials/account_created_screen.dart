import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';

import '../../routes/app_routes.dart';

class AccountCreatedScreen extends StatelessWidget {
  const AccountCreatedScreen({Key? key}) : super(key: key);

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
        title: const Text("Business Account"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: H * 0.009,
                ),
                Center(
                  child: Image(
                    image: const AssetImage(
                      "assets/icons/Group 8550.png",
                    ),
                    height: H * 0.23,
                    width: W * 0.6,
                  ),
                ),
                SizedBox(
                  height: H * 0.06,
                ),
                const Center(
                  child: Text(
                    "Account Created",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.03,
                ),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Suspendisse fermentum consectetur enim",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: H * 0.2,
                ),
                SizedBox(
                  height: H * 0.09,
                  width: W,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      Get.offNamed(Routes.businessAccountHomeScreen);
                    },
                    text: "Done",
                    textColor: blackColor,
                    fontSize: 24,
                    verticalPadding: 0,
                    borderRadius: 45,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
