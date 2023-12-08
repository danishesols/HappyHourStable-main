import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_business_form/add_manually.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_controller.dart';

class GuestFormScreen extends GetView<GuestController> {
  const GuestFormScreen({Key? key}) : super(key: key);

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
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: RawScrollbar(
          thumbColor: primary,
          // trackColor: whiteColor,
          // thumbVisibility: true,
          // trackVisibility: true,
          radius: const Radius.circular(20),
          thickness: 10,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: ListView(
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
                  topText("Business Information"),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  CustomTextFieldWidget(
                    onTap: () => controller.onBusinessNameClick(),
                    readOnly: true,
                    hintText: "Business name",
                    textEditingController: controller.businessNameController,
                    keyboardType: TextInputType.text,
                    validator: controller.businessNameValidator,
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  CustomTextFieldWidget(
                    //onTap: () => controller.onAddressClick(),
                    readOnly: true,
                    hintText: "Full Address",
                    textEditingController: controller.businessAddressController,
                    keyboardType: TextInputType.text,
                    validator: controller.businessAddressValidator,
                  ),
                  SizedBox(
                    height: H * 0.03,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() =>  GuestManually());
                    },
                    child: const Center(
                      child: Text(
                        "Add Manually",
                        style: TextStyle(
                          fontSize: 20,
                          color: primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: H * 0.02,
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  // Row(
                  //   children: [
                  //     topText("Business Card"),
                  //     SizedBox(
                  //       width: W * 0.02,
                  //     ),
                  //     Image.asset(
                  //       "assets/icons/Group 11537.png",
                  //       height: H * 0.025,
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // Obx(
                  //   () => controller.businessCard == ""
                  //       ? UploadImageCard(
                  //           title:
                  //               "Upload Business Card or Proof of Ownership/Managemant",
                  //           onpressed: () {
                  //             dialogueCard(
                  //                 context,
                  //                 "Add From Gallery",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller.uploadBusinessCard(
                  //                       ImageSource.gallery);
                  //                 },
                  //                 "Open Camera",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller
                  //                       .uploadBusinessCard(ImageSource.camera);
                  //                 });
                  //           },
                  //         )
                  //       : Center(
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               dialogueCard(
                  //                   context,
                  //                   "Add From Gallery",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessCard(
                  //                         ImageSource.gallery);
                  //                   },
                  //                   "OpenCamera",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessCard(
                  //                         ImageSource.camera);
                  //                   });
                  //             },
                  //             child: Image.file(
                  //               File(controller.businessCard),
                  //               width: W * 0.86,
                  //               height: H * 0.2,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // topText("Business Logo"),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // Obx(
                  //   () => controller.businessLogo == ""
                  //       ? UploadImageCard(
                  //           title: "Upload Business Logo",
                  //           onpressed: () {
                  //             dialogueCard(
                  //                 context,
                  //                 "Add From Gallery",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller.uploadBusinessLogo(
                  //                       ImageSource.gallery);
                  //                 },
                  //                 "Open Camera",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller
                  //                       .uploadBusinessLogo(ImageSource.camera);
                  //                 });
                  //             // controller.uploadBusinessLogo();
                  //           },
                  //         )
                  //       : Center(
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               dialogueCard(
                  //                   context,
                  //                   "Add From Gallery",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessLogo(
                  //                         ImageSource.gallery);
                  //                   },
                  //                   "Open Camera",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessLogo(
                  //                         ImageSource.camera);
                  //                   });
                  //             },
                  //             child: Image.file(
                  //               File(controller.businessLogo),
                  //               width: W * 0.86,
                  //               height: H * 0.2,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // topText("Business Image"),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  // Obx(
                  //   () => controller.businessImage == ""
                  //       ? UploadImageCard(
                  //           title: "Upload Business Image",
                  //           onpressed: () {
                  //             dialogueCard(
                  //                 context,
                  //                 "Add From Gallery",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller.uploadBusinessImage(
                  //                       ImageSource.gallery);
                  //                 },
                  //                 "Open Camera",
                  //                 () {
                  //                   Navigator.pop(context);
                  //                   controller.uploadBusinessImage(
                  //                       ImageSource.camera);
                  //                 });
                  //             // controller.uploadBusinessImage();
                  //           },
                  //         )
                  //       : Center(
                  //           child: GestureDetector(
                  //             onTap: () {
                  //               dialogueCard(
                  //                   context,
                  //                   "Add From Gallery",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessImage(
                  //                         ImageSource.gallery);
                  //                   },
                  //                   "Open Camera",
                  //                   () {
                  //                     Navigator.pop(context);
                  //                     controller.uploadBusinessImage(
                  //                         ImageSource.camera);
                  //                   });
                  //             },
                  //             child: Image.file(
                  //               File(controller.businessImage),
                  //               width: W * 0.86,
                  //               height: H * 0.2,
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ),
                  // ),
                  // SizedBox(
                  //   height: H * 0.02,
                  // ),
                  topText("Happy Hour Menu"),
                  const SizedBox(height: 8.0),
                  const Padding(
                    padding: EdgeInsets.only(left: 0.0),
                    child: Text("Multiple Happy Hour Menu images can be uploaded"),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Obx(
                    () => controller.happyHourMultiImages.isEmpty
                        ? UploadImageCard(
                            title: "Upload Menu Image",
                            onpressed: () {
                              dialogueCard(
                                  context,
                                  "Add From Gallery",
                                  () {
                                    Navigator.pop(context);
                                    controller.uploadMultiMenuImage();
                                  },
                                  "Open Camera",
                                  () {
                                    Navigator.pop(context);
                                    controller.uploadHappyHourMenuImage();
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
                                        controller.uploadMultiMenuImage();
                                      },
                                      "Open Camera",
                                      () {
                                        Navigator.pop(context);
                                        controller.uploadHappyHourMenuImage();
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
                                              .happyHourMultiImages[index]
                                              .path),
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
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, bottom: 30.0),
        child: SizedBox(
          height: H * 0.09,
          width: W,
          child: CustomElevatedButtonWidget(
            onPressed: () {
              controller.onBusinessnextTap();
            },
            verticalPadding: 0,
            text: "Next",
            textColor: blackColor,
            fontSize: 24,
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
