import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/hour_favorite_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global_controller/global_general_controller.dart';
import '../../routes/app_routes.dart';

class FavoriteDetailController extends GetxController {
  final HoursFavoriteModel happyHour = Get.arguments;
  //observable variables
  final _switchs = 0.obs;

  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;
  List lateFoodList = [];
  List earlyFoodList = [];
  foodItems() {
    for (var i = 0; i < happyHour.foodName!.length; i++) {
      if (happyHour.foodName?[i]['late'] == true) {
        lateFoodList.add(happyHour.foodName?[i]);
      }
      if (happyHour.foodName?[i]['early'] == true) {
        earlyFoodList.add(happyHour.foodName?[i]);
      }
    }
    // print(lateFoodList);
    // print(lateFoodList.length);
  }

  List lateDrinkList = [];
  List earlyDrinkList = [];
  drinkItems() {
    for (var i = 0; i < happyHour.drinkitemName!.length; i++) {
      if (happyHour.drinkitemName?[i]['late'] == true) {
        lateDrinkList.add(happyHour.drinkitemName?[i]);
      }
      if (happyHour.drinkitemName?[i]['early'] == true) {
        earlyDrinkList.add(happyHour.drinkitemName?[i]);
      }
    }
    // print(lateDrinkList);
    // print(lateDrinkList.length);
  }

  List imageList = [];
  List menuImageList = [];
  menuAllImages() {
    if (happyHour.menuImage != '') {
      menuImageList.add(happyHour.menuImage);
    }
    if (happyHour.menuImage2 != null) {
      menuImageList.add(happyHour.menuImage2);
    }
  }

  addAllImages() {
    print('business Image: ${happyHour.businessImage}');
    imageList.add(happyHour.menuImage);
    if (happyHour.businessCard != null) {
      imageList.add(happyHour.businessCard);
    }
    if (happyHour.businessImage != null) {
      imageList.add(happyHour.businessImage);
    }
    if (happyHour.businessLogo != null) {
      imageList.add(happyHour.businessLogo);
    }
  }

  List sundayList = [];
  List mondayList = [];
  List tuesdayList = [];
  List wednesdayList = [];
  List thursdayList = [];
  List fridayList = [];
  List saturdayList = [];
  dailySpecialData() {
    for (var i = 0; i < happyHour.dailySpecils!.length; i++) {
      if (happyHour.dailySpecils?[i]['day'] == "Sunday") {
        sundayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Monday") {
        mondayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Tuesday") {
        tuesdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Wednesday") {
        wednesdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Thursday") {
        thursdayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Friday") {
        fridayList.add(happyHour.dailySpecils?[i]);
      }
      if (happyHour.dailySpecils?[i]['day'] == "Saturday") {
        saturdayList.add(happyHour.dailySpecils?[i]);
      }
    }
  }

  @override
  void onInit() {
    addAllImages();
    menuAllImages();
    foodItems();
    drinkItems();
    dailySpecialData();
    super.onInit();
  }

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

  bool makeDailySpecialVisible (){
    bool isVisible = sundayList.isNotEmpty &&
        mondayList.isNotEmpty &&
        tuesdayList.isNotEmpty &&
        wednesdayList.isNotEmpty &&
        thursdayList.isNotEmpty &&
        fridayList.isNotEmpty &&
        saturdayList.isNotEmpty;
    return isVisible;
  }
}
