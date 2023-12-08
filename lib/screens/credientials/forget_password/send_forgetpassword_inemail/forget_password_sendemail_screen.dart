import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/send_forgetpassword_inemail/forgetpassword_sendemail_controller.dart';

import '../../../../global_widgets/circular_indicator.dart';

class ForgetPasswordSendEmailScreen
    extends GetView<ForgetPasswordSendEmailController> {
  const ForgetPasswordSendEmailScreen({Key? key}) : super(key: key);

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
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 4, bottom: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: controller.formGlobalKey,
                  child: Column(
                    children: [
                      Center(
                        child: Image(
                          image: const AssetImage(
                            "assets/icons/Group 11411@2x.png",
                          ),
                          height: H * 0.23,
                          width: W * 0.6,
                        ),
                      ),
                      const Center(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: H * 0.015,
                      ),
                      const Text(
                        "Please Enter your Email Address and we will send the link for the reset",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: H * 0.015,
                      ),
                      CustomTextFieldWidget(
                        hintText: "Email",
                        textEditingController: controller.emailFieldController,
                        validator: controller.validateEmail,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.asset(
                            "assets/icons/Group 10999.png",
                            height: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: H * 0.09,
                      width: W,
                      child: CustomElevatedButtonWidget(
                        onPressed: () {
                          //Get.toNamed(Routes.resetPasswordScreen);
                          controller.validateForm();
                        },
                        text: "Send Request",
                        textColor: blackColor,
                        fontSize: 24,
                        verticalPadding: 0,
                        borderRadius: 45,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
