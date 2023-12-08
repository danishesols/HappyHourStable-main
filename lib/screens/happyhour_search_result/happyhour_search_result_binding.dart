import 'package:get/instance_manager.dart';
import 'package:happy_hour_app/screens/happyhour_filter_screen/happyhour_filter_screen_controller.dart';
import 'package:happy_hour_app/screens/happyhour_search_result/happyhour_search_result_controller.dart';

class HappyHourSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HappyHourSearchResultController());
    Get.lazyPut(() => HappyHourFilterScreenController());
  }
}
