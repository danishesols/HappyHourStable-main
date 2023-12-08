import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';

import '../../duplicate_happyhour_controller.dart';

class DuplicateEventsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DuplicateController());
    Get.lazyPut(() => AuthController());
  }
}
