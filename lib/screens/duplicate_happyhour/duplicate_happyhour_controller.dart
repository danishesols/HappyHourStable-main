import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/screens/account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../routes/app_routes.dart';
import '../../global_controller/current_location_controller.dart';
import '../account_business/add_for_guest/guest_business_form/guest_form_screen.dart';

class DuplicateController extends GetxController {
  HappyHourModel firestoreObj = Get.arguments;
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();
  final manualAddressformKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  final businessNameController = TextEditingController();
  final businessAddressController = TextEditingController();
  final descriptionController = TextEditingController();
  final addDrinksManuallyController = TextEditingController();
  final addfoodManuallyController = TextEditingController();
  final phonenumberController = TextEditingController();
  final dailSpecialPrice = TextEditingController();

  final _showLate = false.obs;

  LocationPermissionStatus locationPermissionStatus =
      LocationPermissionStatus.nullStatus;
  bool get showLate => _showLate.value;
  set showLate(value) => _showLate.value = value;
  List earlyDrinkItems = [];
  List<LocalFoodModel> foodList = [];
  List<LocalFoodModel> foodLateList = [];
  List earlyFoodItems = [];
  List<LocalDrinkModel> localdrinkList = [];
  List<LocalDrinkModel> localLateDrinkList = [];

  final ImagePicker _picker = ImagePicker();

  final duplicateBusinessTimeformKey = GlobalKey<FormState>();
  void checkLateAndEarlyHoursAreThere() {
    if (firestoreObj.day!.isEmpty) {
      for (var element in foodList) {
        element.earlyFood.value = false;
      }
      for (var element in localdrinkList) {
        element.earlyDrink.value = false;
      }
    }
    if (firestoreObj.dayLate!.isEmpty) {
      for (var element in foodList) {
        element.lateFood.value = false;
      }
      for (var element in localdrinkList) {
        element.lateDrink.value = false;
      }
    }

    if (firestoreObj.day!.isEmpty && firestoreObj.dayLate!.isEmpty) {
      foodList = [];
      localdrinkList = [];
    }

    updateDrinkLists();
    updateFoodLists();
  }

  arguments() {
    businessNameController.text = firestoreObj.businessName.toString();
    //businessAddressController.text = firestoreObj.businessAddress.toString();
    businessAddressController.text = '';

    descriptionController.text = firestoreObj.description.toString();
    businessCard = firestoreObj.businessCard;
    businessLogo = firestoreObj.businessLogo;
    businessImage = firestoreObj.businessImage;
    happyHourMenuImage = firestoreObj.menuImage;

    for (var amen in amenitiesList) {
      if (firestoreObj.amenities!.contains(amen.amenity)) {
        amen.isSelect.value = true;
        amentyAddList.add(amen.amenity);
      }
    }
    for (var bar in barTypeList) {
      if (firestoreObj.barType!.contains(bar.amenity)) {
        bar.isSelect.value = true;
        barTypeAddList.add(bar.amenity);
      }
      //print(barTypeAddList);
    }
  }

  List menuImagePathList = [];
  List<XFile?> menuImageFiles = [];
  XFile? businessCardImage;
  XFile? businessLogoImage;
  XFile? businessImageFile;

  List<String?> menuImageList = [];

  menuAllImages() {
    menuImageList = [];
    menuImageFiles = [];
    businessCardImage = null;
    businessImageFile = null;
    businessLogoImage = null;

    if (firestoreObj.menuImage != null) {
      menuImageList.add(firestoreObj.menuImage!);
      happyHourMenuImage = firestoreObj.menuImage;
    }
    if (firestoreObj.menuImage2 != null) {
      menuImageList.add(firestoreObj.menuImage2);
      happyHourMenuImage = firestoreObj.menuImage2;
    }
  }

  List lateDaytimeList = [];

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

  @override
  void onInit() {
    // * location service
    isLoading = true;
    update();
    //if(CurrentLocationController.latitude==null || CurrentLocationController.longitude== null){
    Future.microtask(() async {
      Position? currentLoc = await getCurrentPosition();
      if (currentLoc != null) {
        latitude = currentLoc.latitude;
        longitude = currentLoc.longitude;
        update();
      }
    });
    // }else{
    //   latitude = CurrentLocationController.latitude;
    //   longitude = CurrentLocationController.longitude;
    //   update();
    // }
    arguments();
    menuAllImages();
    //business Hour Update
    businessHourUpdate();
    sundaydailySpecialType = null;
    mondaydailySpecialType = null;
    tuesdaydailySpecialType = null;
    wednesdaydailySpecialType = null;
    thursdaydailySpecialType = null;
    fridaydailySpecialType = null;
    saturdaydailySpecialType = null;
    //*=====Happy Hour Time =======*//
    happyHourTimeUpdate();
    happyHourTimeUpdateLate();
    //Food Update
    for (int i = 0; i < firestoreObj.foodName!.length; i++) {
      foodUpdate(i);
    }
    //Drink update
    for (int i = 0; i < firestoreObj.drinkitemName!.length; i++) {
      drinkUpdate(i);
    }
    checkLateAndEarlyHoursAreThere();

    //daily special update
    for (int i = 0; i < firestoreObj.dailySpecils!.length; i++) {
      dailySpecialUpdate(i);
    }

    //event update
    for (int i = 0; i < firestoreObj.event!.length; i++) {
      eventUpdate(i);
    }
    isLoading = false;
    update();
    super.onInit();
  }

  businessHourUpdate() {
    for (int i = 0; i < firestoreObj.fromTimeToTime!.length; i++) {
      for (var bh in dayFromTimeToTimeList) {
        if (firestoreObj.fromTimeToTime?[i]['bDay'].contains(bh.day)) {
          bh.isSelect.value = true;
          bh.from = firestoreObj.fromTimeToTime?[i]['bFtime'];
          bh.to = firestoreObj.fromTimeToTime?[i]['bTtime'];
          if (bh.day.toString() == "Sunday") {
            bh.key = a;
            bh.key2 = a2;
          }
          if (bh.day.toString() == "Monday") {
            bh.key = b;
            bh.key2 = b2;
          }
          if (bh.day.toString() == "Tuesday") {
            bh.key = c;
            bh.key2 = c2;
          }
          if (bh.day.toString() == "Wednesday") {
            bh.key = d;
            bh.key2 = d2;
          }
          if (bh.day.toString() == "Thursday") {
            bh.key = e;
            bh.key2 = e2;
          }
          if (bh.day.toString() == "Friday") {
            bh.key = f;
            bh.key2 = f2;
          }
          if (bh.day.toString() == "Saturday") {
            bh.key = g;
            bh.key2 = g2;
          }

          selecteddays.add({
            "bDay": bh.day,
            "bFtime": firestoreObj.fromTimeToTime?[i]['bFtime'],
            "bTtime": firestoreObj.fromTimeToTime?[i]['bTtime'],
          });
        }
      }
    }
  }

  happyHourTimeUpdate() {
    if (firestoreObj.day!.isNotEmpty) {
      for (int i = 0; i < firestoreObj.day!.length; i++) {
        for (var dt in dayTimeList) {
          if (firestoreObj.day![i]['Hday'].contains(dt.day)) {
            dt.isSelect.value = true;

            dt.fromTime = firestoreObj.day?[i]['HfromTime'];
            dt.toTime = firestoreObj.day?[i]['HtoTime'];
            // dt.fromTime2 = hour.fromTimeToTime?[i]['HfromTime2'];
            // dt.toTime2 = hour.fromTimeToTime?[i]['HtoTime2'];

            if (dt.day.toString() == "Sunday") {
              dt.keyfrom = aa;
              dt.keyto = aa2;
            }
            if (dt.day.toString() == "Monday") {
              dt.keyfrom = bb;
              dt.keyto = bb2;
            }
            if (dt.day.toString() == "Tuesday") {
              dt.keyfrom = cc;
              dt.keyto = cc2;
            }
            if (dt.day.toString() == "Wednesday") {
              dt.keyfrom = dd;
              dt.keyto = dd2;
            }
            if (dt.day.toString() == "Thursday") {
              dt.keyfrom = ee;
              dt.keyto = ee2;
            }
            if (dt.day.toString() == "Friday") {
              dt.keyfrom = ff;
              dt.keyto = ff2;
            }
            if (dt.day.toString() == "Saturday") {
              dt.keyfrom = gg;
              dt.keyto = gg2;
            }
            earlyDayTimeList.add({
              "Hday": dt.day,
              "HfromTime": firestoreObj.day?[i]['HfromTime'],
              "HtoTime": firestoreObj.day?[i]['HtoTime']
            });
          }
        }
      }
    }
  }

