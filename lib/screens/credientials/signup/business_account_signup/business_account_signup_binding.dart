import 'package:get/get.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/screens/credientials/signup/business_account_signup/business_account_signup_controller.dart';

class BusinessAccountSignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessAccountSignUpController());
    Get.lazyPut(() => AuthController());
  }
}
