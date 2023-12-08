import 'package:get/get.dart';
import 'package:happy_hour_app/screens/credientials/forget_password/send_forgetpassword_inemail/forgetpassword_sendemail_controller.dart';

class ForgetPasswordSendEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgetPasswordSendEmailController());
  }
}