  happyHourTimeUpdateLate() {
    if (firestoreObj.dayLate!.isNotEmpty) {
      for (int i = 0; i < firestoreObj.dayLate!.length; i++) {
        for (var dt in dayTimeList2) {
          if (firestoreObj.dayLate![i]['Hday2'].contains(dt.day)) {
            dt.isSelect.value = true;

            dt.fromTime2 = firestoreObj.dayLate?[i]['HfromTime2'];
            dt.toTime2 = firestoreObj.dayLate?[i]['HtoTime2'];
            // dt.fromTime2 = hour.fromTimeToTime?[i]['HfromTime2'];
            // dt.toTime2 = hour.fromTimeToTime?[i]['HtoTime2'];

            if (dt.day.toString() == "Sunday") {
              dt.keyfrom2 = hh;
              dt.keyto2 = hh2;
            }
            if (dt.day.toString() == "Monday") {
              dt.keyfrom2 = ii;
              dt.keyto2 = ii2;
            }
            if (dt.day.toString() == "Tuesday") {
              dt.keyfrom2 = jj;
              dt.keyto2 = jj2;
            }
            if (dt.day.toString() == "Wednesday") {
              dt.keyfrom2 = kk;
              dt.keyto2 = kk2;
            }
            if (dt.day.toString() == "Thursday") {
              dt.keyfrom2 = ll;
              dt.keyto2 = ll2;
            }
            if (dt.day.toString() == "Friday") {
              dt.keyfrom2 = mm;
              dt.keyto2 = mm2;
            }
            if (dt.day.toString() == "Saturday") {
              dt.keyfrom2 = nn;
              dt.keyto2 = nn2;
            }
            lateDaytimeList.add({
              "Hday2": dt.day,
              "HfromTime2": firestoreObj.dayLate?[i]['HfromTime2'],
              "HtoTime2": firestoreObj.dayLate?[i]['HtoTime2']
            });
          }
        }
      }
    }
  }

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

  foodUpdate(index) {
    for (var food in foodallList) {
      if (firestoreObj.foodName?[index]['foodname'].contains(food.name)) {
        LocalFoodModel model = LocalFoodModel(
          name: food.name.toString(),
          quantity: firestoreObj.foodName?[index]['foodcount'],
          price: firestoreObj.foodName![index]['foodprice'].toString(),
          discount: firestoreObj.foodName?[index]['fooddiscount'],
          dropDown: ["%", "\$"],
          priceController: TextEditingController(
              text: firestoreObj.foodName?[index]['foodprice'] == ''
                  ? ''
                  : firestoreObj.foodName?[index]['foodprice'].toString()),
          discountController: TextEditingController(
              text: firestoreObj.foodName?[index]['fooddiscount'] == 0
                  ? ''
                  : firestoreObj.foodName?[index]['fooddiscount'].toString()),
          earlyFood: firestoreObj.foodName?[index]['early'] == true
              ? true.obs
              : false.obs,
          lateFood: firestoreObj.foodName?[index]['late'] == true
              ? true.obs
              : false.obs,
          time: foodtime,
          discountIcon: firestoreObj.foodName?[index]['discountIcon'] ?? "%",
        );
        if (model.earlyFood.value) {
          earlyFoodItems.add(model);
        }

        foodList.add(model);
        if (model.lateFood.value == true) {
          foodLateList.add(model);
        }
      }
    }
    if (firestoreObj.dayLate!.isNotEmpty) {
      showDayList = true;
      showLateDayList = true;
    }
  }

  updateFoodLists() {
    foodLateList = [];
    earlyFoodItems = [];
    for (var food in foodList) {
      LocalFoodModel model = LocalFoodModel(
        name: food.name.toString(),
        quantity: food.quantity,
        price: food.price,
        discount: food.discount,
        dropDown: ["%", "\$"],
        priceController: TextEditingController(text: food.price.toString()),
        discountController:
            TextEditingController(text: food.discount.toString()),
        earlyFood: food.earlyFood,
        //hour.foodName?[index]['early'] == true ? true.obs : false.obs,
        lateFood: food.lateFood,
        //hour.foodName?[index]['late'] == true ? true.obs : false.obs,
        time: food.time,
        //discountIcon: hour.foodName?[index]['discountIcon'] ?? "%",
        discountIcon: food.discountIcon,
      );
      if (model.earlyFood.value) {
        earlyFoodItems.add(model);
      }
      if (model.lateFood.value == true) {
        foodLateList.add(model);
      }
    }
    if (firestoreObj.dayLate!.isNotEmpty) {
      showDayList = true;
      showLateDayList = true;
    }
  }

  drinkUpdate(index) {
    for (var drink in drinkList) {
      if (firestoreObj.drinkitemName?[index]['drinkname']
          .contains(drink.name)) {
        LocalDrinkModel model = LocalDrinkModel(
          name: drink.name.toString(),
          size: firestoreObj.drinkitemName?[index]['drinksize'],
          price: firestoreObj.drinkitemName![index]['drinkprice'].toString(),
          discount: firestoreObj.drinkitemName?[index]['drinkdiscount'],
          sizeicon: firestoreObj.drinkitemName?[index]['sizeIcon'],
          discounticon: firestoreObj.drinkitemName?[index]['discountIcon'],
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
          discountController: TextEditingController(
              text: firestoreObj.drinkitemName?[index]['drinkdiscount'] == 0
                  ? ""
                  : firestoreObj.drinkitemName?[index]['drinkdiscount']
                      .toString()),
          drinkController: TextEditingController(
              text: firestoreObj.drinkitemName?[index]['drinkprice'] == ''
                  ? ''
                  : firestoreObj.drinkitemName?[index]['drinkprice']
                      .toString()),
          bothTimeDrink:
              firestoreObj.drinkitemName?[index]['secondtime'] == true
                  ? true.obs
                  : false.obs,
          time: drinktime,
          sizeController: TextEditingController(
              text: firestoreObj.drinkitemName?[index]['drinksize']),
          earlyDrink: firestoreObj.drinkitemName?[index]['early'] == true
              ? true.obs
              : false.obs,
          lateDrink: firestoreObj.drinkitemName?[index]['late'] == true
              ? true.obs
              : false.obs,
        );

        localdrinkList.add(model);
        if (model.earlyDrink.value) {
          earlyDrinkItems.add(model);
        }

        if (model.lateDrink.value == true) {
          localLateDrinkList.add(model);
        }
      }
    }
  }

  updateDrinkLists() {
    localLateDrinkList = [];
    earlyDrinkItems = [];
    for (var drink in localdrinkList) {
      LocalDrinkModel model = LocalDrinkModel(
        name: drink.name.toString(),
        size: drink.size,
        price: drink.price,
        discount: drink.discount,
        sizeicon: drink.sizeicon,
        discounticon: drink.discounticon,
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
        discountController: TextEditingController(
            text: drink.discount == 0 ? "" : drink.discount.toString()),
        drinkController:
            TextEditingController(text: drink.drinkController.toString()),
        bothTimeDrink: drink.bothTimeDrink.value == true ? true.obs : false.obs,
        time: drink.time,
        sizeController: TextEditingController(text: drink.size),
        earlyDrink: drink.earlyDrink.value == true ? true.obs : false.obs,
        lateDrink: drink.lateDrink.value == true ? true.obs : false.obs,
      );
      if (model.earlyDrink.value) {
        earlyDrinkItems.add(model);
      }
      if (model.lateDrink.value == true) {
        localLateDrinkList.add(model);
      }
    }
  }

  addtoEditdailypecial() {
    List alldailySpecial = [];
    for (var e in sundaydailySpecialItemList) {
      alldailySpecial.add({
        "name": e['name'],
        "quantity": e['quantity'],
        "price": e["price"],
        "discount": e["discount"],
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
        "sizeIcon": e["sizeIcon"],
        "day": e['day'],
        "fromTime": e["fromTime"],
        "toTime": e["toTime"],
        "index": e["index"],
      });
    }
    alldailySpecialList.addAll(alldailySpecial);
  }

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

