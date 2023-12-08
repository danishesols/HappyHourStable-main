import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:happy_hour_app/global_controller/global_general_controller.dart';
import 'package:happy_hour_app/routes/app_routes.dart';
import 'package:happy_hour_app/screens/account_business/add_for_guest/guest_request_submitted_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/current_location_controller.dart';
import '../../account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';

class GuestController extends GetxController {
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();
  final manualAddressformKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final businessNameController = TextEditingController();
  final businessAddressController = TextEditingController();
  final descriptionController = TextEditingController();
  final addDrinksManuallyController = TextEditingController();
  final addfoodManuallyController = TextEditingController();
  final phonenumberController = TextEditingController();
  final dailSpecialPrice = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  LocationPermissionStatus locationPermissionStatus =
      LocationPermissionStatus.nullStatus;
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Enable Location",
          description:
              "Location services are disabled. Please enable the services");
      return false;
    } else {
      locationPermissionStatus = LocationPermissionStatus.enabled;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      locationPermissionStatus = LocationPermissionStatus.denied;
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Enable Location",
            description: "Location permissions are denied");
        locationPermissionStatus = LocationPermissionStatus.denied;
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      locationPermissionStatus = LocationPermissionStatus.deniedForever;

      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Enable Location Manually",
          description:
              "Location permissions are permanently denied, we cannot request permissions.");
      bool isAllowed = await openAppSettings();
      return isAllowed;
    }
    locationPermissionStatus = LocationPermissionStatus.enabled;
    return true;
  }

  Future<Position?> getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();
    if (!hasPermission) {
      isLoading = false;
      update();
      return null;
    }
    Position currentLoc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currentLoc;
  }

  //*===============Init State==========*//
  @override
  onInit() async {
    super.onInit();
    // * location service
    isLoading = true;
    update();
    //if(CurrentLocationController.latitude==null || CurrentLocationController.longitude== null){
    Future.microtask(() async {
      Position? currentLoc = await getCurrentPosition();
      if (currentLoc != null) {
        latitude = currentLoc.latitude;
        longitude = currentLoc.longitude;
        isLoading = false;
        update();
      }
    });
    //}
    // else{
    //   latitude = CurrentLocationController.latitude;
    //   longitude = CurrentLocationController.longitude;
    //   isLoading = false;
    //   update();
    // }
  }

//observable variables
  final _busniessCard = "".obs;
  String get businessCard => _busniessCard.value;
  set businessCard(value) => _busniessCard.value = value;

  final _busniessLogo = "".obs;
  String get businessLogo => _busniessLogo.value;
  set businessLogo(value) => _busniessLogo.value = value;

  final _busniessImage = "".obs;
  String get businessImage => _busniessImage.value;
  set businessImage(value) => _busniessImage.value = value;

  final _happyHourMenuImage = "".obs;
  String get happyHourMenuImage => _happyHourMenuImage.value;
  set happyHourMenuImage(value) => _happyHourMenuImage.value = value;

  // final _happyHourMultiMenuImage = "".obs;
  // String get happyHourMultiMenuImage => _happyHourMultiMenuImage.value;
  // set happyHourMultiMenuImage(value) => _happyHourMultiMenuImage.value = value;

  final _isFood = true.obs;
  bool get isFood => _isFood.value;
  set isFood(value) => _isFood.value = value;

//Location
  late GoogleMapController googleMapController;
  double? latitude;
  double? longitude;
  void latLong(point) {
    (() {
      googleMapController.getLatLng(
        ScreenCoordinate(
          x: point.latitude.toInt(),
          y: point.longitude.toInt(),
        ),
      );
    });
    latitude = point.latitude;
    longitude = point.longitude;
  }

  //Google Places
  double _lat = 0.0;
  double _long = 0.0;
  final _isAddressRemoved = false.obs;
  bool get isAddressRemoved => _isAddressRemoved.value;
  final _address = "".obs;
  String get address => _address.value;

  onBusinessNameClick() async {
    Get.to(
      () => PlacePicker(
        apiKey: "AIzaSyDNps9wxy4nEFs1fFOgxjIcI5gTuK28r8s",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;

            if (result.name == null) {
              businessNameController.text =
                  result.formattedAddress!.toString().split(',')[0];
            } else {
              businessNameController.text = result.name!;
            }
            businessAddressController.text = result.formattedAddress!;       
            Get.back();
          }
        },
        initialPosition: LatLng(latitude!, longitude!),
        useCurrentLocation: true,
      ),
    );
  }

  onBusinessAddressClick() async {
    Get.to(
      () => PlacePicker(
        apiKey: "AIzaSyDNps9wxy4nEFs1fFOgxjIcI5gTuK28r8s",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;
            if (result.name == null) {
              businessNameController.text =
                  result.formattedAddress!.toString().split(',')[0];
            } else {
              businessNameController.text = result.name!;
            }
            businessAddressController.text = result.formattedAddress!;
            Get.back();
          }
        },
        initialPosition: LatLng(latitude!, longitude!),
        useCurrentLocation: true,
      ),
    );
  }

  // onAddressClick() async {
  //   Get.to(
  //     () => PlacePicker(
  //       apiKey: "AIzaSyDPOY1Q8Y3hi8_mQwYBztfj4pLYQl3-J0o",
  //       onPlacePicked: (PickResult result) {
  //         if (result.formattedAddress != null) {
  //           _lat = result.geometry!.location.lat;
  //           _long = result.geometry!.location.lng;
  //           businessAddressController.text = result.formattedAddress!;
  //           Get.back();
  //         }
  //       },
  //       initialPosition: const LatLng(33.704526937198345, 73.07165924459696),
  //       useCurrentLocation: true,
  //     ),
  //   );
  // }

  Future uploadBusinessCard(ImageSource source) async {
    final XFile? imageFile =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (imageFile != null) {
      businessCard = imageFile.path;
    }
  }

  Future uploadBusinessLogo(ImageSource source) async {
    final XFile? imageFile =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (imageFile != null) {
      businessLogo = imageFile.path;
    }
  }

  Future uploadBusinessImage(ImageSource source) async {
    final XFile? imageFile =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (imageFile != null) {
      businessImage = imageFile.path;
    }
  }

  Future uploadHappyHourMenuImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 85);
    if (imageFile != null) {
      happyHourMenuImage = imageFile.path;
      happyHourMultiImages.add(imageFile);
    }
  }

  final _happyHourMultiMenuImage = [].obs;
  List get happyHourMultiImages => _happyHourMultiMenuImage;
  set happyHourMultiImages(value) => _happyHourMultiMenuImage.value = value;

  Future uploadMultiMenuImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();
    if (images != null) {
      happyHourMultiImages = images;
    }
    update();
  }

  String? businessNameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 4) {
      return 'name must be at least 4 characters in length';
    }
    // Return null if the entered Business name is valid
    return null;
  }

