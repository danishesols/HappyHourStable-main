import 'package:get/instance_manager.dart';

import '../edit_controller.dart';

class EditHourBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditController());
  }
}
