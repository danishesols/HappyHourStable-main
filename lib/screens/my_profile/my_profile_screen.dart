import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/screens/my_profile/my_profile_controller.dart';
import 'package:intl/intl.dart';

import '../../core/colors.dart';
import '../../core/constants.dart';
import '../../global_controller/auth_controller.dart';
import '../../global_widgets/main_button.dart';
import '../../global_widgets/text_field.dart';

class MyProfileScreen extends GetView<MyProfileController> {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? time =
        Get.find<AuthController>().auth.currentUser?.metadata.creationTime;
    String formattedDate =
        DateFormat('MM-dd-yyyy').format(time ?? DateTime.now());

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
          ),
        ),
        title: const Text("My Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: controller.formGlobalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: H * 0.009,
                ),
                Center(
                  child: Obx(
                    () => controller.profileImageUrl == null ||
                            controller.profileImageUrl == ''
                        ? GestureDetector(
                            onTap: () {
                              controller.uploadProfileImage();
                            },
                            child: const CircleAvatar(
                              radius: 68,
                              backgroundImage:  AssetImage(
                                "assets/icons/Group 11411@2x.png",
                              ),
                            ),
                          )
                        : controller.profileImage == null
                            ? GestureDetector(
                                onTap: () {
                                  controller.uploadProfileImage();
                                },
                                child: CircleAvatar(
                                  radius: 68,
                                  backgroundImage: CachedNetworkImageProvider(
                                    Get.find<AuthController>()
                                        .user
                                        .profileImage
                                        .toString(),
                                  ),
                                ),
                              )
                            : Center(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.uploadProfileImage();
                                  },
                                  child: CircleAvatar(
                                    radius: 68,
                                    foregroundImage: FileImage(
                                      File(controller.profileImage!.path),
                                    ),
                                  ),
                                ),
                              ),

                    //  controller.profileImageUrl == ""
                    //     ? GestureDetector(
                    //         onTap: () {
                    //           controller.uploadProfileImage();
                    //         },
                    //         child: Get.find<AuthController>()
                    //                     .user
                    //                     .profileImage
                    //                     .toString() !=
                    //                 ""
                    //             ? CircleAvatar(
                    //                 backgroundColor: primary,
                    //                 radius: 58,
                    //                 backgroundImage:
                    //                     controller.profileImage == ""
                    //                         ? null
                    //                         : CachedNetworkImageProvider(
                    //                             Get.find<AuthController>()
                    //                                 .user
                    //                                 .profileImage
                    //                                 .toString(),
                    //                           ),
                    //               )
                    //             : Image(
                    //                 image: const AssetImage(
                    //                   "assets/icons/Group 983.png",
                    //                 ),
                    //                 height: H * 0.15,
                    //                 width: W * 0.4,
                    //               ),
                    //       )
                    //     : Center(
                    //         child: GestureDetector(
                    //           onTap: () {
                    //             controller.uploadProfileImage();
                    //           },
                    //           child: CircleAvatar(
                    //             radius: 80,
                    //             foregroundImage: FileImage(
                    //               File(controller.profileImage),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                Center(
                  child: Text(
                    "Joined: $formattedDate",
                    //"Joined: 08 aug, 2022",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Personal Information",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                CustomTextFieldWidget(
                  hintText: "First name",
                  textEditingController: controller.firstNameController,
                  keyboardType: TextInputType.text,
                  validator: controller.nameValidator,
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                CustomTextFieldWidget(
                  hintText: "Last name",
                  textEditingController: controller.lastNameController,
                  keyboardType: TextInputType.text,
                  validator: controller.nameValidator,
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                CustomTextFieldWidget(
                  hintText: "Email",
                  textEditingController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),
                SizedBox(
                  height: H * 0.02,
                ),
                // CustomTextFieldWidget(
                //   keyboardType: TextInputType.number,
                //   hintText: "Mobile Number",
                //   textEditingController: controller.mobileNumberController,
                //   validator: controller.validatePhoneNumber,
                // ),
                // SizedBox(
                //   height: H * 0.03,
                // ),
                SizedBox(
                  height: H * 0.076,
                  width: W,
                  child: CustomElevatedButtonWidget(
                    onPressed: () {
                      controller.updateProfileInfo();
                      Get.back();
                      Get.back();
                    },
                    text: "Update",
                    textColor: blackColor,
                    fontSize: 24,
                    verticalPadding: 0,
                    horizontalPadding: 0,
                    borderRadius: 45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class ProfileImage extends GetView<MyProfileController> {
//   const ProfileImage({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => CircleAvatar(
//         backgroundColor: whiteColor,
//         radius: 48,
//         backgroundImage: controller.profileImage == ""
//             ? null
//             : CachedNetworkImageProvider(controller.profileImage),
//         // : FileImage(File(controller.imageUrl)),
//         child: controller.profileImage == ""
//             ? Image.asset("assets/icons/Group 983.png")
//             : null,
//       ),
//     );
//   }
// }
