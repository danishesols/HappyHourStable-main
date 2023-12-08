// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_hour_app/data/models/user_model.dart';
import 'package:happy_hour_app/data/providers/user_provider.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/reset_password/reset_password_controller.dart';
import 'package:happy_hour_app/screens/credientials/login/login_controller.dart';
import 'package:happy_hour_app/screens/credientials/signup/business_account_signup/business_account_signup_controller.dart';
import 'package:image_picker/image_picker.dart';
import '../core/constants.dart';
import '../routes/app_routes.dart';
import '../screens/credientials/signup/standard_account_signup/standard_account_signup_controller.dart';

class AuthController extends GetxController {
  // * instances
  final FirebaseAuth auth = FirebaseAuth.instance;
  final UserProvider _userProvider = UserProvider();
  final box = GetStorage();
  final _globalGeneralController = Get.put(GlobalGeneralController());

  // * observable variables

  // * empty user model objects
  final _user = UserModel(
    uid: "",
    username: "",
    email: "",
    firstName: "",
    lastName: "",
    mobilenumber: "",
    profileImage: "",
    favoriteHours: [],
    claimHours: [],
    hasSubscription: false,
    isBusiness: false,
  ).obs;

  // * get the user with this variable in the entire app.
  UserModel get user => _user.value;
  set user(value) => _user.value = value;
  //final currentuser = FirebaseAuth.instance.currentUser!.uid;

