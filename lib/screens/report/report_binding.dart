import 'package:get/get.dart';
import 'package:happy_hour_app/screens/report/report_controller.dart';

class ReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportController());
  }
}
