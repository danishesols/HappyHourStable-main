import 'package:get/get.dart';
import 'package:happy_hour_app/screens/splash/splash_screen_controller.dart';

import '../../global_controller/auth_controller.dart';
import '../../global_controller/global_general_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // * initialize the auth controller.

    Get.put(SplashController());
    Get.put(AuthController());

    // * this controller contains all the global methods that will be use throughout the app.
    Get.put(GlobalGeneralController());
  }
}
