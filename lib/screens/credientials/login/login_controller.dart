import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../../../core/constants.dart';
import '../../../routes/app_routes.dart';

class LogInController extends GetxController {
  // * variables
  final formGlobalKey = GlobalKey<FormState>();
  final emailFieldController =
      TextEditingController(); //text: "Hamdan@gmail.com"
  final passwordFieldController = TextEditingController(); //text: "123456789"

  // * observable variables
  final _isRememberChecked = false.obs;
  bool get isRememberChecked => _isRememberChecked.value;
  set isRememberChecked(value) => _isRememberChecked.value = value;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _obscurePassword = false.obs;
  bool get obscurePassword => _obscurePassword.value;

  // * methods
  @override
  onInit() {
    // * make it false again so that when user logout. And try to sign in again but without checking the remember me box so the dafault false value can be passed.
    GetStorage().write(
      loginRememberMeStatus,
      false,
    );
    super.onInit();
  }

  onShowPasswordTap() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (!GetUtils.isEmail(value)) {
      return "Invalid Email";
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length < 8) {
      return "Password should be 8 or more characters";
    }
    return null;
  }

  onCheckboxChange(bool? value) {
    isRememberChecked = !isRememberChecked;
    GetStorage().write(
      loginRememberMeStatus,
      isRememberChecked,
    );
  }

  onForgetPasswordTap() {
    Get.toNamed(Routes.forgetPasswordSendEmailScreen);
  }

  // * if all field are correct then pass the values to auth controller's _ method.
  validateForm() {
    if (formGlobalKey.currentState!.validate()) {
      isLoading = true;
      update();
      Get.find<AuthController>().loginUser(
        email: emailFieldController.text,
        password: passwordFieldController.text,
      );
    }
  }

  // onGoogleButtonTap() {}

  // onFacebookButtonTap() {}

  // onSignUpTap() {
  //   Get.offNamed(Routes.);
  // }
}
