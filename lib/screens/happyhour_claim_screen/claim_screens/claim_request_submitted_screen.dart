import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

class EditRequestSubmittedScreen extends StatelessWidget {
  const EditRequestSubmittedScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(
                  height: H * 0.02,
                ),
                Center(
                  child: Image(
                    image: const AssetImage(
                      "assets/icons/Group 8550@2x.png",
                    ),
                    height: H * 0.22,
                    width: W * 0.6,
                  ),
                ),
                SizedBox(
                  height: H * 0.03,
                ),
                const Center(
                  child: Text(
                    "Happy hour request submitted",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.03,
                ),
                const Center(
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Suspendisse fermentum consectetur enim",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: Center(
                child: SizedBox(
                  height: H * 0.09,
                  width: W,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      Get.offAllNamed(Routes.businessAccountHomeScreen);
                    },
                    verticalPadding: 0,
                    text: "Done",
                    textColor: blackColor,
                    fontSize: 24,
                    borderRadius: 45,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
