import 'package:get/get.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

class StartedScreenController extends GetxController {

  bool firstChecked=false;
  bool secondChecked=false;
  

updateFirstCheck(value){
  firstChecked=value;
  update();
}

updateSecondCheck(value){
  secondChecked=value;
  update();
}
  onGetStartedTap() {
    Get.offNamed(Routes.homeScreen);
    // Get.offNamed(Routes.addHappyDailySpecialScreen);
  }
}
