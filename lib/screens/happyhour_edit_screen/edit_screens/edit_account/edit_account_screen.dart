import 'dart:io';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_widgets/circular_indicator.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_account/edit_add_manually.dart';

import '../../../../core/colors.dart';
import '../../../../core/constants.dart';
import '../../../../global_widgets/main_button.dart';
import '../../../../global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_controller.dart';

class EditAccountScreen extends GetView<EditController> {
  const EditAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditController>(builder: (con) {
      return CustomCircleIndicator(
        isEnabled: controller.isLoading,
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
                        textEditingController:
                            controller.businessNameController,
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
                        textEditingController:
                            controller.businessAddressController,
                        keyboardType: TextInputType.text,
                        validator: controller.businessAddressValidator,
                      ),
                      SizedBox(
                        height: H * 0.03,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() =>  EditManually());
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
                      CustomTextFieldWidget(
                        hintText: "Phone number",
                        keyboardType: TextInputType.number,
                        textEditingController: controller.phonenumberController,
                        //validator: controller.validatePhoneNumber,
                      ),
                      SizedBox(
                        height: H * 0.02,
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
                        () => controller.businessCard == "" &&
                                controller.businessCardImage == null
                            ? UploadImageCard(
                                title:
                                    "Upload Business Card or Proof of Ownership/Managemant",
                                onpressed: () {
                                  controller.uploadBusinessCard(context);
                                },
                              )
                            : controller.businessCard != ""
                                ? controller.businessCardImage != null
                                    ? GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessCard(context),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(controller
                                                  .businessCardImage!.path),
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.fitWidth,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessCard = '';
                                                  controller.businessCardImage =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessCard(context),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              controller.businessCard,
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessCard = '';
                                                  controller.businessCardImage =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                : UploadImageCard(
                                    title:
                                        "Upload Business Card or Proof of Ownership/Managemant",
                                    onpressed: () {
                                      controller.uploadBusinessCard(context);
                                    },
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
                        () => controller.businessLogo == "" &&
                                controller.businessLogoImage == null
                            ? UploadImageCard(
                                title: "Upload Business Logo",
                                onpressed: () {
                                  controller.uploadBusinessLogo(context);
                                },
                              )
                            : controller.businessLogo != ""
                                ? controller.businessLogoImage != null
                                    ? GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessLogo(context),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(controller
                                                  .businessLogoImage!.path),
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessLogo = '';
                                                  controller.businessLogoImage =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessLogo(context),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              controller.businessLogo,
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessLogo = '';
                                                  controller.businessLogoImage =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                : UploadImageCard(
                                    title: "Upload Business Logo",
                                    onpressed: () {
                                      controller.uploadBusinessLogo(context);
                                    },
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
                        () => controller.businessImage == "" &&
                                controller.businessImageFile == null
                            ? UploadImageCard(
                                title: "Upload Business Image",
                                onpressed: () {
                                  controller.uploadBusinessImage(context);
                                },
                              )
                            : controller.businessImage != ""
                                ? controller.businessImageFile != null
                                    ? GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessImage(context),
                                        child: Stack(
                                          children: [
                                            Image.file(
                                              File(controller
                                                  .businessImageFile!.path),
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessImage = '';
                                                  controller.businessImageFile =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () => controller
                                            .uploadBusinessImage(context),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              controller.businessImage,
                                              width: W,
                                              height: H * 0.2,
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 5,
                                              child: InkWell(
                                                onTap: () {
                                                  controller.businessImage = '';
                                                  controller.businessImageFile =
                                                      null;
                                                  controller.update();
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                : UploadImageCard(
                                    title: "Upload Business Image",
                                    onpressed: () {
                                      controller.uploadBusinessImage(context);
                                    },
                                  ),
                      ),
                      SizedBox(
                        height: H * 0.02,
                      ),
                      topText("Happy Hour Menu"),
                      SizedBox(
                        height: H * 0.02,
                      ),
                      Obx(
                        () => controller.happyHourMenuImage == "" &&
                                controller.menuImageFiles.isEmpty
                            ? UploadImageCard(
                                title: "Upload Business Image",
                                onpressed: () {
                                  controller.uploadHappyHourMenuImage();
                                },
                              )
                            : controller.happyHourMenuImage != ""
                                ? controller.menuImageFiles.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () => controller
                                            .uploadHappyHourMenuImage(),
                                        child: Container(
                                          height: H * 0.3,
                                          width: W,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 4,
                                              color: primary,
                                            ),
                                          ),
                                          child: Swiper(
                                            itemCount:
                                            controller.menuImageFiles.length,
                                            pagination:
                                                const SwiperPagination(),
                                            viewportFraction: 1,
                                            scale: 1,
                                            loop: false,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Stack(
                                                children: [
                                                  Image.file(
                                                    File(controller.menuImageFiles[i]!.path),
                                                    width: W,
                                                    height: H * 0.3,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    top: 4,
                                                    right: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller
                                                            .removeMenuImageFromFiles(i);
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () => controller
                                            .uploadHappyHourMenuImage(),
                                        child: Container(
                                          height: H * 0.3,
                                          width: W,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 4,
                                              color: primary,
                                            ),
                                          ),
                                          child: Swiper(
                                            itemCount:
                                                controller.menuImageList.length,
                                            pagination:
                                                const SwiperPagination(),
                                            viewportFraction: 1,
                                            scale: 1,
                                            loop: false,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              return Stack(
                                                children: [
                                                  Image.network(
                                                    controller
                                                        .menuImageList[i]!,
                                                    width: W,
                                                    height: H * 0.3,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  Positioned(
                                                    top: 4,
                                                    right: 5,
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller
                                                            .removeMenuImage(i);
                                                      },
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                : UploadImageCard(
                                    title: "Upload Business Image",
                                    onpressed: () {
                                      controller.uploadHappyHourMenuImage();
                                    },
                                  ),
                      ),

                      ///-------- code menu images picking
                      // Obx(
                      //   () => controller.happyHourMenuImage == "" &&
                      //           controller.menuImageFiles.isEmpty
                      //       ? UploadImageCard(
                      //           title: "Upload Business Image",
                      //           onpressed: () {
                      //             controller.uploadHappyHourMenuImage();
                      //           },
                      //         )
                      //       : controller.happyHourMenuImage != ""
                      //           ? controller.menuImageFiles.isNotEmpty &&
                      //                   controller.menuImageFiles.first !=
                      //                       null
                      //               ? GestureDetector(
                      //                   onTap: () => controller
                      //                       .uploadHappyHourMenuImage(),
                      //                   child: Image.file(
                      //                     File(controller
                      //                         .menuImageFiles.first!.path),
                      //                     width: W * 0.86,
                      //                     height: H * 0.2,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 )
                      //               : GestureDetector(
                      //                   onTap: () => controller
                      //                       .uploadHappyHourMenuImage(),
                      //                   child: Image.network(
                      //                     controller.happyHourMenuImage,
                      //                     width: W,
                      //                     height: H * 0.2,
                      //                     fit: BoxFit.cover,
                      //                   ))
                      //           : UploadImageCard(
                      //               title: "Upload Business Image",
                      //               onpressed: () {
                      //                 controller.uploadHappyHourMenuImage();
                      //               },
                      //             ),
                      // ),
                      ///--------------
                      SizedBox(
                        height: H * 0.05,
                      ),
                      SizedBox(
                        height: H * 0.09,
                        width: W,
                        child: CustomElevatedButtonWidget(
                          onPressed: () async {
                            await controller
                                .updateBusinessHourToFireStore()
                                .then((value) {
                              Get.back();
                            });
                          },
                          verticalPadding: 0,
                          text: "Done",
                          textColor: blackColor,
                          fontSize: 24,
                          borderRadius: 45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
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
