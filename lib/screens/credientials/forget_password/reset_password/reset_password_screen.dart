import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/reset_password/reset_password_controller.dart';

import '../../../../global_widgets/circular_indicator.dart';

class ResetPasswordScreen extends GetView<ResetPasswordController> {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CustomCircleIndicator(
        opacity: 0.5,
        isEnabled: controller.isLoading,
        child: Scaffold(
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
            title: const Text("Forget Password"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: H * 0.05,
                    ),
                    Center(
                      child: Image(
                        image: const AssetImage(
                          "assets/icons/Group 10977@2x.png",
                        ),
                        height: H * 0.18,
                        width: W * 0.6,
                      ),
                    ),
                    SizedBox(
                      height: H * 0.05,
                    ),
                    const Center(
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    const Center(
                      child: Text(
                        "Please Enter your New Password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Obx(
                      () => CustomTextFieldWidget(
                        hintText: "New Password",
                        textEditingController:
                            controller.passwordFieldController,
                        obscureText: controller.obscurePassword,
                        validator: controller.validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.onShowPasswordTap();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: controller.obscurePassword
                                ? Image.asset(
                                    "assets/icons/Component Icon Hide.png",
                                    height: 30,
                                    width: 30,
                                  )
                                : Image.asset(
                                    "assets/icons/Group 11609@2x.png",
                                    height: 15,
                                    width: 15,
                                  ),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/icons/Icon material-lock-outline.png",
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.02,
                    ),
                    Obx(
                      () => CustomTextFieldWidget(
                        hintText: "Confirm New Password",
                        textEditingController:
                            controller.confirmpasswordFieldController,
                        obscureText: controller.obscurePasswordSecond,
                        validator: controller.validateConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.onShowPasswordTapSecond();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 24.0),
                            child: controller.obscurePasswordSecond
                                ? Image.asset(
                                    "assets/icons/Component Icon Hide.png",
                                    height: 30,
                                    width: 30,
                                  )
                                : Image.asset(
                                    "assets/icons/Group 11609@2x.png",
                                    height: 15,
                                    width: 15,
                                  ),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/icons/Icon material-lock-outline.png",
                            height: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: H * 0.06,
                    ),
                    SizedBox(
                      height: H * 0.09,
                      width: W,
                      child: CustomElevatedButtonWidget(
                        onPressed: () {
                          controller.validatePasswordsForm();
                          //Get.toNamed(Routes.passwordUpdatedScreen);
                        },
                        text: "Reset Password",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 0,
                        borderRadius: 50,
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
  }
}
