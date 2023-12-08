import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../edit_controller.dart';

class EditEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditController());
    Get.lazyPut(() => AuthController());
  }
}
