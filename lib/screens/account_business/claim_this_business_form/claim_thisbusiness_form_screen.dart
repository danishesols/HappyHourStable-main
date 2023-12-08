import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/happyhour_claim_screen/claim_screens/claim_controller.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../global_widgets/main_button.dart';

class ClaimThisBusinessFormScreen extends GetView<ClaimController> {
  const ClaimThisBusinessFormScreen({Key? key}) : super(key: key);




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
        title: const Text("Claim This Business"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: H * 0.009,
            ),
            const Text(
              "Please Provide the Following information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Row(
              children: [
                topText("Business Card"),
                SizedBox(
                  width: W * 0.02,
                ),
                Image.asset(
                  "assets/icons/Group 11537.png",
                  height: H * 0.025,
                ),
              ],
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Obx(
              () => controller.businessCard == ""
                  ? UploadImageCard(
                      title:
                          "Upload Business Card or Proof of Ownership/Managemant",
                      onpressed: () {
                        controller.uploadBusinessCard();
                      },
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.uploadBusinessCard();
                        },
                        child: Image.file(
                          File(controller.businessCard),
                          width: W * 0.86,
                          height: H * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            topText("Business Logo"),
            SizedBox(
              height: H * 0.02,
            ),
            Obx(
              () => controller.businessLogo == ""
                  ? UploadImageCard(
                      title: "Upload Business Logo",
                      onpressed: () {
                        controller.uploadBusinessLogo();
                      },
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.uploadBusinessLogo();
                        },
                        child: Image.file(
                          File(controller.businessLogo),
                          width: W * 0.86,
                          height: H * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            topText("Business Image"),
            SizedBox(
              height: H * 0.02,
            ),
            Obx(
              () => controller.businessImage == ""
                  ? UploadImageCard(
                      title: "Upload Business Image",
                      onpressed: () {
                        controller.uploadBusinessImage();
                      },
                    )
                  : Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.uploadBusinessImage();
                        },
                        child: Image.file(
                          File(controller.businessImage),
                          width: W * 0.86,
                          height: H * 0.2,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
            ),
            // SizedBox(
            //   height: H * 0.05,
            // ),
            // SizedBox(
            //   height: H * 0.09,
            //   width: W,
            //   child: CustomElevatedButtonWidget(
            //     onPressed: () {

            //       //Get.toNamed(Routes.addHappyHourBusinessDetailScreen);
            //     },
            //     verticalPadding: 0,
            //     text: "Next",
            //     textColor: blackColor,
            //     fontSize: 24,
            //     borderRadius: 45,
            //   ),
            // ),
          ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 32),
        child: SizedBox(
          height: H * 0.09,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              controller.claimedHourTap();
            },
            text: "Next",
            textColor: blackColor,
            fontSize: 24,
            verticalPadding: 0,
            borderRadius: 45,
          ),
        ),
      ),
    );
  }
}

Text topText(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  );
}
