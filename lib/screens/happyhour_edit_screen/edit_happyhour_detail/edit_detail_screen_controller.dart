import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/hour_favorite_model.dart';
import '../../../data/providers/favorite_provider.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../routes/app_routes.dart';

class EditDetailScreenController extends GetxController {
  final FavoriteProvider favoriteProvider = FavoriteProvider();
  final HappyHourModel happyHour = Get.arguments;
  HoursFavoriteModel hour = HoursFavoriteModel(
    hid: Get.arguments.hid ?? Get.arguments.id,
    businessName: "",
    description: "",
    menuImage: "",
    businessImage: "",
  );

  List imageList = [];
  addAllIMages() {
    imageList.add(happyHour.menuImage);
    imageList.add(happyHour.businessCard);
    imageList.add(happyHour.businessImage);
    imageList.add(happyHour.businessLogo);
  }

  @override
  void onInit() {
    addAllIMages();
    super.onInit();
  }

  //observable variables
  final _switchs = 0.obs;
  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;

  // void hourIds() {
  //   hour = HoursFavoriteModel(
  //     hid: happyHour.id!,
  //     businessName: "",
  //     description: "",
  //     menuImage: "",
  //     businessImage: "",
  //   );
  //   update();
  // }

  String id = Get.arguments.hid ?? Get.arguments.id;
  onAddreviewTap() {
    Get.toNamed(Routes.addReviewScreen, arguments: id);
  }

  onAddreportTap() {
    Get.toNamed(Routes.reportScreen, arguments: id);
  }

  final RxBool _show = false.obs;
  bool get isShow => _show.value;
  set isShow(value) => _show.value = value;

  void showReply() {
    isShow = !isShow;
  }

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not launch $url',
      );
    }
  }

  onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }

  double star = 4;

  // rating(index) async {
  //   star = await happyHour.reviewStar?[index]['stars'];
  // }
}
