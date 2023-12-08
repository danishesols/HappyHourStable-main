import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/providers/user_provider.dart';
import '../../global_controller/auth_controller.dart';
import '../../global_controller/global_general_controller.dart';

class MyProfileController extends GetxController {
  final UserProvider _userProvider = UserProvider();
  final formGlobalKey = GlobalKey<FormState>();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;


  final TextEditingController firstNameController =
      TextEditingController(text: Get.find<AuthController>().user.firstName);
  final TextEditingController lastNameController =
      TextEditingController(text: Get.find<AuthController>().user.lastName);
  final TextEditingController emailController =
      TextEditingController(text: Get.find<AuthController>().user.email);
  //Get.find<AuthController>().auth.currentUser!.email.toString()
  final TextEditingController mobileNumberController =
      TextEditingController(text: Get.find<AuthController>().user.mobilenumber);

  final ImagePicker _picker = ImagePicker();

  final _profileImage = "".obs;
  XFile? profileImage = null;

  final _imageUrl = Get.find<AuthController>().user.profileImage.obs;
  String? get profileImageUrl => _imageUrl.value;
  set setImageUrl(value) => _imageUrl.value = value;

  Future uploadProfileImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      profileImage = imageFile;
    }
    if (imageFile != null) {
      setImageUrl = await _userProvider.uploadImage(
          file: File(profileImage!.path),
          uid: Get.find<AuthController>().user.uid);
    }
  }

  clearForm() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    mobileNumberController.clear();
  }

  updateProfileInfo() async {
    final firstname = firstNameController.text != '' &&
            firstNameController.text !=
                Get.find<AuthController>().user.firstName
        ? firstNameController.text
        : Get.find<AuthController>().user.firstName;
    final lastname = lastNameController.text != '' &&
            lastNameController.text != Get.find<AuthController>().user.lastName
        ? lastNameController.text
        : Get.find<AuthController>().user.lastName;

    final email = emailController.text != '' &&
            emailController.text != Get.find<AuthController>().user.email
        ? emailController.text
        : Get.find<AuthController>().user.email;
    // final mobileNumber = mobileNumberController.text != '' &&
    //         mobileNumberController.text !=
    //             Get.find<AuthController>().user.mobilenumber
    //     ? mobileNumberController.text
    //     : Get.find<AuthController>().user.mobilenumber;

    // * check either any field has assigned a value or not.
    if (firstname != "" &&
        lastname != "" &&
        email != ""
    //&&
        //mobileNumber != ""
    ) {
      isLoading = true;

      bool result = await _userProvider.updateUserInfo(
        userId: Get.find<AuthController>().user.uid,
        information: {
          "profile_image": profileImageUrl,
          "firstname": firstname,
          "lastname": lastname,
          "email": email,
          //"mobilenumber": mobileNumber,
        },
      );

      if (result) {
        Get.find<GlobalGeneralController>().successSnackbar(
          title: "Success",
          description: "Profile updated!",
        );
        //  clearForm();
      }
      isLoading = false;
    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: "All above fields are empty!",
      );
    }
  }

  String? nameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered name is valid
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Field is empty';
    } else if (value.length != 11 && !GetUtils.isPhoneNumber(value)) {
      return "Invalid Phone Number";
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
}
