import 'package:get/instance_manager.dart';

import '../business_filter_screen/business_filter_screen_controller.dart';
import 'business_search_result_controller.dart';

class BusinessSearchResultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BusinessSearchResultController());
    Get.lazyPut(() => BusinessFilterScreenController());
  }
}
