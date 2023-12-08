import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/account_business/claim_report/report_done_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/colors.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../global_widgets/main_button.dart';
import '../../../global_widgets/upload_Image_card.dart';
import '../../add_happyhour_business/add_happyhour_business.dart';
import 'clain_controller.dart';

class ClaimReportScreen extends StatelessWidget {
  final String hourId;
  const ClaimReportScreen({Key? key, required this.hourId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportController = TextEditingController();

    return GetBuilder<ClaimReportController>(builder: (con) {
      return CustomCircleIndicator(
        isEnabled: con.isLoading,
        opacity: 0.5,
        child: Scaffold(
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
            title: const Text("Send Report"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: GetBuilder<ClaimReportController>(
                init: ClaimReportController(),
                builder: (controller) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: H * 0.009,
                        ),
                        const Text(
                          "Describe Why This Business Belong to You?",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: H * 0.02,
                        ),
                        SizedBox(
                          height: H * 0.2,
                          child: CustomTextFieldWidget(
                            textEditingController: reportController,
                            borderRadius: 12,
                            maxLines: 8,
                            hintText: "Write Something",
                            elevation: 0,
                            blurRadius: 2,
                          ),
                        ),
                        SizedBox(
                          height: H * 0.05,
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
                          () => controller.busniessCard.value == ""
                              ? UploadImageCard(
                                  title:
                                      "Upload Business Card or Proof of Ownership/Managemant",
                                  onpressed: () async {
                                    await dialogueCard(
                                        context,
                                        "Add From Gallery",
                                        () {
                                          controller.uploadBusinessCard(
                                              ImageSource.gallery);
                                        },
                                        "Open Camera",
                                        () {
                                          Navigator.pop(context);
                                          controller.uploadBusinessCard(
                                              ImageSource.camera);
                                        });
                                  },
                                )
                              : Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await dialogueCard(
                                          context,
                                          "Add From Gallery",
                                          () {
                                            controller.uploadBusinessCard(
                                                ImageSource.gallery);
                                          },
                                          "Open Camera",
                                          () {
                                            controller.uploadBusinessCard(
                                                ImageSource.camera);
                                          });
                                    },
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            controller.busniessCard.value = "";
                                          },
                                          icon: const Icon(
                                            Icons.cancel_outlined,
                                            size: 40,
                                            color: Colors.red,
                                          ),
                                        ),
                                        Image.file(
                                          File(controller.busniessCard.value),
                                          width: W * 0.86,
                                          height: H * 0.2,
                                          fit: BoxFit.cover,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
            child: SizedBox(
              height: H * 0.09,
              width: W,
              child: GetBuilder<ClaimReportController>(builder: (controller) {
                return CustomElevatedButtonWidget(
                  onPressed: () async {
                    if (reportController.text.isNotEmpty &&
                        controller.busniessCard.value != '') {
                      await controller
                          .sendHappyHourClaimReport(reportController.text, hourId);
                      Get.to(() => const ClaimReportDone());
                      reportController.clear();
                    } else {
                      Get.find<GlobalGeneralController>().errorSnackbar(
                          title: "Error",
                          description: "Add Report Then Submit");
                    }
                  },
                  text: "Submit",
                  textColor: blackColor,
                  fontSize: 24,
                  verticalPadding: 0,
                  borderRadius: 45,
                );
              }),
            ),
          ),
        ),
      );
    });
  }
}
