import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/reset_password/reset_password_controller.dart';

class ResetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResetPasswordController());
  }
}