// Phone number Validator
  // String? validatePhoneNumber(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Phone Number is Required';
  //   } else if (value.length != 11 && !GetUtils.isPhoneNumber(value)) {
  //     return "Invalid Phone Number";
  //   }
  //   return null;
  // }

  //Business Address textfeild validator
  String? businessAddressValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Address is required';
    }
    if (value.trim().length < 4) {
      return 'address must be at least 4 characters in length';
    }
    // Return null if the entered Business Address is valid
    return null;
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  String? nameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered Business name is valid
    return null;
  }

  // Address textfeild validator
  String? addressValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Address is required';
    }
    if (value.trim().length < 4) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered Business Address is valid
    return null;
  }

  final _isTermChecked = false.obs;
  bool get isTermChecked => _isTermChecked.value;
  set isTermChecked(value) => _isTermChecked.value = value;

  onCheckboxChange(bool? value) {
    isTermChecked = !isTermChecked;
  }

  String eventtime = "01:00 PM";
  String dailySpecialtime = "01:00 PM";
  String time = "01:00 PM";

  String selectedday = "";

  final timesList = [
    "01:00 AM",
    "01:30 AM",
    "02:00 AM",
    "02:30 AM",
    "03:00 AM",
    "03:30 AM",
    "04:00 AM",
    "04:30 AM",
    "05:00 AM",
    "05:30 AM",
    "06:00 AM",
    "06:30 AM",
    "07:00 AM",
    "07:30 AM",
    "08:00 AM",
    "08:30 AM",
    "09:00 AM",
    "09:30 AM",
    "10:00 AM",
    "10:30 AM",
    "11:00 AM",
    "11:30 AM",
    "12:00 PM",
    "12:30 PM",
    "01:00 PM",
    "01:30 PM",
    "02:00 PM",
    "02:30 PM",
    "03:00 PM",
    "03:30 PM",
    "04:00 PM",
    "04:30 PM",
    "05:00 PM",
    "05:30 PM",
    "06:00 PM",
    "06:30 PM",
    "07:00 PM",
    "07:30 PM",
    "08:00 PM",
    "08:30 PM",
    "09:00 PM",
    "09:30 PM",
    "10:00 PM",
    "10:30 PM",
    "11:00 PM",
    "11:30 PM",
    "12:00 AM",
    "12:30 AM",
    "Select Time",
  ];

  String day = "Select Day";
  final dayList = [
    "Select Day",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];

  List<SelectDayTime> dayFromTimeToTimeList = [
    SelectDayTime(
      isSelect: false.obs,
      day: "Sunday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Monday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Thursday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Friday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Saturday",
      image: "assets/icons/Ellipse 1.png",
      fromTime: "",
      toTime: "",
    ),
  ];
  List<LateDayTime> dayTimeList = [
    LateDayTime(
      isSelect: false.obs,
      day: "Sunday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Monday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Thursday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Friday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Saturday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
    ),
  ];

  //*Hour days and Times *//
  String? hDay;
  String? hFromTime;
  String? hToTime;
  String? hFromTime2;
  String? hToTime2;

  List hDayTimeList = [];

  void hUpdateDay(index) async {
    dayTimeList[index].isSelect.isTrue
        ? hDay = dayTimeList[index].day.toString()
        : hDayTimeList.removeWhere((e) => e['Hday'] == dayTimeList[index].day);
  }

  void hDayTime(index) {
    var a = hDayTimeList
        .where((e) => e['Hday'].toString() == dayTimeList[index].day)
        .toList();

    if (a.isEmpty) {
      hDayTimeList.add({
        "Hday": dayTimeList[index].day,
        "HfromTime": dayTimeList[index].fromTime,
        "HtoTime": dayTimeList[index].toTime
      });
    }
  }

  List hDayTimeLateList = [];
  void hDayTimeLate(index) {
    var a = hDayTimeLateList
        .where((e) => e['Hday2'].toString() == dayTimeList[index].day)
        .toList();

    if (a.isEmpty) {
      hDayTimeLateList.add({
        "Hday2": dayTimeList[index].day,
        "HfromTime2": dayTimeList[index].fromTime2,
        "HtoTime2": dayTimeList[index].toTime2,
      });
    }
  }

  //*FoodItem Section*//

  List<Select> foodallList = [
    Select(id: 1, name: "Bone in Wings"),
    Select(id: 2, name: "Boneless Wings"),
    Select(id: 3, name: "Pizza"),
    Select(id: 4, name: "Flat Bread"),
    Select(id: 5, name: "Burger"),
    Select(id: 6, name: "Sliders"),
    Select(id: 7, name: "Nachos"),
    Select(id: 8, name: "Nachos- Ahi"),
    Select(id: 9, name: "Tacos"),
    Select(id: 10, name: "Taquitos/Flautas"),
    Select(
        id: 11,
        name:
            "Quesadilla"), // Updated spelling from "Margarita" as per your request
    Select(id: 12, name: "Fries"),
    Select(id: 13, name: "Pretzels"),
    Select(id: 14, name: "Garlic Bread/Knots/Cheese Bread"),
    Select(id: 15, name: "Bruschetta"),
    Select(id: 16, name: "Mozzarella Sticks"),
    Select(id: 17, name: "Dip - Cheese"),
    Select(id: 18, name: "Dip- Spinach and/or Artichoke"),
    Select(id: 19, name: "Dip- Salsa"),
    Select(id: 20, name: "Dip- Guacamole"),
    Select(id: 21, name: "Dip- Hummus"),
    Select(id: 22, name: "Chicken- Fried/Tenders"),
    Select(id: 23, name: "Chicken- Grilled"),
    Select(id: 24, name: "Chicken-Other"),
    Select(id: 26, name: "Potatoes- Skins/Baked/Loaded"),
    Select(id: 27, name: "Tater Tots-Plain/Loaded"),
    Select(id: 29, name: "Chips/Crisps"),
    Select(id: 30, name: "Onion Rings/Blossom"),
    Select(id: 31, name: "Sprouts"),
    Select(id: 32, name: "Zucchini"),
    Select(id: 33, name: "Jalapeno Poppers"),
    Select(id: 34, name: "Pickles- Fried"),
    Select(id: 35, name: "Mac and Cheese Bites"),
    Select(id: 36, name: "Combo Platter"),
    Select(id: 37, name: "Egg Roll"),
    Select(id: 38, name: "Dumpling/ Wonton/ Pot Sticker"),
    Select(id: 39, name: "Pita"),
    Select(id: 40, name: "Wrap"),
    Select(id: 41, name: "Sandwich- Cold"),
    Select(id: 42, name: "Sandwich- Hot"),
    Select(id: 43, name: "Soup"),
    Select(id: 44, name: "Salad"),
    Select(id: 45, name: "Pasta- Ravioli/Spaghetti/Other"),
    Select(id: 46, name: "Meatballs"),
    Select(id: 47, name: "Meatloaf"),
    Select(id: 48, name: "Kabab/Skewer"),
    Select(id: 49, name: "Steak"),
    Select(id: 50, name: "Prime Rib"),
    Select(id: 51, name: "Ribs"),
    Select(id: 28, name: "BBQ-Other"),
    Select(
        id: 52,
        name:
            "Cheese and/or Meat Platter"), // Updated spelling from "Cheese Plate/Platter" as per your request
    // Select(id: 51, name: "Cheese- Curds"), deleted
    Select(id: 53, name: "Olives"),
    Select(id: 54, name: "Sushi- Roll/Sashimi/Nigiri/Handroll"),
    Select(id: 55, name: "Poke"),
     Select(id: 56, name: "Ceviche"),
    Select(id: 57, name: "Edamame"),
    Select(id: 58, name: "Calamari"),
    Select(id: 59, name: "Shrimp"),
    Select(
        id: 60,
        name: "Oysters"), // Corrected spelling from "Oystersl" to "Oysters"
    Select(id: 61, name: "Scallops"),
    Select(id: 62, name: "Mussels"),
      Select(id: 63, name: "Clams"),
   
    Select(id: 64, name: "Crab- Cakes/Meat/Legs/Other"),
     Select(id: 65, name: "Seafood-Other"),
    // Select(id: 69, name: "Tater Tots-Plain/Loaded"), deleted
    Select(id: 66, name: "Fish and Chips"),
    Select(id: 67, name: "Other Fish Dish"),
    Select(id: 68, name: "Burrito"),
    Select(id: 69, name: "Empanadas"),
    Select(id: 70, name: "Tapas"),
    Select(id: 71, name: "Meat Pie"),
    Select(id: 72, name: "Mushrooms"),
    Select(id: 73, name: "Hotdog/Corn Dog"),
    // Added the missing item
  ];
  // List<Select> foodallList = [
  //   Select(id: 1, name: "Bone in Wings"),
  //   Select(id: 2, name: "Boneless Wings"),
  //   Select(id: 3, name: "Pizza"),
  //   Select(id: 4, name: "Flat Bread"),
  //   Select(id: 5, name: "Burger"),
  //   Select(id: 6, name: "Sliders"),
  //   Select(id: 7, name: "Nachos"),
  //   Select(id: 8, name: "Nachos Chicken/Steak"),
  //   Select(id: 9, name: "Nachos- Ahi"),
  //   Select(id: 10, name: "Tacos"),
  //   Select(id: 11, name: "Taquitos/Flautas"),
  //    Select(id: 12, name: "Quesadilla"),
  //   Select(id: 13, name: "Fries"),
  //   Select(id: 14, name: "Fries- Loaded"),
  //   Select(id: 15, name: "Pretzels"),
  //   Select(id: 16, name: "Garlic Bread/Knots"),
  //   Select(id: 17, name: "Cheese Bread"),
  //   Select(id: 18, name: "Bruschetta"),
  //   Select(id: 19, name: "Mozzarella Sticks"),
  //   Select(id: 20, name: "Dip - Cheese"),
  //   Select(id: 21, name: "Dip- Spinach"),
  //   Select(id: 22, name: "Dip- Salsa"),
  //   Select(id: 23, name: "Dip- Guacamole"),
  //   Select(id: 24, name: "Dip- Artichoke"),
  //   Select(id: 25, name: "Dip- Hummus"),
  //   Select(id: 26, name: "Chicken- Tenders"),
  //   Select(id: 27, name: "Chicken- Fried"),
  //   Select(id: 28, name: "Chicken- Grilled"),
  //   Select(id: 28, name: "Chicken-Other"),
  //   Select(id: 29, name: "Potato Skins"),
  //   Select(id: 30, name: "Potatos- Loaded"),
  //   Select(id: 31, name: "Tater Tots"),
  //   Select(id: 32, name: "Tater Tots- Loaded"),
  //   Select(id: 33, name: "Chips/Crisps"),
  //   Select(id: 34, name: "Onion Rings"),
  //   Select(id: 35, name: "Onion Blossom"),
  //   Select(id: 36, name: "Zucchini"),
  //   Select(id: 37, name: "Jalapeno Poppers"),
  //   Select(id: 38, name: "Pickles- Fried"),
  //   Select(id: 39, name: "Mac and Cheese Bites"),
  //   Select(id: 40, name: "Combo Platter"),
  //   Select(id: 41, name: "Egg Roll"),
  //   Select(id: 42, name: "Dumpling/ Wonton/ Pot Sticker"),
  //   Select(id: 43, name: "Pita"),
  //   Select(id: 44, name: "Wrap"),
  //   Select(id: 45, name: "Sandwich- Cold"),
  //   Select(id: 46, name: "Sandwich- Hot"),
  //   Select(id: 47, name: "Soup"),
  //   Select(id: 48, name: "Salad"),
  //   Select(id: 49, name: "Pasta"),
  //   Select(id: 50, name: "Ravioli"),
  //   Select(id: 51, name: "Meatballs"),
  //   Select(id: 52, name: "Meatloaf"),
  //   Select(id: 53, name: "Kabab/Skewer"),
  //   Select(id: 54, name: "Steak"),
  //   Select(id: 55, name: "Ribs"),
  //   Select(id: 56, name: "Cheese Plate/Platter"),
  //   Select(id: 56, name: " Cheese- Curds"),
  //   Select(id: 57, name: "Cheese and Meat Platter"),
  //   Select(id: 58, name: "Carpaccio"),
  //   Select(id: 59, name: "Sushi- Roll"),
  //   Select(id: 60, name: "Sushi- Sashimi or Nigiri"),
  //   Select(id: 61, name: "Sushi- Handroll"),
  //   Select(id: 62, name: "Sushi- Platter"),
  //   Select(id: 63, name: "Poke"),
  //   Select(id: 64, name: "Edamame"),
  //   Select(id: 65, name: "Calamari"),
  //   Select(id: 66, name: "Shrimp"),
  //   Select(id: 67, name: "Oystersl"),
  //   Select(id: 68, name: "Scallops"),
  //   Select(id: 69, name: "Mussels"),
  //   Select(id: 70, name: "Crab- Cakes"),
  //   Select(id: 71, name: "Crab- Meat"),
  //   Select(id: 72, name: "Crab- Leggs"),
  //   Select(id: 73, name: "Crab- Whole"),
  //   Select(id: 74, name: "Fish and Chips"),
  //   Select(id: 75, name: "Other Fish Dish"),
  //   Select(id: 76, name: "Burrito"),
  //   Select(id: 77, name: "Empanadas"),
  //   Select(id: 78, name: "Tapas"),
  //   Select(id: 79, name: "Meat Pie"),
  //   Select(id: 80, name: "Mushrooms"),
  //   Select(id: 81, name: "Hotdog/Corn Dog"),
  //   Select(id: 82, name: "Fondue"),
  // ];

  List<LocalFoodModel> foodList = [];
  void addfoodmanually() {
    foodList.add(
      LocalFoodModel(
        name: addfoodManuallyController.text.toString(),
        quantity: 0,
        price: "",
        discount: 0,
        discountIcon: "%",
        dropDown: ["%", "\$"],
        priceController: TextEditingController(),
        earlyFood: true.obs,
        lateFood: true.obs,
        time: foodtime,
      ),
    );
    update();
  }

  void addFoodFromDropDownList(List foods) {
    for (var e in foods) {
      foodList.add(
        LocalFoodModel(
          name: e.name.toString(),
          quantity: 0,
          price: "",
          discount: 0,
          discountIcon: "%",
          dropDown: ["%", "\$"],
          priceController: TextEditingController(),
          earlyFood: true.obs,
          lateFood: true.obs,
          time: foodtime,
        ),
      );
      update();
    }
    Get.back();
  }

  void foodincrement(int index) {
    foodList[index].quantity++;
    update();
  }

  void fooddecrement(int index) {
    if (foodList[index].quantity > 0) {
      foodList[index].quantity--;
    } else {
      foodList[index].quantity;
    }
    update();
  }

  void removeFood(index) {
    foodList.removeAt(index);
    update();
  }

  String foodtime = "Both Time";
  foodBothTime(index) {
    foodList[index].time = foodtime;
    update();
  }

  foodfirstTime(index) {
    foodList[index].time = hFromTime.toString();
    update();
  }

  foodSecondTime(index) {
    foodList[index].time = hFromTime2.toString();
    update();
  }

  String drinktime = "Both Time";
  drinkBothTime(index) {
    localdrinkList[index].time = "Both Time";
    update();
  }

  drinkfirstTime(index) {
    localdrinkList[index].time = hFromTime.toString();
    update();
  }

  drinkSecondTime(index) {
    localdrinkList[index].time = hFromTime2.toString();
    update();
  }

  //Drink type drop down
  final _drinkDiscount = "%".obs;
  String get drinkDiscount => _drinkDiscount.value;
  set drinkDiscount(value) => _drinkDiscount.value = value;
  final drinkDiscountDropdown = ['%', '\$'];
  //Size type drop down
  final _sizeDropDown = "oz".obs;
  String get sizeDropdown => _sizeDropDown.value;
  set sizeDropDown(value) => _sizeDropDown.value = value;
  final sizeDropdownList = [
    'oz',
    'ml',
    'Can',
    'Tall Can',
    'Bottle',
    'Pint-Draft',
    'Large Draft',
    'Pitcher',
    'Glass',
    'Shot',
    'Bucket',
    'Flight'
  ];

  //*Drink Item Section*//
  List<LocalDrinkModel> localdrinkList = [];

  showEarlyTimeFood(index) {
    foodList[index].earlyFood.value = !foodList[index].earlyFood.value;
  }

  showLateTimeFood(index) {
    foodList[index].lateFood.value = !foodList[index].lateFood.value;
  }

  showEarlyTimeDrink(index) {
    localdrinkList[index].earlyDrink.value =
        !localdrinkList[index].earlyDrink.value;
  }

  showLateTimeDrink(index) {
    localdrinkList[index].lateDrink.value =
        !localdrinkList[index].lateDrink.value;
  }
  // showBothTimeDrink(index) {
  //   localdrinkList[index].bothTimeDrink.value =
  //       !localdrinkList[index].bothTimeDrink.value;
  // }

  void addDrinksmanually() {
    localdrinkList.add(
      LocalDrinkModel(
        name: addDrinksManuallyController.text.toString(),
        size: "",
        price: "",
        discount: 0,
        sizeicon: "",
        discounticon: "",
        dropDown: ["%", "\$"],
        dropDownSize: [
          'oz',
          'ml',
          'Can',
          'Tall Can',
          'Bottle',
          'Pint-Draft',
          'Large Draft',
          'Pitcher',
          'Glass',
          'Shot',
          'Bucket',
          'Flight'
        ],
        drinkController: TextEditingController(),
        bothTimeDrink: false.obs,
        earlyDrink: true.obs,
        lateDrink: true.obs,
        time: drinktime,
      ),
    );

    update();
  }

  void addDrinkFromDropDownList(List drinks) {
    for (var e in drinks) {
      localdrinkList.add(
        LocalDrinkModel(
            name: e.name.toString(),
            size: "",
            price: "",
            discount: 0,
            sizeicon: "",
            discounticon: "",
            dropDown: ["%", "\$"],
            dropDownSize: [
              'oz',
              'ml',
              'Can',
              'Tall Can',
              'Bottle',
              'Pint-Draft',
              'Large Draft',
              'Pitcher',
              'Glass',
              'Shot',
              'Bucket',
             'Flight'
            ],
            drinkController: TextEditingController(),
            bothTimeDrink: false.obs,
            time: drinktime,
            earlyDrink: true.obs,
            lateDrink: true.obs),
      );
      update();
    }
    Get.back();
  }

  void removeDrink(index) {
    localdrinkList.removeAt(index);
    update();
  }

  List<Select> drinkList = [
    Select(id: 1, name: "Domestic Beer"),
    Select(id: 2, name: "Craft Beer"),
    Select(id: 3, name: "Import Beer"),
    Select(id: 4, name: "Mexican Beer"),
    Select(id: 5, name: "Michelada"),
    Select(id: 6, name: "Wine"),
    Select(id: 7, name: "Old Fashion-Well"),
    Select(id: 8, name: "Old Fashion- Premium"),
    Select(id: 9, name: "Brandi"),
    Select(id: 10, name: "You call it- Well"),
    Select(id: 11, name: "You call it- Premium"),
    Select(id: 12, name: "Mixed Drink- Well"),
    Select(id: 13, name: "Mixed Drink- Premium"),
    Select(id: 14, name: "Margarita-Well"),
    Select(id: 15, name: "Margarita- Premium"),
    Select(id: 16, name: "Martini- Well"),
    Select(id: 17, name: "Martini- Premium"),
    Select(id: 18, name: "Bloody Mary-Well"),
    Select(id: 19, name: "Bloody Mary- Premium"),
    Select(id: 20, name: "Mojito- Well"),
    Select(id: 21, name: "Mojito- Premium"),
    Select(id: 22, name: "Long Island- Well"),
    Select(id: 23, name: "Long Island- Premium"),
    Select(id: 24, name: "Pina Colada/ Daiquiri-Well"),
    Select(id: 25, name: "Pina Colada/ Daiquiri- Premium"),
    Select(id: 26, name: "Other Whisky/Bourbon Drink- Well"),
    Select(id: 27, name: " Other Whisky/Bourbon Drink - Premium"),
    Select(id: 28, name: "Other Vodka Drink- Well"),
    Select(id: 29, name: "Other Vodka Drink- Premium"),
    Select(id: 30, name: "Other Rum Drink- Well"),
    Select(id: 31, name: "Other Rum Drink- Premium"),
    Select(id: 32, name: "Other Gin Drink- Well"),
    Select(id: 33, name: "Other Gin Drink- Premium"),
    Select(id: 34, name: "Other Tequila/Mezcal Drink- Well"),
    Select(id: 35, name: "Other Tequila/Mezcal Drink- Premium"),
    Select(id: 36, name: "Sangria"),
    Select(id: 37, name: "Sake"),
    Select(id: 38, name: "Seltzer"),
    Select(id: 39, name: "Mule"),
  ];

  //* DailySpecial Sections * //
  final adddailySpecialManuallyController = TextEditingController();
  final dailySpecialPrice = TextEditingController();
  final dailySpecialKey = GlobalKey<FormState>();

  int? dailySpecialQuantity = 0;
  String? sundaydailySpecialType;
  String? mondaydailySpecialType;
  String? tuesdaydailySpecialType;
  String? wednesdaydailySpecialType;
  String? thursdaydailySpecialType;
  String? fridaydailySpecialType;
  String? saturdaydailySpecialType;
  String? dailSpecialName;

  String dailySpecialfromtime = "01:00 AM";
  String dailySpecialtotime = "02:00 AM";
  String dailyspecialsunDay = "Sunday";
  String dailyspecialmonDay = "Monday";
  String dailyspecialtuesDay = "Tuesday";
  String dailyspecialwedDay = "Wednesday";
  String dailyspecialthursDay = "Thursday";
  String dailyspecialfriDay = "Friday";
  String dailyspecialsaturDay = "Saturday";
  final dailyDropDown = ["Foods", "Drinks"];

  List alldailySpecialList = [];

  void updatesunday(daily) {
    sundaydailySpecialType = daily!;
    update();
  }

  addToDailyySpecial() {
    List alldailySpecial = [];
    for (var e in sundaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in mondaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in tuesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in wednesdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in thursdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in fridaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discountIcon": e["discountIcon"],
        "discount": e["discount"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    for (var e in saturdaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    alldailySpecialList.addAll(alldailySpecial);
    update();
  }

  List sundaydailySpecialItemList = [];
  List mondaydailySpecialItemList = [];
  List tuesdaydailySpecialItemList = [];
  List wednesdaydailySpecialItemList = [];
  List thursdaydailySpecialItemList = [];
  List fridaydailySpecialItemList = [];
  List saturdaydailySpecialItemList = [];

  sundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void sundaydailySpecialincrement(int index) {
    sundaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void sundaydailySpecialdecrement(int index) {
    if (sundaydailySpecialItemList[index]["quantity"] > 0) {
      sundaydailySpecialItemList[index]["quantity"]--;
    } else {
      sundaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removesunday(index) {
    sundaydailySpecialItemList.removeAt(index);
    update();
  }

  mondayAddTodailySpecialItemList() {
    mondaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallysundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallymondayAddTodailySpecialItemList() {
    mondaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallytuesdayAddTodailySpecialItemList() {
    tuesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallywednesdayAddTodailySpecialItemList() {
    wednesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialwedDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": wednesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallythursdayAddTodailySpecialItemList() {
    thursdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallyfridayAddTodailySpecialItemList() {
    fridaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  addManuallysaturdayAddTodailySpecialItemList() {
    saturdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void mondaydailySpecialincrement(int index) {
    mondaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void mondaydailySpecialdecrement(int index) {
    if (mondaydailySpecialItemList[index]["quantity"] > 0) {
      mondaydailySpecialItemList[index]["quantity"]--;
    } else {
      mondaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removemonday(index) {
    mondaydailySpecialItemList.removeAt(index);
    update();
  }

  tuesdayAddTodailySpecialItemList() {
    tuesdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void tuesdaydailySpecialincrement(int index) {
    tuesdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void tuesdaydailySpecialdecrement(int index) {
    if (tuesdaydailySpecialItemList[index]["quantity"] > 0) {
      tuesdaydailySpecialItemList[index]["quantity"]--;
    } else {
      tuesdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removetuesday(index) {
    tuesdaydailySpecialItemList.removeAt(index);
    update();
  }

  wednesdayAddTodailySpecialItemList() {
    wednesdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialwedDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": wednesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void wednesdaydailySpecialincrement(int index) {
    wednesdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void wednesdaydailySpecialdecrement(int index) {
    if (wednesdaydailySpecialItemList[index]["quantity"] > 0) {
      wednesdaydailySpecialItemList[index]["quantity"]--;
    } else {
      wednesdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removewednesday(index) {
    wednesdaydailySpecialItemList.removeAt(index);
    update();
  }

  thursdayAddTodailySpecialItemList() {
    thursdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void thursdaydailySpecialincrement(int index) {
    thursdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void thursdaydailySpecialdecrement(int index) {
    if (thursdaydailySpecialItemList[index]["quantity"] > 0) {
      thursdaydailySpecialItemList[index]["quantity"]--;
    } else {
      thursdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removethursday(index) {
    thursdaydailySpecialItemList.removeAt(index);
    update();
  }

  fridayAddTodailySpecialItemList() {
    fridaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void fridaydailySpecialincrement(int index) {
    fridaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void fridaydailySpecialdecrement(int index) {
    if (fridaydailySpecialItemList[index]["quantity"] > 0) {
      fridaydailySpecialItemList[index]["quantity"]--;
    } else {
      fridaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removefriday(index) {
    fridaydailySpecialItemList.removeAt(index);
    update();
  }

  saturdayAddTodailySpecialItemList() {
    saturdaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "discountIcon": "%",
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    update();
  }

  void saturdaydailySpecialincrement(int index) {
    saturdaydailySpecialItemList[index]["quantity"]++;
    update();
  }

  void saturdaydailySpecialdecrement(int index) {
    if (saturdaydailySpecialItemList[index]["quantity"] > 0) {
      saturdaydailySpecialItemList[index]["quantity"]--;
    } else {
      saturdaydailySpecialItemList[index]["quantity"];
    }
    update();
  }

  void removesaturday(index) {
    saturdaydailySpecialItemList.removeAt(index);
    update();
  }

  void dailySpecialTap() {
    var index = daysList.where((e) => e.isSelect.isTrue).length;

    bool isSundayQuantityV = true;
    for (var element in sundaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isSundayQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isSundayQuantityV");
      }
    }

    bool isMondayQuantityV = true;
    for (var element in mondaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isMondayQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isMondayQuantityV");
      }
    }

    bool isTeusdayQuantityV = true;
    for (var element in tuesdaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isTeusdayQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isTeusdayQuantityV");
      }
    }

    bool isWedQuantityV = true;
    for (var element in wednesdaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isWedQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isWedQuantityV");
      }
    }
    bool isThursdayQuantityV = true;
    for (var element in thursdaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isThursdayQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isThursdayQuantityV");
      }
    }
    bool isFridayQuantityV = true;
    for (var element in fridaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isFridayQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isFridayQuantityV");
      }
    }

    bool isSatudaryQuantityV = true;
    for (var element in saturdaydailySpecialItemList) {
      if (element["quantity"].toString() == "0") {
        isSatudaryQuantityV = false;
      }
      if (kDebugMode) {
        print("isSunday $isSatudaryQuantityV");
      }
    }

    bool isSunday = true;
    bool isMonday = true;
    bool isTuesday = true;
    bool isWednesday = true;
    bool isThursday = true;
    bool isFriday = true;
    bool isSaturday = true;
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Sunday") {
        isSunday = false;
        if (sundaydailySpecialItemList.isNotEmpty) {
          isSunday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Monday") {
        isMonday = false;
        if (mondaydailySpecialItemList.isNotEmpty) {
          isMonday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Tuesday") {
        isTuesday = false;
        if (tuesdaydailySpecialItemList.isNotEmpty) {
          isTuesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Wednesday") {
        isWednesday = false;
        if (wednesdaydailySpecialItemList.isNotEmpty) {
          isWednesday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Thursday") {
        isThursday = false;
        if (thursdaydailySpecialItemList.isNotEmpty) {
          isThursday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Friday") {
        isFriday = false;
        if (fridaydailySpecialItemList.isNotEmpty) {
          isFriday = true;
        }
      }
    }
    for (var element in daysList) {
      if (element.isSelect.isTrue && element.day == "Saturday") {
        isSaturday = false;
        if (saturdaydailySpecialItemList.isNotEmpty) {
          isSaturday = true;
        }
      }
    }

    if (!dailySpecialKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Fill All The Required Fields");
    } else if (index == 0) {
      addToDailyySpecial();
      Get.toNamed(Routes.guestAmenitiesScreen);
    } else if (isSunday == false ||
        isMonday == false ||
        isTuesday == false ||
        isWednesday == false ||
        isThursday == false ||
        isFriday == false ||
        isSaturday == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Add Items against Day");
    } else if (dailySpecialKey.currentState!.validate()) {
      if (isSunday &&
          isSundayQuantityV &&
          isMonday &&
          isMondayQuantityV &&
          isTuesday &&
          isTeusdayQuantityV &&
          isWednesday &&
          isWedQuantityV &&
          isThursday &&
          isThursdayQuantityV &&
          isFriday &&
          isFridayQuantityV &&
          isSaturday &&
          isSatudaryQuantityV) {
        addToDailyySpecial();
        Get.toNamed(Routes.guestAmenitiesScreen);
      }
    }
  }

  List<String> dri = [
    "Domestic Beer",
    "Craft Beer",
    "Import Beer",
    "Mexican Beer",
    "Michelada",
    "Wine",
    "Old Fashion-Well",
     "Old Fashion- Premium",
    "Brandi",
    "You call it- Well",
    "You call it- Premium",
    "Mixed Drink- Well",
    "Mixed Drink- Premium",
    "Margarita-Well",
    "Margarita- Premium",
    "Martini- Well",
    "Martini- Premium",
    "Bloody Mary-Well",
    "Bloody Mary- Premium",
    "Mojito- Well",
    "Mojito- Premium",
    "Long Island- Well",
    "Long Island- Premium",
    "Pina Colada/ Daiquiri-Well",
    "Pina Colada/ Daiquiri- Premium",
    "Other Whisky/Bourbon Drink- Well",
    "Other Whisky/Bourbon Drink - Premium",
    "Other Vodka Drink- Well",
    "Other Vodka Drink- Premium",
    "Other Rum Drink- Well",
    "Other Rum Drink- Premium",
    "Other Gin Drink- Well",
    "Other Gin Drink- Premium",
    "Other Tequila/Mezcal Drink- Well",
    "Other Tequila/Mezcal Drink- Premium",
    "Sangria",
    "Sake",
    "Seltzer",
    "Mule",
  ];
  List<String> foo = [
    "Bone in Wings",
    "Boneless Wings",
    "Pizza",
    "Flat Bread",
    "Burger",
    "Sliders",
    "Nachos",
    "Nachos- Ahi",
    "Tacos",
    "Taquitos/Flautas",
    "Quesadilla",
    "Fries",
    "Pretzels",
    "Garlic Bread/Knots/Cheese Bread",
    "Bruschetta",
    "Mozzarella Sticks",
    "Dip - Cheese",
    "Dip- Spinach and/or Artichoke",
    "Dip- Salsa",
    "Dip- Guacamole",
    "Dip- Hummus",
    "Chicken- Fried/Tenders",
    "Chicken- Grilled",
    "Chicken-Other",
    "Potatoes- Skins/Baked/Loaded",
    "Tater Tots-Plain/Loaded",
    "Chips/Crisps",
    "Onion Rings/Blossom",
    "Sprouts",
    "Zucchini",
    "Jalapeno Poppers",
    "Pickles- Fried",
    "Mac and Cheese Bites",
    "Combo Platter",
    "Egg Roll",
    "Dumpling/ Wonton/ Pot Sticker",
    "Pita",
    "Wrap",
    "Sandwich- Cold",
    "Sandwich- Hot",
    "Soup",
    "Salad",
    "Pasta- Ravioli/Spaghetti/Other",
    "Meatballs",
    "Meatloaf",
    "Kabab/Skewer",
    "Steak",
      "Prime Rib",
    "Ribs",
    "BBQ-Other",
    "Cheese and/or Meat Platter",
    "Olives",
    "Sushi- Roll/Sashimi/Nigiri/Handroll",
    "Poke",
     "Ceviche",
    "Edamame",
    "Calamari",
    "Shrimp",
    "Oysters",
    "Scallops",
    "Mussels",
        "Clams",
    "Crab- Cakes/Meat/Legs/Other",
      "Seafood-Other",
    "Fish and Chips",
    "Other Fish Dish",
    "Burrito",
    "Empanadas",
    "Tapas",
    "Meat Pie",
    "Mushrooms",
    "Hotdog/Corn Dog",
  ];
  // List<String> foo = [
  //   "Bone in Wings",
  //   "Boneless Wings",
  //   "Pizza",
  //   "Flat Bread",
  //   "Burger",
  //   "Sliders",
  //   "Nachos",
  //   "Nachos- Ahi",
  //   "Tacos",
  //   "Taquitos/Flautas",
  //   "Quesadilla", // Updated spelling
  //   "Fries",
  //   "Pretzels",
  //   "Garlic Bread/Knots/Cheese Bread",
  //   "Bruschetta",
  //   "Mozzarella Sticks",
  //   "Dip – Cheese",
  //   "Dip- Spinach and/or Artichoke",
  //   "Dip- Salsa",
  //   "Dip- Guacamole",
  //   "Dip- Hummus",
  //   "Chicken- Fried/Tenders",
  //   "Chicken- Grilled",
  //   "Potatoes- Skins/Baked/Loaded",
  //   "Tater Tots-Plain/Loaded",
  //   "Chips/Crisps",
  //   "Onion Rings/Blossom",
  //   "Zucchini",
  //   "Jalapeno Poppers",
  //   "Pickles- Fried",
  //   "Mac and Cheese Bites",
  //   "Combo Platter",
  //   "Egg Roll",
  //   "Dumpling/ Wonton/ Pot Sticker",
  //   "Pita",
  //   "Wrap",
  //   "Sandwich- Cold",
  //   "Sandwich- Hot",
  //   "Soup",
  //   "Salad",
  //   "Pasta- Ravioli/Spaghetti/Other",
  //   "Meatballs",
  //   "Meatloaf",
  //   "Kabab/Skewer",
  //   "Steak",
  //   "Ribs",
  //   "BBQ-Other",
  //   "Cheese and/or Meat Platter",
  //   "Sushi- Roll/Sashimi/Nigiri/Handroll",
  //   "Poke",
  //   "Edamame",
  //   "Calamari",
  //   "Shrimp",
  //   "Oysters",
  //   "Scallops",
  //   "Mussels",
  //   "Crab- Cakes/Meat/Legs/Other",
  //   "Fish and Chips",
  //   "Other Fish Dish",
  //   "Burrito",
  //   "Empanadas",
  //   "Tapas",
  //   "Meat Pie",
  //   "Mushrooms",
  //   "Hotdog/Corn Dog",
  //   "Fondue",
  // ];

  //* Amenities Section *//
  String amenity = '';
  List<String> amentyAddList = [];
  List<Amenities> amenitiesList = [
    Amenities(isSelect: false.obs, amenity: "Pool Table"),
    Amenities(isSelect: false.obs, amenity: "Dart Boards"),
    Amenities(isSelect: false.obs, amenity: "Juke Box"),
    Amenities(isSelect: false.obs, amenity: "Arcade"),
    Amenities(isSelect: false.obs, amenity: "Shuffle Board"),
    Amenities(isSelect: false.obs, amenity: "Board Games"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Smoking"),
    Amenities(isSelect: false.obs, amenity: "Indoor Smoking"),
    Amenities(isSelect: false.obs, amenity: "No Smoking"),
    Amenities(isSelect: false.obs, amenity: "NFL Package"),
    Amenities(isSelect: false.obs, amenity: "NBA Package"),
    Amenities(isSelect: false.obs, amenity: "MLB Package"),
    Amenities(isSelect: false.obs, amenity: "Soccer/Football Package"),
    Amenities(isSelect: false.obs, amenity: "UFC PPV"),
    Amenities(isSelect: false.obs, amenity: "Boxing PPV"),
    Amenities(isSelect: false.obs, amenity: "Casino"),
    Amenities(isSelect: false.obs, amenity: "Large Screens"),
    Amenities(isSelect: false.obs, amenity: "Pool (Swimming)"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Seating Assigned"),
    Amenities(isSelect: false.obs, amenity: "Outdoor Space Unassigned"),
    Amenities(isSelect: false.obs, amenity: "Beach/Water Front"),
    Amenities(isSelect: false.obs, amenity: "Amazing Views"),
  ];

  void updateAmenity() async {
    for (var e in amenitiesList) {
      if (e.isSelect.value == true) {
        amenity = e.amenity;
        update();
      }
    }
  }

  //*BarType List Section *//
  String barType = '';
  List<String> barTypeAddList = [];
  List<BarType> barTypeList = [
    BarType(isSelect: false.obs, barType: "Restaurant"),
    BarType(isSelect: false.obs, barType: "Restaurant with Bar"),
    BarType(isSelect: false.obs, barType: "Bar-Only"),
    BarType(isSelect: false.obs, barType: "Bar with Food"),
    BarType(isSelect: false.obs, barType: "Sports Bar"),
    BarType(isSelect: false.obs, barType: "Brewery"),
    BarType(isSelect: false.obs, barType: "Owner Owned"),
    BarType(isSelect: false.obs, barType: "Corporate Owned"),
    BarType(isSelect: false.obs, barType: "Dive"),
    BarType(isSelect: false.obs, barType: "Upscale"),
    BarType(isSelect: false.obs, barType: "Ulta High-End"),
    BarType(isSelect: false.obs, barType: "Winery"),
    BarType(isSelect: false.obs, barType: "Distillery"),
    BarType(isSelect: false.obs, barType: "Pool Hall"),
    BarType(isSelect: false.obs, barType: "Bowling Alley"),
    BarType(isSelect: false.obs, barType: "Casino"),
    BarType(isSelect: false.obs, barType: "Club"),
    BarType(isSelect: false.obs, barType: "Strip Club"),
    BarType(isSelect: false.obs, barType: "Roof Top"),
    // BarType(isSelect: false.obs, barType: "Restaurant- Corporate"),
    // BarType(isSelect: false.obs, barType: "Restaurant- Owner"),
    // BarType(isSelect: false.obs, barType: "Bar- Standard"),
    // BarType(isSelect: false.obs, barType: "Bar- Upscale"),
    // BarType(isSelect: false.obs, barType: "Bar- Dive"),
    // BarType(isSelect: false.obs, barType: "Sports Bar"),
    // BarType(isSelect: false.obs, barType: "Brewery"),
    // BarType(isSelect: false.obs, barType: "Winery"),
    // BarType(isSelect: false.obs, barType: "Distillery"),
    // BarType(isSelect: false.obs, barType: "Pool Hall"),
    // BarType(isSelect: false.obs, barType: "Bowling Alley"),
    // BarType(isSelect: false.obs, barType: "Casino"),
    // BarType(isSelect: false.obs, barType: "Club"),
    // BarType(isSelect: false.obs, barType: "Strip Club"),
  ];

  void updateBartype(index) async {
    if (barTypeList[index].isSelect.isTrue) {
      barTypeAddList.add(barTypeList[index].barType);
    } else if (barTypeAddList.contains(barTypeList[index].barType)) {
      barTypeAddList.remove(barTypeList[index].barType);
    }
    // for (var e in barTypeList) {
    //   if (e.isSelect.isTrue) {
    //     barType = e.barType;
    //     update();
    //   }
    // }
  }

  //*Event Section*//
  final eventKey = GlobalKey<FormState>();
  String eventStarttime = "01:00 AM";
  String eventendtime = "01:00 PM";

  List selectedEvent = [];
  List<Event> eventList = [
    Event(
      isSelect: false.obs,
      event: "Pool Tournament",
      day: '',
      fromtime: "",
      totime: "",
    ),
    Event(
      isSelect: false.obs,
      event: "Free Pool",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Dart Tournament",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Cornhole Tournment",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Beer Pong Tournament",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Other Tournament",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Karaoke",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Trivia Night",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Live Music ",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Comedy Night",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Open Mic",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Paint and Sip",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Ladies Night",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
    Event(
      isSelect: false.obs,
      event: "Industry Night",
      day: "",
      fromtime: "",
      totime: "",
      //key: null,
    ),
  ];

  String? eventname = "";

  eventListadded(index) {
    bool isAlreadyExist = false;
    for (var element in selectedEvent) {
      if (element['name'] == eventList[index].event) {
        isAlreadyExist = true;
      }
    }
    if (!isAlreadyExist) {
      selectedEvent.add({
        "name": eventList[index].event,
        "day": day,
        "fromtime": eventStarttime,
        "totime": eventendtime
      });
    } else {
      selectedEvent
          .removeWhere((element) => element['name'] == eventList[index].event);
    }
    if (kDebugMode) {
      print(selectedEvent.toString());
    }
    update();
  }

  List<SelectDay> daysList = [
    SelectDay(
      isSelect: false.obs,
      day: "Sunday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Monday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Tuesday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Wednesday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Thursday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Friday",
    ),
    SelectDay(
      isSelect: false.obs,
      day: "Saturday",
    ),
  ];

  final _isShowMap = true.obs;
  bool get isShowMap => _isShowMap.value;
  set isShowMap(value) => _isShowMap.value = value;

  final businessKey = GlobalKey<FormState>();

  // void onDayTimeNextTap() {
  //   var index = dayTimeList.where((e) => e.isSelect.isTrue).length;
  //   if (index == 0) {
  //     Get.toNamed(Routes.guestFoodItemScreen);
  //   }
  //   if (!businessKey.currentState!.validate()) {
  //     Get.find<GlobalGeneralController>().errorSnackbar(
  //         title: "Select Time", description: "Please Select all the Time");
  //   }
  //   if (businessKey.currentState!.validate()) {
  //     for (var i = 0; i < dayTimeList.length; i++) {
  //       if (dayTimeList[i].isSelect.isTrue &&
  //           dayTimeList[i].fromTime != "" &&
  //           dayTimeList[i].toTime != "") {
  //         Get.toNamed(Routes.guestFoodItemScreen);
  //       }
  //     }
  //   }
  // }

  final ScrollController scrollController = ScrollController();
  final double _height = 100.0;

  void animateToIndex(int index) {
    scrollController.animateTo(
      index * _height,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  bool lateHappyHourForValidationOnly = false;

  void onDayTimeNextTap() {
    var index = dayTimeList.where((e) => e.isSelect.isTrue).length;

    if (index == 0) {
      if (kDebugMode) {
        print("1");
      }
      if (showLateDayList) {
        if (kDebugMode) {
          print("2");
        }
        if (showLateDayList) {
          if (kDebugMode) {
            print("3");
          }
          Get.toNamed(Routes.guestFoodItemScreen);
        } else {
          if (kDebugMode) {
            print("4");
          }
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Late Happy Hour",
              description: "Please Select all the Time");
        }
      } else {
        if (kDebugMode) {
          print("5");
        }
        if (!businessKey.currentState!.validate()) {
          if (kDebugMode) {
            print("6");
          }
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Select Time", description: "Please Select all the Time");
        } else {
          if (kDebugMode) {
            print("7");
          }
          if (businessKey.currentState!.validate()) {
            if (kDebugMode) {
              print("8");
            }
            for (var i = 0; i < dayTimeList.length; i++) {
              if (dayTimeList[i].isSelect.isTrue &&
                  dayTimeList[i].fromTime != "" &&
                  dayTimeList[i].toTime != "") {
                if (kDebugMode) {
                  print("9");
                }

                Get.toNamed(Routes.guestFoodItemScreen);
              }
            }
            Get.toNamed(Routes.guestFoodItemScreen);
          }
        }
        Get.toNamed(Routes.guestFoodItemScreen);
      }
    } else {
      if (showLate) {
        if (kDebugMode) {
          print("10");
        }
        if (lateHappyHourForValidationOnly) {
          if (kDebugMode) {
            print("11");
          }
          Get.toNamed(Routes.guestFoodItemScreen);
        } else {
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Select Time",
              description: "Please Select late time offer");
        }
      } else {
        if (kDebugMode) {
          print("12");
        }
        Get.toNamed(Routes.guestFoodItemScreen);
      }
    }

    // var index = dayTimeList.where((e) => e.isSelect.isTrue).length;
    // if (index == 0) {
    //   Get.toNamed(Routes.businessFoodItemScreen);
    // }
    // if (!businessKey.currentState!.validate()) {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: "Select Time", description: "Please Select all the Time");
    // }
    // if (businessKey.currentState!.validate()) {
    //   for (var i = 0; i < dayTimeList.length; i++) {
    //     if (dayTimeList[i].isSelect.isTrue &&
    //         dayTimeList[i].fromTime != "" &&
    //         dayTimeList[i].toTime != "") {
    //       Get.toNamed(Routes.businessFoodItemScreen);
    //     }
    //   }
    // }else {
    //   if (showLate) {
    //     print("10");
    //     if (lateHappyHourForValidationOnly) {
    //       print("11");
    //       Get.toNamed(Routes.addHappyHourFoodItemScreen);
    //     } else {
    //       Get.find<GlobalGeneralController>().errorSnackbar(
    //           title: "Select Time",
    //           description: "Please Select late time offer");
    //     }
    //   } else {
    //     print("12");
    //     Get.toNamed(Routes.addHappyHourFoodItemScreen);
    //   }
    // }
  }

  final _showDaysList = false.obs;
  bool get showDayList => _showDaysList.value;
  set showDayList(value) => _showDaysList.value = value;

  final _showLate = false.obs;
  bool get showLate => _showLate.value;
  set showLate(value) => _showLate.value = value;

  final _showLateDaysList = false.obs;
  bool get showLateDayList => _showLateDaysList.value;
  set showLateDayList(value) => _showLateDaysList.value = value;

  void addToHday(int i) {
    hDayTimeList.add({
      "Hday": dayTimeList[i].day,
      "HfromTime": hFromTime,
      "HtoTime": hToTime,
    });
  }

  void removeToHday(int i) {
    hDayTimeList
        .removeWhere((element) => element['Hday'] == dayTimeList[i].day);
    // hDayTimeList.remove({
    //   "Hday": dayTimeList[i].day,
    //   "HfromTime": hFromTime,
    //   "HtoTime": hToTime,
    // });
  }

  void hDayTimeSecond(index) {
    var a = hDayTimeLateList
        .where((e) => e['Hday2'].toString() == dayTimeList[index].day)
        .toList();

    if (a.isEmpty) {
      hDayTimeLateList.add({
        "Hday2": dayTimeList[index].day,
        "HfromTime2": dayTimeList[index].fromTime2,
        "HtoTime2": dayTimeList[index].toTime2
      });
    }
  }

  void hUpdateDaySecond(index) async {
    dayTimeList[index].isLate.isTrue
        ? hDay = dayTimeList[index].day.toString()
        : hDayTimeLateList
            .removeWhere((e) => e['Hday2'] == dayTimeList[index].day);
  }

  void addToHdaySecond(int i) {
    hDayTimeLateList.add({
      "Hday2": dayTimeList[i].day,
      "HfromTime2": hFromTime2,
      "HtoTime2": hToTime2,
    });
  }

  void removeToHdaySecond(int i) {
    hDayTimeLateList
        .removeWhere((element) => element['Hday2'] == dayTimeList[i].day);
    // hDayTimeLateList.remove({
    //   "Hday2": dayTimeList[i].day,
    //   "HfromTime2": hFromTime2,
    //   "HtoTime2": hToTime2,
    // });
  }

  void onBusinessnextTap() {
    if (formKey.currentState!.validate()) {
      if (happyHourMultiImages.isEmpty) {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Image",
            description: "Make sure you have picked all The images");
      } else if (formKey.currentState!.validate() &&
          happyHourMultiImages.isNotEmpty) {
        Get.toNamed(Routes.guestDayTimeScreen);
      }
    }
  }

  final geo = Geoflutterfire();

  Future<void> uploadBusinessHourToFireStore() async {
    if (formKey.currentState!.validate() && isTermChecked == true) {
      GeoFirePoint _position = geo.point(latitude: _lat, longitude: _long);
      isLoading = true;
      await _addHappyHourProvider.uploadToFirebaseStorage(
        accountType: 'guest',
        businessName: businessNameController.text,
        businessAddress: businessAddressController.text,
        description: descriptionController.text,
        menuImage: await _addHappyHourProvider
            .uploadBusinessMenuImageImageToFirebaseStorage(
                menuImage: happyHourMultiImages.first.path),
        menuImage2: await _addHappyHourProvider
            .uploadBusinessMenuImageImageToFirebaseStorage(
                menuImage: happyHourMultiImages.last.path),
        dayTime: hDayTimeList,
        daytimeLate: hDayTimeLateList,
        foodNames: foodList
            .map((e) => {
                  "foodname": e.name,
                  "foodcount": e.quantity,
                  "fooddiscount": e.discount,
                  "discountIcon": e.discountIcon,
                  "foodprice": e.price,
                  "early": e.earlyFood.value,
                  "late": e.lateFood.value,
                })
            .toList(),
        drinkitemNames: localdrinkList
            .map((e) => {
                  "drinkname": e.name,
                  "drinksize": e.size,
                  "drinkprice": e.price,
                  "drinkdiscount": e.discount,
                  "sizeIcon": e.sizeicon,
                  "discountIcon": e.discounticon,
                  "early": e.earlyDrink.value,
                  "late": e.lateDrink.value,
                })
            .toList(),
        fromTimeToTime: [],
        dailySpecial: alldailySpecialList,
        amenities: amentyAddList,
        barType: barTypeAddList,
        event: selectedEvent,
        id: "",
        position: _position,
        latLong: {
          "latitude": _lat,
          "longitude": _long,
        },
      );
      await Get.to(() => const GuestHappyHourRequestSubmittedScreen());
      isLoading = false;
    }
  }

  bool checkEmptyEventValues(int index) {
    bool checkEmpty = false;
    checkEmpty = (selectedEvent[index]['day'] == "Select Day" ||
            selectedEvent[index]['day'] == "") ||
        (selectedEvent[index]['fromtime'] == "Select time" ||
            selectedEvent[index]['fromtime'] == "") ||
        (selectedEvent[index]['totime'] == "Select time" ||
            selectedEvent[index]['totime'] == "");
    return checkEmpty;
  }

  void submitHappyHour() {
    if (eventKey.currentState!.validate() == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Select Day and Times");
    }
    if (eventKey.currentState?.validate() ?? false) {
      bool found = false;
      if (isTermChecked == true) {
        for (int i = 0; i < selectedEvent.length; i++) {
          if (checkEmptyEventValues(i)) {
            found = true;
          }
        }
        if (!found) {
          uploadBusinessHourToFireStore();
        } else {
          Get.find<GlobalGeneralController>().errorSnackbar(
              title: "Error", description: "Select Day and Times");
        }
      } else {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Error", description: "Check Term and Condition");
      }
    }
  }

  addIntoList(String name, int index) {
    eventKey.currentState?.reset();
    var a = selectedEvent.where((element) => element['name'] == name);

    if (a.isEmpty) {
      var model = {"name": name, "day": '', "fromtime": '', "totime": ''};
      selectedEvent.add(model);

      for (int b = 0; b < selectedEvent.length; b++) {
        for (int i = 0; i < eventList.length; i++) {
          if (selectedEvent[b]['name'].toLowerCase() ==
              eventList[i].event.toLowerCase()) {
            eventList[i].day = selectedEvent[b]['day'];

            eventList[i].totime = selectedEvent[b]['totime'];

            eventList[i].fromtime = selectedEvent[b]['fromtime'];

            eventList[i].isSelect.value = true;
          }
        }
      }

      update();
    } else {
      selectedEvent.removeWhere((element) => element['name'] == name);
      for (int b = 0; b < selectedEvent.length; b++) {
        for (int i = 0; i < eventList.length; i++) {
          if (selectedEvent[b]['name'].toLowerCase() ==
              eventList[i].event.toLowerCase()) {
            eventList[i].day = selectedEvent[b]['day'];

            eventList[i].totime = selectedEvent[b]['totime'];

            eventList[i].fromtime = selectedEvent[b]['fromtime'];

            eventList[i].isSelect.value = true;
          }
        }
      }
      update();
    }
  }

  assignDayValue(String day, name) {
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["day"] = day;
      }
    }
  }

  assignFromTimeValue(String startTime, name) {
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["fromtime"] = startTime;
      }
    }
  }

  assignToTimeValue(String endtime, name) {
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["totime"] = endtime;
      }
    }
  }
}

class Event {
  late RxBool isSelect;
  late String event;
  late String day;
  late String fromtime;
  late String totime;
  //late GlobalKey<FormState>? key;

  Event({
    required this.isSelect,
    required this.event,
    required this.day,
    required this.fromtime,
    required this.totime,
    //this.key,
  });
}

class SelectDay {
  late RxBool isSelect;
  late String day;

  SelectDay({
    required this.isSelect,
    required this.day,
  });
}

class SelectDayTime {
  late RxBool isSelect;
  late String day;
  late String image;
  late String fromTime;
  late String toTime;
  late List? secondTime;

  SelectDayTime({
    required this.isSelect,
    required this.day,
    required this.image,
    required this.fromTime,
    required this.toTime,
    this.secondTime,
  });
}

class LateDayTime {
  late RxBool isSelect;
  late String day;
  late String image;
  late String fromTime;
  late String toTime;
  late String? fromTime2;
  late String? toTime2;
  late List? secondTime;
  late RxBool isEarly;
  late RxBool isLate;

  LateDayTime({
    required this.isSelect,
    required this.day,
    required this.image,
    required this.fromTime,
    required this.toTime,
    required this.isEarly,
    required this.isLate,
    this.fromTime2,
    this.toTime2,
    this.secondTime,
  });
}

class Amenities {
  late RxBool isSelect;
  late String amenity;

  Amenities({
    required this.isSelect,
    required this.amenity,
  });
}

class BarType {
  late RxBool isSelect;
  late String barType;

  BarType({
    required this.isSelect,
    required this.barType,
  });
}

class LocalFoodModel {
  late String name;
  late int quantity;
  late String price;
  late int discount;
  late String discountIcon;
  List<String> dropDown;
  TextEditingController priceController;
  TextEditingController? discountController;
  RxBool earlyFood;
  RxBool lateFood;
  String time;

  LocalFoodModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.dropDown,
    required this.discountIcon,
    required this.priceController,
    this.discountController,
    required this.earlyFood,
    required this.lateFood,
    required this.time,
  });
}

class LocalDrinkModel {
  late String name;
  late String size;
  late String price;
  late int discount;
  late String sizeicon;
  late String discounticon;
  List<String> dropDown;
  List<String> dropDownSize;
  TextEditingController drinkController;
  TextEditingController? discountController;
  TextEditingController? sizeController;
  RxBool bothTimeDrink;
  String time;
  RxBool earlyDrink;
  RxBool lateDrink;

  LocalDrinkModel({
    required this.name,
    required this.size,
    required this.price,
    required this.discount,
    required this.dropDown,
    required this.drinkController,
    required this.dropDownSize,
    required this.sizeicon,
    required this.discounticon,
    this.discountController,
    this.sizeController,
    required this.bothTimeDrink,
    required this.time,
    required this.earlyDrink,
    required this.lateDrink,
  });
}

class Select {
  final int id;
  final String name;

  Select({
    required this.id,
    required this.name,
  });
}
