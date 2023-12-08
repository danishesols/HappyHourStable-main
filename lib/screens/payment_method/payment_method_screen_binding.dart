import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/payment_method/payment_method_screen_controller.dart';

class PaymentMethodScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentMethodScreenController());
  }
}