  // * methods
  @override
  void onInit() async {
    if (auth.currentUser?.uid != null) {
      _user.value = await _userProvider
          .getUserDocById(uid: auth.currentUser?.uid ?? "")
          .whenComplete(() {
        // _user.value.isBusiness == true
        //     ? Get.offAllNamed(Routes.businessAccountHomeScreen)
        //     : Get.offAllNamed(Routes.loginHomeScreen);
      });
    }
    if (box.read(loginRememberMeStatus)) {
      final _id = box.read(userId);
      _user.value = await _userProvider.getUserDocById(uid: _id);
    }
    super.onInit();
  }

//* Create Standard User
  createStandardUser({
    required String username,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required bool isBusiness,
    required XFile? profileImage,
  }) async {
    try {
      UserCredential? _authResult;
      // * create the new Standard user's authetications.
      try {
        _authResult = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      } catch (e) {
        if (kDebugMode) {
          print('auth: $e');
        }
      }
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await _userProvider.uploadImage(
            file: File(profileImage.path),
            uid: Get.find<AuthController>().user.uid);
      }

      // * create the new user model.
      UserModel _newUser = UserModel(
        uid: _authResult!.user!.uid,
        username: username,
        profileImage: imageUrl,
        firstName: firstName,
        lastName: lastName,
        email: email,
        favoriteHours: [],
        claimHours: [],
        hasSubscription: false,
        isBusiness: false,
      );

      // * if the new user perfactly added to the database, then save it in the user variable and navigate to the next screen.
      if (await _userProvider.createStandartUser(user: _newUser)) {
        _user.value = _newUser;
      }
      Get.offAllNamed(Routes.loginHomeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _globalGeneralController.errorSnackbar(
          title: 'Weak Password',
          description: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        _globalGeneralController.errorSnackbar(
          title: 'Email Alreay In Use',
          description: 'The account already exists for that email.',
        );
      } else if (e.code == 'email-already-in-use') {
        _globalGeneralController.errorSnackbar(
          title: 'Email Alreay In Use',
          description: 'The account already exists for that email.',
        );
      }
    } on SocketException {
      _globalGeneralController.errorSnackbar(
        title: "Network Error",
        description: "Connection not found!",
      );
    } catch (e) {
      _globalGeneralController.errorSnackbar(
          title: "Something went wrong!",
          description: "Something went wrong: $e");
      printError();
    }
    Get.find<StandardAccountController>().isLoading = false;
  }

//* Create Business User
  createBusinessUser({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required bool isBusiness,
    XFile? profileImage,
  }) async {
    try {
      // * create the new Business user's authetications.
      UserCredential _authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String? imageUrl;
      if (profileImage != null) {
        imageUrl = await _userProvider.uploadImage(
            file: File(profileImage.path),
            uid: Get.find<AuthController>().user.uid);
      }

      // * create the new user model.
      UserModel _newUser = UserModel(
          uid: _authResult.user!.uid,
          username: username,
          firstName: firstName,
          lastName: lastName,
          email: email,
          favoriteHours: [],
          claimHours: [],
          hasSubscription: false,
          isBusiness: isBusiness,
          profileImage: imageUrl);

      // * if the new user perfactly added to the database, then save it in the user variable and navigate to the next screen.
      if (await _userProvider.createBusinessUser(user: _newUser)) {
        _user.value = _newUser;
      }
      Get.offAllNamed(Routes.businessAccountHomeScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _globalGeneralController.errorSnackbar(
          title: 'Weak Password',
          description: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        _globalGeneralController.errorSnackbar(
          title: 'Email Alreay In Use',
          description: 'The account already exists for that email.',
        );
      }
    } on SocketException {
      _globalGeneralController.errorSnackbar(
        title: "Network Error",
        description: "Connection not found!",
      );
    } catch (e) {
      printError();
    }
    Get.find<BusinessAccountSignUpController>().isLoading = false;
  }

  loginUser({
    required String email,
    required String password,
  }) async {
    try {
      // * login user with given email and password and get it's credential data.
      UserCredential _loggedInUser = await auth.signInWithEmailAndPassword(
          email: email, password: password);
          box.write("islogin", true);
      Get.find<LogInController>().isLoading = true;
      _user.value =
          await _userProvider.getUserDocById(uid: _loggedInUser.user!.uid);
      user.isBusiness == true
          ? Get.offAllNamed(Routes.businessAccountHomeScreen)
          : Get.offAllNamed(Routes.loginHomeScreen);
      // * save remember me status
      final _userRemeberMeStatus = box.read(loginRememberMeStatus);
       
      if (_userRemeberMeStatus) {
        // * if user enable remember me option then save user id in a Get Storage.
        await box.write(userId, user.uid);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _globalGeneralController.errorSnackbar(
          title: 'Weak Password',
          description: 'The password provided is too weak.',
        );
      } else if (e.code == 'user-not-found') {
        _globalGeneralController.errorSnackbar(
          title: 'User Not Found',
          description: 'No user found for that email',
        );
      } else if (e.code == 'wrong-password') {
        _globalGeneralController.errorSnackbar(
          title: 'Wrong Password',
          description: 'Invalid password for that email',
        );
      }
    } on SocketException {
      _globalGeneralController.errorSnackbar(
        title: "Network Error",
        description: "Connection not found!",
      );
    } catch (e) {
      _globalGeneralController.errorSnackbar(
        title: "Error",
        description: e.toString(),
      );
    }
    Get.find<LogInController>().isLoading = false;
  }

  updateUserPassword({required String password}) async {
    try {
      await auth.currentUser!.updatePassword(password).then(
        (value) {
          Get.find<GlobalGeneralController>().successSnackbar(
            title: "Success",
            description: "Password updated!",
          );
          Get.find<ResetPasswordController>().passwordFieldController.clear();
          Get.find<ResetPasswordController>()
              .confirmpasswordFieldController
              .clear();
        },
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _globalGeneralController.errorSnackbar(
          title: 'Weak Password',
          description: 'The password provided is too weak.',
        );
      }
    } catch (e) {
      _globalGeneralController.errorSnackbar(
        title: "Error",
        description: "Something went wrong: $e",
      );
    } finally {
      Get.toNamed(Routes.passwordUpdatedScreen);
    }
  }

  sendPasswordResetEmail({required String email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.toNamed(Routes.loginScreen);
      // Get.toNamed(Routes.resetPasswordScreen);
      _globalGeneralController.successSnackbar(
          title: "Password Reset Link Sent",
          description: "Please check your email and update your password.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _globalGeneralController.errorSnackbar(
          title: 'Invalid Email',
          description: 'The email provided is invalid.',
        );
      } else if (e.code == 'user-not-found') {
        _globalGeneralController.errorSnackbar(
          title: 'User Not Found',
          description: 'User not found with this email.',
        );
      }
    } catch (e) {
      _globalGeneralController.errorSnackbar(
        title: "Error",
        description: "Something went wrong: $e",
      );
    }
  }

  logoutUser() async {
    try {
      await auth.signOut();
      box.remove(userId);
      Get.find<AuthController>().user = UserModel(uid: '', isBusiness: false, username: '', email: '', claimHours: [], favoriteHours: [], hasSubscription: false);
      box.remove(loginRememberMeStatus);
      box.remove("islogin");
      // Get.offAllNamed(Routes.homeScreen);
    } on FirebaseException catch (e) {
      _globalGeneralController.errorSnackbar(
        title: e.code,
        description: e.message.toString(),
      );
    }
  }
}
