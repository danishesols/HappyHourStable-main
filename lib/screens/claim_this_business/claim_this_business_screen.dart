import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/claim_this_business/claim_this_business_controller.dart';
import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../global_widgets/main_button.dart';
import '../../global_widgets/text_field.dart';
import '../../routes/app_routes.dart';

class ClaimThisBusinessScreen extends GetView<ClaimThisBusinessController> {
  const ClaimThisBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClaimThisBusinessController>(
      builder: (controller) {
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
            title: const Text("Claim this Business"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: H * 0.009,
                    ),
                    const Text(
                      "Please fill out this form",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Row(
                      children: [
                        topText("Business Information"),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/icons/Group 11537.png",
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    const CustomTextFieldWidget(
                      hintText: "Business Name",
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    const CustomTextFieldWidget(
                      hintText: "Phone Number",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    const CustomTextFieldWidget(
                      hintText: "Full Address",
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Row(
                      children: [
                        topText("Business Card"),
                        const SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/icons/Group 11537.png",
                          height: 20,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Obx(
                      () => controller.claimBbusinessCard == ""
                          ? UploadImageCard(
                              title: "Upload Business Card",
                              onpressed: () {
                                controller.uploadClaimBusinessCard();
                              },
                            )
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.uploadClaimBusinessCard();
                                },
                                child: Image.file(
                                  File(controller.claimBbusinessCard),
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
                      () => controller.claimBusinessLogo == ""
                          ? UploadImageCard(
                              title: "Upload Business Logo",
                              onpressed: () {
                                controller.uploadclaimBusinessLogo();
                              },
                            )
                          : Center(
                              child: GestureDetector(
                                onTap: () {
                                  controller.uploadclaimBusinessLogo();
                                },
                                child: Image.file(
                                  File(controller.claimBusinessLogo),
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
                      () => controller.claimBusinessImage == ""
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
                                  File(controller.claimBusinessImage),
                                  width: W * 0.86,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: H * 0.05,
                    ),
                    SizedBox(
                      height: H * 0.09,
                      width: W,
                      child: CustomElevatedButtonWidget(
                        onPressed: () {
                          Get.toNamed(Routes.packagesScreen);
                        },
                        verticalPadding: 0,
                        text: "Next",
                        textColor: blackColor,
                        fontSize: 24,
                      ),
                    ),
                  ]),
            ),
          ),
        );
      },
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
