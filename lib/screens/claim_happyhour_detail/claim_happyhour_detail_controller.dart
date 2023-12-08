import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_controller/global_general_controller.dart';

class ClaimHappyHourDetailController extends GetxController {
  final HappyHourModel happyhourModel = Get.arguments;
  //observable variables
  final _switchs = 0.obs;
  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not launch $url',
      );
    }
  }

  onDirectionTap() {
    _launchURL(Uri.parse(
        "https://www.google.com/maps/search/?api=1&query=${happyhourModel.latitude},${happyhourModel.longitude}"));
  }
}
