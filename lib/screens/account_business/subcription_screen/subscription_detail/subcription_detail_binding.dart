import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subscription_detail/subscription_detail_controller.dart';

class SubcriptionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubcriptionDetailController());
  }
}
