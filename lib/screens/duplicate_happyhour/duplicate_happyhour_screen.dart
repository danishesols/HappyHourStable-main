import 'dart:io';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_widgets/upload_Image_card.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_happyhour_controller.dart';
import 'package:happy_hour_app/screens/duplicate_happyhour/duplicate_show/duplicate_show_screen.dart';
import '../../../core/colors.dart';
import '../../../core/constants.dart';
import '../../../global_widgets/main_button.dart';
import '../../../global_widgets/text_field.dart';

class DuplicateBusinessAccountScreen extends GetView<DuplicateController> {
  const DuplicateBusinessAccountScreen({Key? key}) : super(key: key);

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
        title: const Text("New Business Info"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
              //topText("Business Information"),
              Row(
                children: [
                  topText("Business Information"),
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
              CustomTextFieldWidget(
                hintText: "Business name",
                textEditingController: controller.businessNameController,
                keyboardType: TextInputType.text,
                validator: controller.businessNameValidator,
              ),

              SizedBox(
                height: H * 0.02,
              ),
              CustomTextFieldWidget(
                onTap: () => controller.onBusinessAddressClick(),
                hintText: "Full Address",
                textEditingController: controller.businessAddressController,
                keyboardType: TextInputType.text,
                validator: controller.businessAddressValidator,
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

              topText("Business Card"),
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
                                onTap: () =>
                                    controller.uploadBusinessCard(context),
                                child: Image.file(
                                  File(controller.businessCardImage!.path),
                                  width: W * 0.86,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    controller.uploadBusinessCard(context),
                                child: Image.network(
                                  controller.businessCard,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
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
                                onTap: () =>
                                    controller.uploadBusinessLogo(context),
                                child: Image.file(
                                  File(controller.businessLogoImage!.path),
                                  width: W * 0.86,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    controller.uploadBusinessLogo(context),
                                child: Image.network(
                                  controller.businessLogo,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
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
                                onTap: () =>
                                    controller.uploadBusinessImage(context),
                                child: Image.file(
                                  File(controller.businessImageFile!.path),
                                  width: W * 0.86,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    controller.uploadBusinessImage(context),
                                child: Image.network(
                                  controller.businessImage,
                                  width: W,
                                  height: H * 0.2,
                                  fit: BoxFit.cover,
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
                        ? controller.menuImageFiles.isNotEmpty &&
                                controller.menuImageFiles.first != null
                            ? TheMenuImageSwiper(
                                isNetworkFiles: false,
                                menuImageList: controller.menuImageFiles,
                                onPressed: () {
                                  controller.uploadHappyHourMenuImage();
                                },
                              )
                            : TheMenuImageSwiper(
                                isNetworkFiles: true,
                                menuImageList: controller.menuImageList,
                                onPressed: () {
                                  controller.uploadHappyHourMenuImage();
                                },
                              )

                        // GestureDetector(
                        //                 onTap: () =>
                        //                     controller.uploadHappyHourMenuImage(),
                        //                 child: Image.network(
                        //                   controller.happyHourMenuImage,
                        //                   width: W,
                        //                   height: H * 0.2,
                        //                   fit: BoxFit.cover,
                        //                 ))
                        : UploadImageCard(
                            title: "Upload Business Image",
                            onpressed: () {
                              controller.uploadHappyHourMenuImage();
                            },
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
                    if (controller.businessNameController.text.isNotEmpty &&
                        controller.businessNameController.text !=
                            controller.firestoreObj.businessName) {
                      controller.firestoreObj.businessName =
                          controller.businessNameController.text;
                    }
                    if (controller.businessAddressController.text.isNotEmpty &&
                        controller.businessAddressController.text !=
                            controller.firestoreObj.businessAddress) {
                      controller.firestoreObj.businessAddress =
                          controller.businessAddressController.text;
                    }

                    if (controller.phonenumberController.text.isNotEmpty &&
                        controller.phonenumberController.text !=
                            controller.firestoreObj.phoneNumber) {
                      controller.firestoreObj.phoneNumber =
                          controller.phonenumberController.text;
                    }

                    Get.to(() => const DuplicateShowScreen());
                  },
                  verticalPadding: 0,
                  text: "Next",
                  textColor: blackColor,
                  fontSize: 24,
                  borderRadius: 45,
                ),
              ),
            ]),
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

class TheMenuImageSwiper extends StatelessWidget {
  const TheMenuImageSwiper(
      {Key? key,
      required this.isNetworkFiles,
      required this.menuImageList,
      required this.onPressed})
      : super(key: key);
  final List menuImageList;
  final bool isNetworkFiles;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: H * 0.3,
      width: W,
      child: Swiper(
        itemCount: menuImageList.length,
        pagination: const SwiperPagination(),
        viewportFraction: 1,
        scale: 1,
        loop: false,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            height: H * 0.3,
            width: W,
            decoration: BoxDecoration(
              border: Border.all(width: 4, color: primary),
            ),
            child: isNetworkFiles
                ? GestureDetector(
                    onTap: onPressed,
                    child: Image.network(
                      menuImageList[i]!,
                      width: W,
                      height: H * 0.2,
                      fit: BoxFit.cover,
                    ))
                : GestureDetector(
                    onTap: onPressed,
                    child: Image.file(
                      File(menuImageList[i]!.path),
                      width: W * 0.86,
                      height: H * 0.2,
                      fit: BoxFit.cover,
                    ),
                  ),
          );

          //  Image.network(
          //   controller.imageList[index],
          //   // controller.happyHour.businessImage?.toString() ??
          //   //     controller.happyHour.menuImage.toString(),
          //   fit: BoxFit.fitWidth,
          // );
        },
      ),
    );
  }
}
