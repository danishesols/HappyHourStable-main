import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/payment_method/payment_card_detail/payment_card_detail_screen_controller.dart';

class PaymentCardDeatailScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentCardDetailScreenController());
  }
}
