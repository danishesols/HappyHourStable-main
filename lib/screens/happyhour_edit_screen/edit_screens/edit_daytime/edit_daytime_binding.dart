import 'package:get/instance_manager.dart';

import '../edit_controller.dart';

class EditDaytTimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditController());
  }
}
