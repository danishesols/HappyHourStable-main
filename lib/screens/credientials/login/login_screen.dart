import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/credientials/login/login_controller.dart';

import '../../../global_widgets/circular_indicator.dart';

class LoginScreen extends GetView<LogInController> {
  const LoginScreen({Key? key}) : super(key: key);

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
            title: const Text("Login"),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formGlobalKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: H * 0.009,
                      ),
                      Center(
                        child: Image(
                          image: const AssetImage(
                            "assets/icons/Group 11411@2x.png",
                          ),
                          height: H * 0.25,
                          width: W * 0.6,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Hello,",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Login First to continue",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: H * 0.02,
                      ),
                      CustomTextFieldWidget(
                        hintText: "Email",
                        textEditingController: controller.emailFieldController,
                        validator: controller.validateEmail,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/icons/Group 10999.png",
                            height: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: H * 0.02,
                      ),
                      Obx(() => CustomTextFieldWidget(
                            hintText: "Password",
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
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 8.0, right: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Obx(
                                  () => Material(
                                    child: Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      value: controller.isRememberChecked,
                                      onChanged: controller.onCheckboxChange,
                                    ),
                                  ),
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.onForgetPasswordTap();
                              },
                              child: const Text(
                                "Forget Password?",
                                style: TextStyle(color: primary, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: H * 0.02,
                      ),
                      Center(
                        child: SizedBox(
                          height: H * 0.09,
                          width: W,
                          child: CustomElevatedButtonWidget(
                            onPressed: () {
                              controller.validateForm();
                              // Get.toNamed(Routes.loginHomeScreen);
                            },
                            text: "Login",
                            textColor: blackColor,
                            fontSize: 24,
                            verticalPadding: 0,
                            borderRadius: 45,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