  onBusinessAddressClick() async {
    await getCurrentPosition();
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

  Future removeItemsWithTimes() async {
    if (earlyDayTimeList.isEmpty) {
      for (var item in foodList) {
        item.earlyFood.value = false;
      }
      for (var item in localdrinkList) {
        item.earlyDrink.value = false;
      }
    }
    if (lateDaytimeList.isEmpty) {
      for (var item in foodList) {
        item.lateFood.value = false;
      }
      for (var item in localdrinkList) {
        item.lateDrink.value = false;
      }

      updateFoodLists();
      updateDrinkLists();
    }
  }

  Future uploadBusinessCard(BuildContext context) async {
    ImageSource source = ImageSource.gallery;
    await dialogueCard(
        context,
        "Add From Gallery",
        () {
          source = ImageSource.gallery;
          Get.back();
        },
        "Open Camera",
        () {
          source = ImageSource.camera;
          Get.back();
        });
    businessCardImage =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (businessCardImage != null) {
      businessCard = businessCardImage!.path;
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(value) => _isLoading.value = value;

  final ev1 = GlobalKey<FormState>();
  final ev2 = GlobalKey<FormState>();
  final ev3 = GlobalKey<FormState>();
  final ev4 = GlobalKey<FormState>();
  final ev5 = GlobalKey<FormState>();
  final ev6 = GlobalKey<FormState>();
  final ev7 = GlobalKey<FormState>();
  final ev8 = GlobalKey<FormState>();
  final ev9 = GlobalKey<FormState>();
  final ev10 = GlobalKey<FormState>();
  final ev11 = GlobalKey<FormState>();
  final ev12 = GlobalKey<FormState>();
  final ev13 = GlobalKey<FormState>();
  final ev14 = GlobalKey<FormState>();

  // forKeyAssignEvent(index) {
  //   if (eventList[index].isSelect.isFalse) {
  //     //eventList[index].key?.currentState?.reset();
  //
  //     eventList[index].fromtime = "";
  //     eventList[index].totime = "";
  //   } else {
  //     if (index == 0) {
  //       eventList[0].key = ev1;
  //     }
  //     if (index == 1) {
  //       eventList[1].key = ev2;
  //     }
  //     if (index == 2) {
  //       eventList[2].key = ev3;
  //     }
  //     if (index == 3) {
  //       eventList[3].key = ev4;
  //     }
  //     if (index == 4) {
  //       eventList[4].key = ev5;
  //     }
  //     if (index == 5) {
  //       eventList[5].key = ev6;
  //     }
  //     if (index == 6) {
  //       eventList[6].key = ev7;
  //     }
  //     if (index == 7) {
  //       eventList[7].key = ev8;
  //     }
  //     if (index == 8) {
  //       eventList[8].key = ev9;
  //     }
  //     if (index == 9) {
  //       eventList[9].key = ev10;
  //     }
  //     if (index == 10) {
  //       eventList[10].key = ev11;
  //     }
  //     if (index == 11) {
  //       eventList[11].key = ev12;
  //     }
  //     if (index == 12) {
  //       eventList[12].key = ev13;
  //     }
  //     if (index == 13) {
  //       eventList[13].key = ev14;
  //     }
  //   }
  // }

  final _isTermChecked = false.obs;
  bool get isTermChecked => _isTermChecked.value;
  set isTermChecked(value) => _isTermChecked.value = value;

  String eventtime = "01:00 PM";
  String dailySpecialtime = "01:00 PM";
  String time = "01:00 PM";

  List selecteddays = [];
  List<LateDayTime> dayTimeList = [
    LateDayTime(
      isSelect: false.obs,
      day: "Sunday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Monday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Thursday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Friday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Saturday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
  ];

  List<LateDayTime> dayTimeList2 = [
    LateDayTime(
      isSelect: false.obs,
      day: "Sunday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Monday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Thursday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Friday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
    LateDayTime(
      isSelect: false.obs,
      day: "Saturday",
      secondTime: [],
      fromTime: "",
      toTime: "",
      fromTime2: "",
      toTime2: "",
      isEarly: false.obs,
      isLate: false.obs,
      keyfrom: null,
      keyto: null,
      keyfrom2: null,
      keyto2: null,
    ),
  ];
  // void hUpdateDayLate(index) async {
  //   dayTimeList2[index].isSelect.value = !dayTimeList2[index].isSelect.value;
  //   for (var day in dayTimeList2) {
  //     if (day.isSelect.isTrue) {
  //       // hDay = day.day.toString();
  //       hDay = dayTimeList2[index].day;
  //       update();
  //     }
  //     hDayTimeLateList
  //         .removeWhere((e) => e['Hday2'] == dayTimeList2[index].day);
  //   }
  // }

  void hDayTimeLate(index, String day) {
    var a = lateDaytimeList.where((element) => element['Hday2'] == day);
    if (a.isEmpty) {
      lateDaytimeList.add({
        "Hday2": dayTimeList2[index].day,
        "HfromTime2": dayTimeList2[index].fromTime2,
        "HtoTime2": dayTimeList2[index].toTime2,
      });
    } else {
      for (var element in lateDaytimeList) {
        if (element['Hday2'] == day) {
          element["HfromTime2"] = dayTimeList2[index].fromTime2;
          element["HtoTime2"] = dayTimeList2[index].toTime2;
        }
      }
    }
  }

  final aa = GlobalKey<FormState>();
  final bb = GlobalKey<FormState>();
  final cc = GlobalKey<FormState>();
  final dd = GlobalKey<FormState>();
  final ee = GlobalKey<FormState>();
  final ff = GlobalKey<FormState>();
  final gg = GlobalKey<FormState>();
  //Daytime from Late Keys
  final hh = GlobalKey<FormState>();
  final ii = GlobalKey<FormState>();
  final jj = GlobalKey<FormState>();
  final kk = GlobalKey<FormState>();
  final ll = GlobalKey<FormState>();
  final mm = GlobalKey<FormState>();
  final nn = GlobalKey<FormState>();
//Daytime To Early Keys to
  final aa2 = GlobalKey<FormState>();
  final bb2 = GlobalKey<FormState>();
  final cc2 = GlobalKey<FormState>();
  final dd2 = GlobalKey<FormState>();
  final ee2 = GlobalKey<FormState>();
  final ff2 = GlobalKey<FormState>();
  final gg2 = GlobalKey<FormState>();
  //Daytime To Late Keys to
  final hh2 = GlobalKey<FormState>();
  final ii2 = GlobalKey<FormState>();
  final jj2 = GlobalKey<FormState>();
  final kk2 = GlobalKey<FormState>();
  final ll2 = GlobalKey<FormState>();
  final mm2 = GlobalKey<FormState>();
  final nn2 = GlobalKey<FormState>();

  String? bFromtime;
  String? bTotime;

  final a = GlobalKey<FormState>();
  final b = GlobalKey<FormState>();
  final c = GlobalKey<FormState>();
  final d = GlobalKey<FormState>();
  final e = GlobalKey<FormState>();
  final f = GlobalKey<FormState>();
  final g = GlobalKey<FormState>();
  final a2 = GlobalKey<FormState>();
  final b2 = GlobalKey<FormState>();
  final c2 = GlobalKey<FormState>();
  final d2 = GlobalKey<FormState>();
  final e2 = GlobalKey<FormState>();
  final f2 = GlobalKey<FormState>();
  final g2 = GlobalKey<FormState>();

  //*Hour days and Times *//
  String? hDay;
  String? hFromTime;
  String? hToTime;
  String? hFromTime2;
  String? hToTime2;

  List earlyDayTimeList = [];
  bool ali = true;

  void hDayTime(int index, String day) {
    !earlyDayTimeList.contains("Hday");
    var a = earlyDayTimeList.where((element) => element['Hday'] == day);
    if (a.isEmpty) {
      earlyDayTimeList.add({
        "Hday": dayTimeList[index].day,
        "HfromTime": dayTimeList[index].fromTime,
        "HtoTime": dayTimeList[index].toTime,
      });
    } else {
      for (var element in earlyDayTimeList) {
        if (element['Hday'] == day) {
          element["HfromTime"] = dayTimeList[index].fromTime;
          element["HtoTime"] = dayTimeList[index].toTime;
        }
      }
    }
  }

  final _showDaysList = false.obs;
  bool get showDayList => _showDaysList.value;
  set showDayList(value) => _showDaysList.value = value;

  final _showLateDaysList = false.obs;
  bool get showLateDayList => _showLateDaysList.value;
  set showLateDayList(value) => _showLateDaysList.value = value;

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

  //*Drink Item Section*//

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
  List alldailySpecialList = [];

  List sundaydailySpecialItemList = [];
  List mondaydailySpecialItemList = [];
  List tuesdaydailySpecialItemList = [];
  List wednesdaydailySpecialItemList = [];
  List thursdaydailySpecialItemList = [];
  List fridaydailySpecialItemList = [];
  List saturdaydailySpecialItemList = [];

  void dailySpecialTap() {
    var index = daysList.where((e) => e.isSelect.isTrue).length;

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
      // Get.toNamed(Routes.businessAmenitiesScreen);
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
          isMonday &&
          isTuesday &&
          isWednesday &&
          isThursday &&
          isFriday &&
          isSaturday) {
        //Get.toNamed(Routes.businessAmenitiesScreen);
      }

      addToDailyySpecial();
    }
  }

  //*BarType List Section *//

  String? eventname = "";

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

  void onHourScreenNextTap() {
    var index = dayFromTimeToTimeList.where((e) => e.isSelect.isTrue).length;

    if (index == 0) {
      Get.toNamed(Routes.businessDayTimeScreen);
    }
    if (!hourBformKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Select Time", description: "Please Select all the Time");
    }
    if (hourBformKey.currentState!.validate()) {
      if (dayFromTimeToTimeList[0].isSelect.isTrue &&
          bFromtime != null &&
          bTotime != null) {
        Get.toNamed(Routes.businessDayTimeScreen);
      }
    }
  }

  final businessKey = GlobalKey<FormState>();
  final businessHourKey = GlobalKey<FormState>();

  void onDayTimeNextTap() {
    var index = dayTimeList.where((e) => e.isSelect.isTrue).length;
    if (index == 0) {
      Get.toNamed(Routes.businessFoodItemScreen);
    }
    if (!businessKey.currentState!.validate()) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Select Time", description: "Please Select all the Time");
    }
    if (businessKey.currentState?.validate() ?? false) {
      if (dayTimeList[0].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[0].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[1].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[1].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[2].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[2].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[3].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[3].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[4].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[4].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[5].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[5].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.businessFoodItemScreen);
        }
      } else if (dayTimeList[6].isSelect.value &&
          hFromTime != null &&
          hToTime != null) {
        if (dayTimeList[6].secondTime?.isNotEmpty ?? false) {
          if (hFromTime2 != null && hToTime2 != null) {
            Get.toNamed(Routes.businessFoodItemScreen);
          }
        } else {
          Get.toNamed(Routes.addHappyHourFoodItemScreen);
        }
      }
    }
  }

