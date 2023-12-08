// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../global_controller/auth_controller.dart';
import '../../../../global_controller/global_general_controller.dart';

class ResetPasswordController extends GetxController {
  // * variables
  final formGlobalKey = GlobalKey<FormState>();
  final passwordFieldController = TextEditingController();
  final confirmpasswordFieldController = TextEditingController();

  // * observable variables
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;

  final _obscurePasswordSecond = true.obs;
  bool get obscurePasswordSecond => _obscurePasswordSecond.value;

  // * methods

  onShowPasswordTap() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  onShowPasswordTapSecond() {
    _obscurePasswordSecond.value = !_obscurePasswordSecond.value;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length < 8) {
      return "Password should be 8 or more characters";
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length < 8) {
      return "Password should be 8 or more characters";
    } else if (passwordFieldController.text != value) {
      return "Password does not match";
    }

    return null;
  }

  Future<bool> _authenticateUser(String password) async {
    String email = Get.find<AuthController>().auth.currentUser!.email!;
    // String _password = password;

    try {
      // * get a credentials
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      // Reauthenticate
      UserCredential _userCredential = await FirebaseAuth.instance.currentUser!
          .reauthenticateWithCredential(credential);
      return _userCredential.user != null;
    } catch (e) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Invalid Password",
        description: "Previous password does not match!",
      );
      isLoading = false;
      return false;
    }
  }

  validatePasswordsForm() async {
    if (formGlobalKey.currentState!.validate()) {
      isLoading = true;
      // * reauthenticate current user for checking either the current password is correct or not.
      bool _isAuthenticated =
          await _authenticateUser(passwordFieldController.text);

      if (_isAuthenticated) {
        Get.find<AuthController>().updateUserPassword(
          password: confirmpasswordFieldController.text,
        );
      }
    }
  }
}
