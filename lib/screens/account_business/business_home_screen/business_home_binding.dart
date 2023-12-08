import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/account_business/business_home_screen/business_home_controller.dart';

class BusinessAccountHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessAccountHomeController());
  }
}
