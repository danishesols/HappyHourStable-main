import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/report/report_controller.dart';

import '../../core/colors.dart';
import '../../global_widgets/main_button.dart';
import '../../global_widgets/upload_image_card.dart';

class ReportScreen extends GetView<ReportController> {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomCircleIndicator(
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
            title: const Text("Report/Flag"),
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
                    "You can report business page here",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: H * 0.2,
                    child: CustomTextFieldWidget(
                      textEditingController: controller.reportController,
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
                  const Text(
                    "Add Updated Happy Hour Menu",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: H * 0.01,
                  ),
                  const Text(
                    "Multiple Happy Hour Menu images can be uploaded",
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Obx(
                    () => controller.happyHourMultiImages.isEmpty
                        ? UploadImageCard(
                            title: "Upload Menu Images",
                            onpressed: () {
                              dialogueCard(
                                  context,
                                  "Add From Gallery",
                                  () {
                                    Navigator.pop(context);
                                    controller.pickMultiMenuImage();
                                  },
                                  "Open Camera",
                                  () {
                                    Navigator.pop(context);
                                    controller.pickSingleHappyHourMenuImage();
                                  });
                            },
                          )
                        : Center(
                            child: GestureDetector(
                                onTap: () {
                                  dialogueCard(
                                      context,
                                      "Add From Gallery",
                                      () {
                                        Navigator.pop(context);
                                        controller.pickMultiMenuImage();
                                      },
                                      "Open Camera",
                                      () {
                                        Navigator.pop(context);
                                        controller
                                            .pickSingleHappyHourMenuImage();
                                      });
                                },
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      controller.happyHourMultiImages.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Stack(
                                      children: [
                                        Image.file(
                                          File(controller
                                              .happyHourMultiImages[index]),
                                          width: W,
                                          height: H * 0.2,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 5,
                                          child: IconButton(
                                              onPressed: () {
                                                controller.happyHourMultiImages
                                                    .removeAt(index);
                                              },
                                              icon: const Icon(
                                                Icons.cancel_outlined,
                                                size: 40,
                                                color: Colors.red,
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                  ),
                  SizedBox(
                    height: H * 0.05,
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [],
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
            child: SizedBox(
              height: H * 0.09,
              width: W,
              child: CustomElevatedButtonWidget(
                onPressed: () async {

                  await controller
                      .addReportOnHour(controller.hourid);

                },
                text: "Submit",
                textColor: blackColor,
                fontSize: 24,
                verticalPadding: 0,
                borderRadius: 45,
              ),
            ),
          ),
        ),
        isEnabled: controller.isLoading.value,
        opacity: 0.5));
  }
}

Future<dynamic> dialogueCard(
  BuildContext context,
  String buttonText,
  VoidCallback onConfrim,
  String buttonText2,
  VoidCallback onConfrim2,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/Group 2062.png"),
                    ),
                  ),
                ),
              ),
              onTap: () {
                Get.back();
              },
            ),
            SizedBox(
              height: H * 0.01,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 20,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 20,
                textColor: blackColor,
                text: (buttonText),
                onPressed: onConfrim,
              ),
            ),
            SizedBox(
              height: H * 0.01,
            ),
            Center(
              child: CustomElevatedButtonWidget(
                horizontalPadding: 30,
                verticalPadding: 22,
                borderRadius: 35,
                fontSize: 20,
                textColor: blackColor,
                text: (buttonText2),
                onPressed: onConfrim2,
              ),
            ),
            SizedBox(height: H * 0.03),
          ],
        ),
      );
    },
  );
}