  void onBusinessnextTap() {
    if (formKey.currentState!.validate()) {
      if (businessCard == "" ||
          businessImage == "" ||
          businessLogo == "" ||
          happyHourMenuImage == "") {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Image",
            description: "Make sure you have picked all The images");
      } else if (formKey.currentState!.validate() &&
          businessCard != "" &&
          businessImage != "" &&
          businessLogo != "" &&
          happyHourMenuImage != "") {
        Get.toNamed(Routes.businessDescriptionScreen);
      }
    }
  }

  final geo = Geoflutterfire();

  Future<void> duplicateHappyHour() async {
    // GeoFirePoint _position = geo.point(
    //     latitude: _lat == 0.0 ? firestoreObj.latitude! : _lat,
    //     longitude: _long == 0.0 ? firestoreObj.longitude! : _long);
    // isLoading = true;
    // await _addHappyHourProvider.uploadToFirebaseStorage(
    //   businessName: businessNameController.text,
    //   businessAddress: businessAddressController.text,
    //   description: descriptionController.text,
    //   phoneNumber: phonenumberController.text,
    //   businessCard: businessCard.contains("image_picker")
    //       ? await _addHappyHourProvider
    //           .uploadBusinessCardImageToFirebaseStorage(
    //               businessCard: businessCard)
    //       : businessCard,
    //   businessLogo: businessLogo.contains("image_picker")
    //       ? await _addHappyHourProvider.uploadBusinessLogoToFirebaseStorage(
    //           businessLogo: businessLogo)
    //       : businessLogo,
    //   businessImage: businessImage.contains("image_picker")
    //       ? await _addHappyHourProvider.uploadBusinessImageToFirebaseStorage(
    //           businessImage: businessImage)
    //       : businessImage,
    //   menuImage: happyHourMenuImage.contains("image_picker")
    //       ? await _addHappyHourProvider
    //           .uploadBusinessMenuImageImageToFirebaseStorage(
    //               menuImage: happyHourMenuImage)
    //       : happyHourMenuImage,
    //   dayTime: earlyDayTimeList,
    //   daytimeLate: lateDaytimeList,
    //   fromTimeToTime: selecteddays,
    //   dailySpecial: alldailySpecialList,
    //   foodNames: foodList
    //       .map((e) => {
    //             "foodname": e.name,
    //             "foodcount": e.quantity,
    //             "fooddiscount": e.discount,
    //             "discountIcon": e.discountIcon,
    //             "foodprice": e.price,
    //             "secondtime": e.time,
    //             "early": e.earlyFood.value,
    //             "late": e.lateFood.value,
    //           })
    //       .toList(),
    //   drinkitemNames: localdrinkList
    //       .map((e) => {
    //             "drinkname": e.name,
    //             "drinksize": e.size,
    //             "drinkprice": e.price,
    //             "drinkdiscount": e.discount,
    //             "sizeIcon": e.sizeicon,
    //             "discountIcon": e.discounticon,
    //             "secondtime": e.time,
    //             "early": e.earlyDrink.value,
    //             "late": e.lateDrink.value,
    //           })
    //       .toList(),
    //   amenities: amentyAddList,
    //   barType: barTypeAddList,
    //   event: selectedEvent,
    //   id: Get.find<AuthController>().user.uid,
    //   position: _position,
    //   latLong: {
    //     "latitude": _lat == 0.0 ? firestoreObj.latitude : _lat,
    //     "longitude": _long == 0.0 ? firestoreObj.longitude : _long,
    //   },
    // );

    isLoading = true;
    update();

    ///----------------
    removeDuplicationFromSelectedEvents();
    localdrinkList = removeUnselectedDrinkItems();
    foodList = removeUnselectedFoodItems();

    ///----------

    GeoFirePoint _position = geo.point(
        latitude: _lat == 0.0 ? firestoreObj.latitude! : _lat,
        longitude: _long == 0.0 ? firestoreObj.longitude! : _long);

    await _addHappyHourProvider.uploadToFirebaseStorage(
      accountType: 'business',
      businessName: businessNameController.text.isEmpty
          ? firestoreObj.businessName
          : businessNameController.text,
      businessAddress: businessAddressController.text.isEmpty
          ? firestoreObj.businessAddress
          : businessAddressController.text,
      description: descriptionController.text.isEmpty
          ? firestoreObj.description
          : descriptionController.text,
      phoneNumber: phonenumberController.text.isEmpty
          ? firestoreObj.phoneNumber
          : phonenumberController.text,
      businessCard: businessCardImage != null
          ? await _addHappyHourProvider
              .uploadBusinessCardImageToFirebaseStorage(
                  businessCard: businessCard)
          : businessCard,
      businessLogo: businessLogoImage != null
          ? await _addHappyHourProvider.uploadBusinessLogoToFirebaseStorage(
              businessLogo: businessLogo)
          : businessLogo,
      businessImage: businessImageFile != null
          ? await _addHappyHourProvider.uploadBusinessImageToFirebaseStorage(
              businessImage: businessImage)
          : businessImage,
      menuImage: menuImageList.isNotEmpty && menuImageFiles.isNotEmpty
          ? await _addHappyHourProvider
              .uploadBusinessMenuImageImageToFirebaseStorage(
                  menuImage: menuImageFiles.first!.path)
          : firestoreObj.menuImage,
      menuImage2: menuImageList.isNotEmpty && menuImageFiles.isNotEmpty
          ? await _addHappyHourProvider
              .uploadBusinessMenuImageImageToFirebaseStorage(
                  menuImage: menuImageFiles.last!.path)
          : firestoreObj.menuImage2,
      //todo:look back
      // dayTime: hDayTimeList,
      // daytimeLate: hDayTimeLateList,
      dayTime: earlyDayTimeList,
      daytimeLate: lateDaytimeList,
      fromTimeToTime: selecteddays,
      dailySpecial: alldailySpecialList,
      foodNames: foodList
          .map((e) => {
                "foodname": e.name,
                "foodcount": e.quantity,
                "fooddiscount": e.discount,
                "discountIcon": e.discountIcon,
                "foodprice": e.price,
                "secondtime": e.time,
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
                "secondtime": e.time,
                "early": e.earlyDrink.value,
                "late": e.lateDrink.value,
              })
          .toList(),
      amenities: amentyAddList,
      barType: barTypeAddList,
      event: selectedEvent,
      id: Get.find<AuthController>().user.uid,
      position: _position,
      latLong: {
        "latitude": _lat == 0.0 ? firestoreObj.latitude : _lat,
        "longitude": _long == 0.0 ? firestoreObj.longitude : _long,
      },
    );
    isLoading = false;
    update();
    await Get.offAllNamed(Routes.duplicatePackagesScreen);

    // Get.back();
  }

  // 37.7919185
  // -122.4130261
  //}
  /// DA de pa bara ma za
  String firestoreDocId = '';

  void addToHday(int i) {
    earlyDayTimeList.add({
      "Hday": dayTimeList[i].day,
      "HfromTime": hFromTime,
      "HtoTime": hToTime,
    });
  }

  void addToHdaySecond(int i) {
    lateDaytimeList.add({
      "Hday2": dayTimeList[i].day,
      "HfromTime2": hFromTime2,
      "HtoTime2": hToTime2,
    });
  }

  void hUpdateDaySecond(index) async {
    dayTimeList[index].isLate.isTrue
        ? bDay = dayTimeList[index].day.toString()
        : lateDaytimeList
            .removeWhere((e) => e['Hday'] == dayTimeList[index].day);
  }

  void hDayTimeSecond(index) {
    var a = lateDaytimeList
        .where((e) => e['Hday'].toString() == dayTimeList[index].day)
        .toList();

    if (a.isEmpty) {
      lateDaytimeList.add({
        "Hday2": dayTimeList[index].day,
        "HfromTime2": dayTimeList[index].fromTime2,
        "HtoTime2": dayTimeList[index].toTime2
      });
    }
  }

  editDataGet() {
    businessNameController.text = firestoreObj.businessName.toString();
    businessAddressController.text = firestoreObj.businessAddress.toString();
    descriptionController.text = firestoreObj.description.toString();

    firestoreObj.businessCard != null
        ? businessCard = firestoreObj.businessCard
        : businessCard = "";

    firestoreObj.businessLogo != null
        ? businessLogo = firestoreObj.businessLogo
        : businessLogo = "";
    firestoreObj.businessImage != null
        ? businessImage = firestoreObj.businessImage
        : businessImage = "";
    happyHourMenuImage = firestoreObj.menuImage;
    for (var amen in amenitiesList) {
      if (firestoreObj.amenities!.contains(amen.amenity)) {
        amen.isSelect.value = true;
        amentyAddList.add(amen.amenity);
      }
    }
    for (var bar in barTypeList) {
      if (firestoreObj.barType!.contains(bar.amenity)) {
        bar.isSelect.value = true;
        barTypeAddList.add(bar.amenity.toString());
      }
      //print(barTypeAddList);
    }
  }

