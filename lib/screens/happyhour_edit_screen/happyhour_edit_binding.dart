import 'package:get/get.dart';
import 'package:happy_hour_app/screens/happyhour_edit_screen/edit_screens/edit_controller.dart';

class HappyHourEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditController());
  }
}
