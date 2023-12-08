import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/account_business/subcription_screen/subcription_controller.dart';

class SubcriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubcriptionController());
  }
}