//======dailyspecial Update
  dailySpecialUpdate(index) {
    alldailySpecialList.clear();
    for (var ds in daysList) {
      if (firestoreObj.dailySpecils?[index]['day'].contains(ds.day)) {
        ds.isSelect.value = true;

        if (firestoreObj.dailySpecils?[index]['day'] == "Sunday") {
          sundaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity": firestoreObj.dailySpecils?[index]['quantity'],
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "sizeIcon": firestoreObj.dailySpecils?[index]["sizeIcon"],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in sundaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Monday") {
          mondaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in mondaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Tuesday") {
          tuesdaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in tuesdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Wednesday") {
          wednesdaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in wednesdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Thursday") {
          thursdaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in thursdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Friday") {
          fridaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in fridaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (firestoreObj.dailySpecils?[index]['day'] == "Saturday") {
          saturdaydailySpecialItemList.add({
            "name": firestoreObj.dailySpecils?[index]['name'],
            "quantity":
                firestoreObj.dailySpecils?[index]['quantity'].toString(),
            "price": firestoreObj.dailySpecils?[index]['price'],
            "discount": firestoreObj.dailySpecils?[index]['discount'],
            "discountIcon": firestoreObj.dailySpecils?[index]['discountIcon'],
            "sizeIcon": "oz",
            "day": firestoreObj.dailySpecils?[index]['day'],
            "fromTime": firestoreObj.dailySpecils?[index]['fromTime'],
            "toTime": firestoreObj.dailySpecils?[index]['toTime'],
            "index": firestoreObj.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller": TextEditingController(
                text: firestoreObj.dailySpecils?[index]['price']),
          });
          for (var e in saturdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
      }
    }
  }

//*=========event Update ====//
  eventUpdate(index) {
    for (int i = 0; i < eventList.length; i++) {
      if (firestoreObj.event?[index]['name'].toLowerCase() ==
          eventList[i].event.toLowerCase()) {
        eventList[i].isSelect.value = true;

        selectedEvent.add({
          "name": firestoreObj.event?[index]['name'],
          "day": firestoreObj.event?[index]['day'],
          "fromtime": firestoreObj.event?[index]['fromtime'],
          "totime": firestoreObj.event?[index]['totime'],
        });
      }
    }
    update();
  }

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

  Future uploadBusinessLogo(BuildContext context) async {
    ImageSource source = ImageSource.gallery;
    await dialogueCard(
        context,
        "Add From Gallery",
        () {
          source = ImageSource.gallery;
          Get.back();
        },
        "Open Camera",
        () {
          source = ImageSource.camera;
          Get.back();
        });
    businessLogoImage =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (businessLogoImage != null) {
      businessLogo = businessLogoImage!.path;
    }
  }

  Future uploadBusinessImage(BuildContext context) async {
    ImageSource source = ImageSource.gallery;
    await dialogueCard(
        context,
        "Add From Gallery",
        () {
          source = ImageSource.gallery;
          Get.back();
        },
        "Open Camera",
        () {
          source = ImageSource.camera;
          Get.back();
        });
    businessImageFile =
        await _picker.pickImage(source: source, imageQuality: 85);
    if (businessImageFile != null) {
      businessImage = businessImageFile!.path;
    }
  }

  Future uploadHappyHourMenuImage() async {
    menuImageFiles = (await _picker.pickMultiImage(imageQuality: 85))!;
    if (menuImageFiles.isNotEmpty) {
      if (menuImageFiles.length <= 2) {
        menuImageList = [];

        happyHourMenuImage = '';
        for (var image in menuImageFiles) {
          happyHourMenuImage = menuImageFiles[0]!.path;
          menuImageList.add(image!.path);
        }
      } else {
        Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Range overflow",
            description: "Can't pick more than two images");
      }
    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "No Image Picked", description: "Pick Atleast 1 image");
    }
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

  onCheckboxChange(bool? value) {
    isTermChecked = !isTermChecked;
  }

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
    "01:00 AM ",
    "01:30 AM ",
    "02:00 AM ",
    "Select Time",
  ];

  String day = "Sunday";
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
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Monday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Thursday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Friday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Saturday",
      from: "",
      to: "",
      key: null,
      key2: null,
    ),
  ];

  forKeyAssignDayTime(index) {
    if (dayTimeList[index].isSelect.isFalse) {
      dayTimeList[index].keyfrom?.currentState?.reset();
      dayTimeList[index].keyto?.currentState?.reset();
      dayTimeList[index].fromTime = "";
      dayTimeList[index].toTime = "";
    } else {
      if (index == 0) {
        dayTimeList[0].keyfrom = aa;
        dayTimeList[0].keyto = aa2;
      }
      if (index == 1) {
        dayTimeList[1].keyfrom = bb;
        dayTimeList[1].keyto = bb2;
      }
      if (index == 2) {
        dayTimeList[2].keyfrom = cc;
        dayTimeList[2].keyto = cc2;
      }
      if (index == 3) {
        dayTimeList[3].keyfrom = dd;
        dayTimeList[3].keyto = dd2;
      }
      if (index == 4) {
        dayTimeList[4].keyfrom = ee;
        dayTimeList[4].keyto = ee2;
      }
      if (index == 5) {
        dayTimeList[5].keyfrom = ff;
        dayTimeList[5].keyto = ff2;
      }
      if (index == 6) {
        dayTimeList[6].keyfrom = gg;
        dayTimeList[6].keyto = gg2;
      }
    }
  }

