import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import 'login_home_controller.dart';

class LoginHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginHomeController());
    Get.lazyPut(() => AuthController());
  }
}
