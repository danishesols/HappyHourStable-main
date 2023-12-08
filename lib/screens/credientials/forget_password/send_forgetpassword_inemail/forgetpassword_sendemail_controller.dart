import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_controller/auth_controller.dart';

class ForgetPasswordSendEmailController extends GetxController {
  // * variables
  final formGlobalKey = GlobalKey<FormState>();
  final emailFieldController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  // * methods
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (!GetUtils.isEmail(value)) {
      return "Invalid Email";
    }
    return null;
  }

  // * if all field are correct then pass the values to auth controller's createUser method.
  validateForm() {
    if (formGlobalKey.currentState!.validate()) {
      //isLoading = true;
      Get.find<AuthController>()
          .sendPasswordResetEmail(email: emailFieldController.text);
    }
  }
}
