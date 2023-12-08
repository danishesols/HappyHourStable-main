import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../account_business/add_for_guest/guest_business_form/guest_form_screen.dart';

class StandardAccountController extends GetxController {
  // * variables
  final formGlobalKey = GlobalKey<FormState>();
  final firstNameFieldController = TextEditingController();
  final lastNameFieldController = TextEditingController();
  final emailFieldController = TextEditingController();
  final passwordFieldController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // * observable variables.

  final _isLoading = false.obs;

  XFile? profileImage;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final _obscurePassword = true.obs;
  bool get obscurePassword => _obscurePassword.value;

  final _obscureConfirmPassword = true.obs;
  bool get obscureConfirmPassword => _obscureConfirmPassword.value;

  // * methods
  onShowPasswordTap() {
    _obscurePassword.value = !_obscurePassword.value;
  }

  onShowConfirmPasswordTap() {
    _obscureConfirmPassword.value = !_obscureConfirmPassword.value;
  }

  Future uploadProfileImage(BuildContext context) async {
    ImageSource source = ImageSource.gallery;
    await dialogueCard(
        context,
        "Add From Gallery",
        () {
          source = ImageSource.gallery;
          Get.back();
        },
        "Open Camera",
        () {
          source = ImageSource.camera;
          Get.back();
        });
    final XFile? imageFile =
        await ImagePicker().pickImage(source: source, imageQuality: 85);
    if (imageFile != null) {
      profileImage = imageFile;
      update();
    }
    update();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    }
    return null;
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

  // * if all field are correct then pass the values to auth controller's createUser method.
  validateForm() {
    // if (profileImage == null) {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: 'Pick Image', description: 'No Image Picked ....');
    // } else
      if (formGlobalKey.currentState!.validate()) {
      isLoading = true;

      Get.find<AuthController>().createStandardUser(
          firstName: firstNameFieldController.text,
          lastName: lastNameFieldController.text,
          username: firstNameFieldController.text +
              ' ' +
              lastNameFieldController.text,
          email: emailFieldController.text,
          password: passwordFieldController.text,
          confirmPassword: confirmPasswordController.text,
          isBusiness: false,
          profileImage: profileImage);
    }
  }
}
