import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/data/providers/favorite_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_controller/global_general_controller.dart';

class HappyhourDetailScreenController extends GetxController {
  final FavoriteProvider favoriteProvider = FavoriteProvider();
  final HappyHourModel happyHour = Get.arguments;
  // final HoursFavoriteModel hours = HoursFavoriteModel(
  //   hid: Get.find<AuthController>().user.uid,
  //   businessName: "",
  //   description: "",
  //   menuImage: "",
  //   businessImage: "",
  // );

  List imageList = [];
  addAllImages() {
    imageList.add(happyHour.menuImage);
    happyHour.businessCard != null
        ? imageList.add(happyHour.businessCard)
        : imageList.add(happyHour.menuImage);
    happyHour.businessImage != null
        ? imageList.add(happyHour.businessImage)
        : imageList.add(happyHour.menuImage);
    happyHour.businessLogo != null
        ? imageList.add(happyHour.businessLogo)
        : imageList.add(happyHour.menuImage);
  }

  List lateFoodList = [];
  List earlyFoodList = [];
  lateFoodItems() {
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
  lateDrinkItems() {
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

  List menuImageList = [];
  menuAllImages() {
    if (happyHour.menuImage != null) {
      menuImageList.add(happyHour.menuImage);
    }
    if (happyHour.menuImage2 != null) {
      menuImageList.add(happyHour.menuImage2);
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
    lateFoodItems();
    lateDrinkItems();
    dailySpecialData();
    super.onInit();
  }

  // final HourModel hourModel = HourModel(
  //     hourId: "",
  //     name: "",
  //     address: "",
  //     phoneNumber: "",
  //     latitude: 0,
  //     longitude: 0,
  //     hourImages: "");

  //   Rx<List<HoursModel>> allCategoriesFilteredList =
  //     Rx<List<HoursModel>>([]);
  // List<HoursModel> get allCategoriesFilteredLists =>
  //     allCategoriesFilteredList.value;
  // set allCategoriesFilteredLists(value) =>
  //     allCategoriesFilteredList.value = value;
  //observable variables
  final _switchs = 0.obs;
  int get switches => _switchs.value;
  set switches(value) => _switchs.value = value;

  final RxBool _show = false.obs;
  bool get show => _show.value;
  set show(value) => _show.value = value;

  void showReply() {
    show = !show;
  }

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
        "https://www.google.com/maps/search/?api=1&query=${happyHour.latitude},${happyHour.longitude}"));
  }
}
