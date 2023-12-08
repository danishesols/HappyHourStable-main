import 'package:get/get.dart';
import 'package:happy_hour_app/screens/notification/notification_controller.dart';

class NotificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
  }
}