//*Business Hour and Days *//
  final hourBformKey = GlobalKey<FormState>();
  String? bDay;

  void bUpdateDay(index) async {
    businessHourKey.currentState!.reset();
    dayFromTimeToTimeList[index].isSelect.value =
        !dayFromTimeToTimeList[index].isSelect.value;
    for (var days in dayFromTimeToTimeList) {
      if (days.isSelect.isTrue) {
        bDay = days.day;

        update();
      }
    }
    selecteddays
        .removeWhere((e) => e['bDay'] == dayFromTimeToTimeList[index].day);
  }

  void bDayTime(index) {
    bool isExist = false;
    for (var element in selecteddays) {
      if (element['bDay'] == dayFromTimeToTimeList[index].day) {
        isExist = true;
      }
    }
    if (!isExist) {
      selecteddays.add({
        "bDay": dayFromTimeToTimeList[index].day,
        "bFtime": dayFromTimeToTimeList[index].from,
        "bTtime": dayFromTimeToTimeList[index].to,
      });
    } else {
      for (var element in selecteddays) {
        if (element['bDay'] == dayFromTimeToTimeList[index].day) {
          element["bFtime"] = dayFromTimeToTimeList[index].from;
          element["bTtime"] = dayFromTimeToTimeList[index].to;
        }
      }
    }
  }

  void hUpdateDay(index) async {
    businessKey.currentState!.reset();
    dayTimeList[index].isSelect.value = !dayTimeList[index].isSelect.value;

    for (var day in dayTimeList) {
      if (day.isSelect.isTrue) {
        hDay = day.day;

        var addingNewHappyHourFound =
            firestoreObj.day!.where((element) => element['Hday'] == hDay);

        if (addingNewHappyHourFound.isEmpty) {
          var model = {
            "Hday": hDay,
            "HfromTime": dayTimeList[index].fromTime,
            "HtoTime": dayTimeList[index].toTime,
          };
          earlyDayTimeList.add(model);
          firestoreObj.day?.add(model);
        }
      } else {
        earlyDayTimeList.removeWhere((e) => e['Hday'] == day.day);
        dayTimeList[index].fromTime = '';
        dayTimeList[index].toTime = '';
        firestoreObj.day?.removeWhere((element) => element['Hday'] == day.day);
      }
    }
    update();
  }

  void hUpdateDayLate(index) async {
    businessKey.currentState!.reset();
    dayTimeList2[index].isSelect.value = !dayTimeList2[index].isSelect.value;

    for (var day in dayTimeList2) {
      if (day.isSelect.isTrue) {
        // hDay = day.day.toString();
        hDay = day.day;
        var addingNewHappyHourFound =
            firestoreObj.dayLate!.where((element) => element['Hday2'] == hDay);

        if (addingNewHappyHourFound.isEmpty) {
          var model = {
            "Hday2": hDay,
            "HfromTime2": dayTimeList2[index].fromTime2,
            "HtoTime2": dayTimeList2[index].toTime2,
          };
          lateDaytimeList.add(model);
          firestoreObj.dayLate?.add(model);
        }
        update();
      } else {
        lateDaytimeList.removeWhere((e) => e['Hday2'] == day.day);
        dayTimeList2[index].fromTime2 = '';
        dayTimeList2[index].toTime2 = '';
        firestoreObj.dayLate
            ?.removeWhere((element) => element['Hday2'] == day.day);
      }
    }
    update();
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
  //   Select(id: 12, name: "Quesadilla"),
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
  //   Select(id: 28, name: " Chicken-Other"),
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
  // ];.

  void addfoodmanually() {
    LocalFoodModel model = LocalFoodModel(
      name: addfoodManuallyController.text.toString(),
      quantity: 0,
      price: "",
      discount: 0,
      dropDown: ["%", "\$"],
      priceController: TextEditingController(),
      earlyFood: false.obs,
      lateFood: false.obs,
      time: foodtime,
      discountIcon: '%',
    );

    foodList.add(model);
    foodLateList.add(model);

    update();
  }

  void addFoodFromDropDownList(List foods) {
    for (var e in foods) {
      var a = foodList.where((element) => element.name == e.name);
      if (a.isEmpty) {
        LocalFoodModel model = LocalFoodModel(
          name: e.name.toString(),
          quantity: 0,
          price: "",
          discount: 0,
          dropDown: ["%", "\$"],
          priceController: TextEditingController(),
          earlyFood: false.obs,
          lateFood: false.obs,
          time: foodtime,
          discountIcon: '%',
        );
        foodList.add(model);
        foodLateList.add(model);
        update();
      }
    }
    Get.back();
  }

  void foodincrement(int index) {
    foodList[index].quantity++;
    updateFoodLists();
    update();
  }

  void fooddecrement(int index) {
    if (foodList[index].quantity > 0) {
      foodList[index].quantity--;
    } else {
      foodList[index].quantity;
    }
    updateFoodLists();
    update();
  }

  void removeFood(index) {
    foodList.removeAt(index);
    updateFoodLists();
    update();
  }

  String foodtime = "Both Time";
  // foodBothTime(index) {
  //   foodList[index].time = foodtime;
  //   update();
  // }
  //
  // foodfirstTime(index) {
  //   foodList[index].time = hFromTime.toString();
  //   update();
  // }
  //
  // foodSecondTime(index) {
  //   foodList[index].time = hFromTime2.toString();
  //   update();
  // }

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

  showBothTimeDrink(index) {
    localdrinkList[index].bothTimeDrink.value =
        !localdrinkList[index].bothTimeDrink.value;
  }

  void addDrinksmanually() {
    LocalDrinkModel model = LocalDrinkModel(
      name: addDrinksManuallyController.text.toString(),
      size: "",
      price: '',
      discount: 0,
      sizeicon: "oz",
      discounticon: "%",
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
      earlyDrink: false.obs,
      lateDrink: false.obs,
    );

    localLateDrinkList.add(model);
    localdrinkList.add(model);

    update();
  }

  void addDrinkFromDropDownList(List drinks) {
    for (var e in drinks) {
      LocalDrinkModel model = LocalDrinkModel(
        name: e.name.toString(),
        size: "",
        price: '',
        discount: 0,
        sizeicon: "oz",
        discounticon: "%",
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
        // discountController: TextEditingController(),
        // sizeController: TextEditingController(),
        bothTimeDrink: false.obs,
        time: drinktime,
        earlyDrink: false.obs,
        lateDrink: false.obs,
      );
      localdrinkList.add(model);
      localLateDrinkList.add(model);
      update();
    }
    Get.back();
  }

  void removeDrink(index) {
    localdrinkList.removeAt(index);
    updateDrinkLists();
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

  void updatesunday(daily) {
    sundaydailySpecialType = daily!;
    update();
  }

  addToDailyySpecial() {
    alldailySpecialList.clear();
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
        "discount": e["discount"],
        "discountIcon": e["discountIcon"],
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

  sundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": dailSpecialName,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    sundaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    mondaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallysundayAddTodailySpecialItemList() {
    sundaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsunDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": sundaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallymondayAddTodailySpecialItemList() {
    mondaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialmonDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": mondaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallytuesdayAddTodailySpecialItemList() {
    tuesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallywednesdayAddTodailySpecialItemList() {
    wednesdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
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
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallyfridayAddTodailySpecialItemList() {
    fridaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  addManuallysaturdayAddTodailySpecialItemList() {
    saturdaydailySpecialItemList.add({
      "name": adddailySpecialManuallyController.text,
      "quantity": dailySpecialQuantity,
      "price": "",
      "discount": "",
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
    update();
  }

  void mondaydailySpecialincrement(x) {
    mondaydailySpecialItemList[x]["quantity"]++;
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
      "sizeIcon": "oz",
      "day": dailyspecialtuesDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": tuesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    tuesdaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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
      "sizeIcon": "oz",
      "day": dailyspecialwedDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": wednesdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    wednesdaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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
      "sizeIcon": "oz",
      "day": dailyspecialthursDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": thursdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    thursdaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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
      "sizeIcon": "oz",
      "day": dailyspecialfriDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": fridaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    fridaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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
      "sizeIcon": "oz",
      "day": dailyspecialsaturDay,
      "fromTime": dailySpecialfromtime,
      "toTime": dailySpecialtotime,
      "index": saturdaydailySpecialType,
      "controller": TextEditingController(),
      "pricecontroller": TextEditingController(),
    });
    saturdaydailySpecialType = null;
    dailySpecialfromtime = timesList.last;
    dailySpecialtotime = timesList.last;
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

  void dailySpecialDoneTap() {
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

      //updateBusinessHourToFireStore();
      update();
      Get.back();
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
        //updateBusinessHourToFireStore();
        update();
        Get.back();
      } else {
        Get.find<GlobalGeneralController>()
            .errorSnackbar(title: "Error", description: "Add Items values");
      }
    }
    update();
  }

  void onBartypeDoneTap() {
    // barTypeAddList.add(barType);
    var index = barTypeList.where((e) => e.isSelect.isTrue);
    int a = index.length;
    if (a == 0) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Select atleast one Bar Type");
    }
    if (a > 3) {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Error", description: "Select only Three Bar Type");
    }
    if (a <= 3 && a > 0) {
      updateBusinessHourToFireStore();
      update();
      Get.back();
    }
    update();
  }

  void onEventDoneTap() async {
    if (eventKey.currentState!.validate() == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Select Day and Times");
    }
    if (eventKey.currentState?.validate() ?? false) {
      update();
      Get.back();
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

  void updateAmenity(index) async {
    amenitiesList[index].isSelect.value = !amenitiesList[index].isSelect.value;
    for (var e in amenitiesList) {
      if (e.isSelect.isTrue) {
        amenity = amenitiesList[index].amenity;
      }
    }

    if (amenitiesList[index].isSelect.isFalse &&
        amentyAddList.contains(amenity)) {
      amentyAddList.remove(amenity);
    } else {
      amentyAddList.add(amenity);
    }
  }

  //  if (amenitiesList[index].isSelect.isFalse) {
  //     amentyAddList.removeWhere((em) => em == amenity);
  //   }

  //   print(amenitiesList[index].amenity);

  //*BarType List Section *//
  String barType = '';
  List<String> barTypeAddList = [];
  List<Amenities> barTypeList = [
    Amenities(isSelect: false.obs, amenity: "Restaurant"),
    Amenities(isSelect: false.obs, amenity: "Restaurant with Bar"),
    Amenities(isSelect: false.obs, amenity: "Bar-Only"),
    Amenities(isSelect: false.obs, amenity: "Bar with Food"),
    Amenities(isSelect: false.obs, amenity: "Sports Bar"),
    Amenities(isSelect: false.obs, amenity: "Brewery"),
    Amenities(isSelect: false.obs, amenity: "Owner Owned"),
    Amenities(isSelect: false.obs, amenity: "Corporate Owned"),
    Amenities(isSelect: false.obs, amenity: "Dive"),
    Amenities(isSelect: false.obs, amenity: "Upscale"),
    Amenities(isSelect: false.obs, amenity: "Ulta High-End"),
    Amenities(isSelect: false.obs, amenity: "Winery"),
    Amenities(isSelect: false.obs, amenity: "Distillery"),
    Amenities(isSelect: false.obs, amenity: "Pool Hall"),
    Amenities(isSelect: false.obs, amenity: "Bowling Alley"),
    Amenities(isSelect: false.obs, amenity: "Casino"),
    Amenities(isSelect: false.obs, amenity: "Club"),
    Amenities(isSelect: false.obs, amenity: "Strip Club"),
    Amenities(isSelect: false.obs, amenity: "Roof Top"),
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
    barTypeList[index].isSelect.value = !barTypeList[index].isSelect.value;
    for (var e in barTypeList) {
      if (e.isSelect.isTrue) {
        barType = barTypeList[index].amenity;
      }
    }
    if (barTypeList[index].isSelect.isFalse &&
        barTypeAddList.contains(barType)) {
      barTypeAddList.remove(barType);
    } else {
      barTypeAddList.add(barType);
    }
  }

  //*Event Section*//
  final eventKey = GlobalKey<FormState>();
  String eventStarttime = "";
  String eventendtime = "";

  Future assignStartEventInEdit() async {
    if (kDebugMode) {
      print("c");
    }
    selectedEvent = [];

    firestoreObj.event?.forEach(
      (newEvent) {
        if (kDebugMode) {
          print(newEvent);
        }
        for (var localEvent in eventList) {
          if (newEvent['name'] == localEvent.event) {
            localEvent.day = newEvent['day'];
            localEvent.fromtime = newEvent['fromtime'];
            localEvent.totime = newEvent['totime'];
            selectedEvent.add({
              'name': localEvent.event,
              'day': localEvent.day,
              'fromtime': localEvent.fromtime,
              'totime': localEvent.totime,
            });
          }
        }
      },
    );
    Get.toNamed(Routes.duplicateEventsScreen, arguments: firestoreObj);

    // update();
  }

  ///======================================================================
  addIntoList(String name, int index) {
    eventKey.currentState!.reset();
    var a = firestoreObj.event!.where((element) => element['name'] == name);

    if (a.isEmpty) {
      selectedEvent = [];
      if (kDebugMode) {
        print('day : $day');
      }
      var model = {"name": name, "day": '', "fromtime": '', "totime": ''};
      firestoreObj.event!.add(model);

      for (int b = 0; b < firestoreObj.event!.length; b++) {
        for (int i = 0; i < eventList.length; i++) {
          if (firestoreObj.event![b]['name'].toLowerCase() ==
              eventList[i].event.toLowerCase()) {
            eventList[i].day = firestoreObj.event![b]['day'];

            eventList[i].totime = firestoreObj.event![b]['totime'];

            eventList[i].fromtime = firestoreObj.event![b]['fromtime'];

            eventList[i].isSelect.value = true;

            selectedEvent.add({
              "name": firestoreObj.event![b]['name'],
              "day": firestoreObj.event![b]['day'],
              "fromtime": firestoreObj.event![b]['fromtime'],
              "totime": firestoreObj.event![b]['totime'],
            });
          }
        }
      }
      update();
    } else {
      selectedEvent = [];

      firestoreObj.event!.removeWhere((element) {
        return element['name'] == name;
      });

      for (int b = 0; b < firestoreObj.event!.length; b++) {
        for (int i = 0; i < eventList.length; i++) {
          if (firestoreObj.event![b]['name'].toLowerCase() ==
              eventList[i].event.toLowerCase()) {
            eventList[i].day = firestoreObj.event![b]['day'];

            eventList[i].totime = firestoreObj.event![b]['totime'];

            eventList[i].fromtime = firestoreObj.event![b]['fromtime'];

            eventList[i].isSelect.value = true;

            selectedEvent.add({
              "name": firestoreObj.event![b]['name'],
              "day": firestoreObj.event![b]['day'],
              "fromtime": firestoreObj.event![b]['fromtime'],
              "totime": firestoreObj.event![b]['totime'],
            });
          }
        }
      }
      update();
    }
  }

  // addIntoList(String name) {
  //   var a = selectedEvent.where((element) => element['name'] == name);
  //   if (a.isEmpty) {
  //     selectedEvent.add({
  //       "name": name,
  //       "day": day,
  //       "fromtime": eventStarttime,
  //       "totime": eventendtime
  //     });
  //   } else {
  //     selectedEvent.removeWhere((element) {
  //       int index = eventList.indexWhere((element) => element.event == name);
  //       if (eventList[index].isSelect.value == false) {
  //         eventList[index].fromtime = '';
  //         eventList[index].totime = '';
  //         eventList[index].day = '';
  //       }
  //
  //       return element['name'] == name;
  //     });
  //   }
  // }
  ///========================================================================
  List selectedEvent = [];
  List<Event> eventList = [
    Event(
      isSelect: false.obs,
      event: "Pool Tournament",
      day: "",
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

  assignDayValue(String d, name) {
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["day"] = d;
        day = d;
      }
    }
    for (var element in firestoreObj.event!) {
      if (element['name'] == name) {
        element["day"] = d;
      }
    }
    print('day: $day');
    update();
  }

  assignFromTimeValue(String startTime, name) {
    print('startTime: $startTime');
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["fromtime"] = startTime;
      }
    }
    for (var element in firestoreObj.event!) {
      if (element['name'] == name) {
        element["fromtime"] = startTime;
      }
    }
    print(firestoreObj.event!
        .firstWhere((element) => element['name'] == name)['fromtime']);
    update();
  }

  assignToTimeValue(String endtime, name) {
    print('endtime: $endtime');
    for (var element in selectedEvent) {
      if (element['name'] == name) {
        element["totime"] = endtime;
      }
    }
    for (var element in firestoreObj.event!) {
      if (element['name'] == name) {
        element["totime"] = endtime;
      }
    }
    update();
  }

  eventListadded() {
    selectedEvent.add({
      "name": eventname!,
      "day": day,
      "fromtime": eventStarttime,
      "totime": eventendtime
    });
    update();
  }

  void updateEvent() async {
    for (var event in eventList) {
      if (event.isSelect.value == true) {
        eventname = event.event;
        update();
      }
    }
  }

  void onHourScreenDoneTap() {
    if (businessHourKey.currentState!.validate()) {
      update();
      Get.back();
    } else {
      Get.find<GlobalGeneralController>().errorSnackbar(
          title: "Select Time", description: "Please Select all the Time");
    }
  }

  void onDescriptionNextTap() {
    updateBusinessHourToFireStore();
    Get.toNamed(Routes.addBusinessHourScreen);
    // if (descriptionController.text == "") {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: "Error", description: "Please Write The Description");
    // } else if (descriptionController.text != "") {
    //   Get.toNamed(Routes.addBusinessHourScreen);
    // }
  }

  removeDuplicationFromSelectedEvents() {
    Set eventsName = {};
    Set firestoreEvents = {};
    for (var event in selectedEvent) {
      eventsName.add(event['name']);
    }
    if (kDebugMode) {
      print('eventsName.length: ${eventsName.length}');
    }
    List eventsList = eventsName.toList();
    for (int i = 0; i < eventsList.length; i++) {
      var event = selectedEvent
          .firstWhere((element) => element['name'] == eventsList[i]);
      firestoreEvents.add(event);
    }

    selectedEvent = [];
    selectedEvent = firestoreEvents.toList();
  }

  removeUnselectedDrinkItems() {
    List<LocalDrinkModel> items = [];
    for (var drink in localdrinkList) {
      if (drink.earlyDrink.value == false && drink.lateDrink.value == false) {
        continue;
      } else {
        items.add(drink);
      }
    }
    return items;
  }

  removeUnselectedFoodItems() {
    List<LocalFoodModel> items = [];
    for (var food in foodList) {
      if (food.earlyFood.value == false && food.lateFood.value == false) {
        continue;
      } else {
        items.add(food);
      }
    }
    return items;
  }

  Future<void> updateBusinessHourToFireStore() async {
    isLoading = true;
    update();

    ///----------------
    removeDuplicationFromSelectedEvents();
    localdrinkList = removeUnselectedDrinkItems();
    foodList = removeUnselectedFoodItems();

    ///----------

    GeoFirePoint _position = geo.point(
        latitude: _lat == 0.0 ? firestoreObj.latitude! : _lat,
        longitude: _long == 0.0 ? firestoreObj.longitude! : _long);

    Map<String, dynamic> data =
        await _addHappyHourProvider.updateHourInFirebase(
      docId: firestoreDocId,
      businessName: businessNameController.text.isEmpty
          ? firestoreObj.businessName
          : businessNameController.text,
      businessAddress: businessAddressController.text.isEmpty
          ? firestoreObj.businessAddress
          : businessAddressController.text,
      description: descriptionController.text.isEmpty
          ? firestoreObj.description
          : descriptionController.text,
      phoneNumber: phonenumberController.text.isEmpty
          ? firestoreObj.phoneNumber
          : phonenumberController.text,
      businessCard: businessCardImage != null
          ? await _addHappyHourProvider
              .uploadBusinessCardImageToFirebaseStorage(
                  businessCard: businessCard)
          : businessCard,
      businessLogo: businessLogoImage != null
          ? await _addHappyHourProvider.uploadBusinessLogoToFirebaseStorage(
              businessLogo: businessLogo)
          : businessLogo,
      businessImage: businessImageFile != null
          ? await _addHappyHourProvider.uploadBusinessImageToFirebaseStorage(
              businessImage: businessImage)
          : businessImage,
      menuImage: menuImageList.isNotEmpty && menuImageFiles.isNotEmpty
          ? await _addHappyHourProvider
              .uploadBusinessMenuImageImageToFirebaseStorage(
                  menuImage: menuImageFiles.first!.path)
          : firestoreObj.menuImage,
      menuImage2: menuImageList.isNotEmpty && menuImageFiles.isNotEmpty
          ? await _addHappyHourProvider
              .uploadBusinessMenuImageImageToFirebaseStorage(
                  menuImage: menuImageFiles.last!.path)
          : firestoreObj.menuImage2,
      dayTime: earlyDayTimeList,
      daytimeLate: lateDaytimeList,
      fromTimeToTime: selecteddays,
      dailySpecial: alldailySpecialList,
      foodNames: foodList
          .map((e) => {
                "foodname": e.name,
                "foodcount": e.quantity,
                "fooddiscount": e.discount,
                "discountIcon": e.discountIcon,
                "foodprice": e.price,
                "secondtime": e.time,
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
                "secondtime": e.time,
                "early": e.earlyDrink.value,
                "late": e.lateDrink.value,
              })
          .toList(),
      amenities: amentyAddList,
      barType: barTypeAddList,
      event: selectedEvent,
      id: Get.find<AuthController>().user.uid,
      position: _position,
      latLong: {
        "latitude": _lat == 0.0 ? firestoreObj.latitude : _lat,
        "longitude": _long == 0.0 ? firestoreObj.longitude : _long,
      },
    );

    var obj = HappyHourModel.fromJson(data, firestoreDocId);

    firestoreObj = HappyHourModel(
        obj.id,
        obj.hid,
        obj.businessName,
        obj.businessAddress,
        obj.description,
        obj.phoneNumber,
        obj.businessCard,
        obj.businessLogo,
        obj.businessImage,
        obj.menuImage,
        obj.menuImage2,
        obj.day,
        obj.dayLate,
        obj.time,
        obj.foodName,
        obj.drinkitemName,
        obj.amenities,
        obj.barType,
        obj.businessHour,
        obj.latitude,
        obj.longitude,
        obj.reviewStar,
        obj.countList,
        obj.dailySpecils,
        obj.event,
        obj.fromTimeToTime,
        obj.paid,
        obj.addTime,
        obj.promoted,
        obj.status);

    selectedEvent = obj.event!;
    menuImageList = [];
    menuImageList.add(firestoreObj.menuImage);
    menuImageList.add(firestoreObj.menuImage2);

    isLoading = false;
    update();
  }

  void onDescriptionDone() {
    updateBusinessHourToFireStore();
    Get.back();
    update();
  }

  void updateHappyHourTimes() {}

  void onDayTimeDoneTap() {
    //var index = dayTimeList.where((e) => e.isSelect.isTrue).length;
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

      removeItemsWithTimes();
      update();
      Get.back();
    }
  }

  void resetDualTime(index) {
    dayTimeList[index].isEarly.value = false;
    dayTimeList[index].isLate.value = false;
    dayTimeList[index].keyfrom?.currentState?.reset();
    dayTimeList[index].keyto?.currentState?.reset();
  }
}

class SelectDay {
  late RxBool isSelect;
  late String day;

  SelectDay({
    required this.isSelect,
    required this.day,
  });
}

class LateDayTime {
  late RxBool isSelect;
  late String day;
  late String fromTime;
  late String toTime;
  late String? fromTime2;
  late String? toTime2;
  late List? secondTime;
  late RxBool isEarly;
  late RxBool isLate;
  late GlobalKey<FormState>? keyfrom;
  late GlobalKey<FormState>? keyto;
  late GlobalKey<FormState>? keyfrom2;
  late GlobalKey<FormState>? keyto2;
  LateDayTime({
    required this.isSelect,
    required this.day,
    required this.fromTime,
    required this.toTime,
    required this.isEarly,
    required this.isLate,
    this.fromTime2,
    this.toTime2,
    this.secondTime,
    this.keyfrom,
    this.keyto,
    this.keyfrom2,
    this.keyto2,
  });
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

class SelectDayTime {
  late GlobalKey<FormState>? key;
  late GlobalKey<FormState>? key2;

  late RxBool isSelect;
  late String day;

  late List? secondTime;
  late String? from;
  late String? to;
  SelectDayTime({
    required this.isSelect,
    required this.day,
    this.secondTime,
    this.from,
    this.to,
    this.key,
    this.key2,
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
    required this.discountIcon,
    required this.dropDown,
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
