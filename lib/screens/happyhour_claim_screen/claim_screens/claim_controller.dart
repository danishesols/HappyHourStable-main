import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/providers/add_happyhour_provider.dart';
import '../../../data/providers/favorite_provider.dart';
import '../../../global_controller/global_general_controller.dart';
import '../../../routes/app_routes.dart';

class ClaimController extends GetxController {
  final HappyHourModel hour = Get.arguments;
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

  final ImagePicker _picker = ImagePicker();

  getEditData() {
    businessNameController.text = hour.businessName.toString();
    businessAddressController.text = hour.businessAddress.toString();

    descriptionController.text = hour.description.toString();

    happyHourMenuImage = hour.menuImage;
    for (var amen in amenitiesList) {
      if (hour.amenities!.contains(amen.amenity)) {
        amen.isSelect.value = true;
        amentyAddList.add(amen.amenity);
      }
    }
    for (var bar in barTypeList) {
      if (hour.barType!.contains(bar.barType)) {
        bar.isSelect.value = true;
        barTypeAddList.add(bar.barType.toString());
      }
      //print(barTypeAddList);
    }
  }

  @override
  void onInit() {
    getEditData();
    //business Hour Update
    businessHourUpdate();

    //*=====Happy Hour Time =======*//
    happyHourTimeUpdate();
    //Food Update
    for (int i = 0; i < hour.foodName!.length; i++) {
      foodUpdate(i);
    }
    //Drink update
    for (int i = 0; i < hour.drinkitemName!.length; i++) {
      drinkUpdate(i);
    }

    //daily special update
    for (int i = 0; i < hour.dailySpecils!.length; i++) {
      dailySpecialUpdate(i);
    }

    //event update
    for (int i = 0; i < hour.event!.length; i++) {
      eventUpdate(i);
    }

    super.onInit();
  }

  businessHourUpdate() {
    if (hour.fromTimeToTime != null) {
      for (int i = 0; i < (hour.fromTimeToTime?.length ?? 0); i++) {
        for (var bh in dayFromTimeToTimeList) {
          if (hour.fromTimeToTime?[i]['bDay']?.contains(bh.day) ?? false) {
            bh.isSelect.value = true;
            selecteddays.add({
              "bDay": bh.day,
              "bFtime": hour.fromTimeToTime?[i]['bFtime'],
              "bTtime": hour.fromTimeToTime?[i]['bTtime'],
            });
          }
        }
      }
    }
  }

  happyHourTimeUpdate() {
    if (hour.day!.isNotEmpty) {
      for (int i = 0; i < hour.day!.length; i++) {
        for (var dt in dayTimeList) {
          if (hour.day![i]['Hday'].contains(dt.day)) {
            dt.isSelect.value = true;
            hDayTimeList.add({
              "Hday": dt.day,
              "HfromTime": hour.day?[i]['HfromTime'],
              "HtoTime": hour.day?[i]['HtoTime']
            });
          }
        }
      }
    }
  }

  foodUpdate(index) {
    for (var food in foodallList) {
      if (hour.foodName?[index]['foodname'].contains(food.name) ?? false) {
        foodList.add(
          LocalFoodModel(
            name: food.name.toString(),
            quantity: hour.foodName?[index]['foodcount'],
            price: hour.foodName?[index]['foodprice'],
            discount: hour.foodName?[index]['fooddiscount'],
            dropDown: ["%", "\$"],
            priceController:
                TextEditingController(text: hour.foodName?[index]['foodprice']),
            bothTimeFood: false.obs,
            time: foodtime,
          ),
        );
      }
    }
  }

  drinkUpdate(index) {
    for (var drink in drinkList) {
      if (hour.drinkitemName?[index]['drinkname'].contains(drink.name)) {
        localdrinkList.add(
          LocalDrinkModel(
            name: drink.name.toString(),
            size: hour.drinkitemName?[index]['drinksize'],
            price: hour.drinkitemName?[index]['drinkprice'],
            discount: hour.drinkitemName?[index]['drinkdiscount'],
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
            discountController: TextEditingController(
                text: hour.drinkitemName?[index]['drinkdiscount'] == 0
                    ? ""
                    : hour.drinkitemName?[index]['drinkdiscount'].toString()),
            drinkController: TextEditingController(
                text: hour.drinkitemName?[index]['drinkprice']),
            bothTimeDrink: false.obs,
            time: drinktime,
            sizeController: TextEditingController(
                text: hour.drinkitemName?[index]['drinksize']),
          ),
        );
      }
    }
  }

//======dailyspecial Update
  dailySpecialUpdate(index) {
    alldailySpecialList.clear();
    for (var ds in daysList) {
      if (hour.dailySpecils?[index]['day'].contains(ds.day)) {
        ds.isSelect.value = true;

        if (hour.dailySpecils?[index]['day'] == "Sunday") {
          sundaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'],
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in sundaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Monday") {
          mondaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in mondaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Tuesday") {
          tuesdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in tuesdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Wednesday") {
          wednesdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in wednesdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Thursday") {
          thursdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in thursdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Friday") {
          fridaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in fridaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
        if (hour.dailySpecils?[index]['day'] == "Saturday") {
          saturdaydailySpecialItemList.add({
            "name": hour.dailySpecils?[index]['name'],
            "quantity": hour.dailySpecils?[index]['quantity'].toString(),
            "price": hour.dailySpecils?[index]['price'],
            "discount": hour.dailySpecils?[index]['discount'],
            "sizeIcon": "oz",
            "day": hour.dailySpecils?[index]['day'],
            "fromTime": hour.dailySpecils?[index]['fromTime'],
            "toTime": hour.dailySpecils?[index]['toTime'],
            "index": hour.dailySpecils?[index]['index'],
            "controller": TextEditingController(
                text: hour.dailySpecils?[index]['discount'].toString()),
            "sizeController": TextEditingController(
                text: hour.dailySpecils?[index]['quantity'].toString()),
            "pricecontroller":
                TextEditingController(text: hour.dailySpecils?[index]['price']),
          });
          for (var e in saturdaydailySpecialItemList) {
            alldailySpecialList.add({
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
        }
      }
    }
  }

  // addtoEditdailypecial() {
  //   List alldailySpecial = [];
  //   for (var e in sundaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in mondaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in tuesdaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in wednesdaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in thursdaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in fridaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   for (var e in saturdaydailySpecialItemList) {
  //     alldailySpecial.add({
  //       "name": e['name'],
  //       "quantity": e['quantity'],
  //       "price": e["price"],
  //       "discount": e["discount"],
  //       "sizeIcon": e["sizeIcon"],
  //       "day": e['day'],
  //       "fromTime": e["fromTime"],
  //       "toTime": e["toTime"],
  //       "index": e["index"],
  //     });
  //   }
  //   alldailySpecialList.addAll(alldailySpecial);
  // }

//*=========event Update ====//
  eventUpdate(index) {
    for (var e in eventList) {
      if (hour.event?[index]['name'].contains(e.event)) {
        e.isSelect.value = true;
        selectedEvent.add({
          "name": e.event,
          "day": hour.event?[index]['day'],
          "fromtime": hour.event?[index]['fromtime'],
          "totime": hour.event?[index]['totime']
        });
      }
    }
  }
//*=====observable variables=========*//

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

  onBusinessNameClick() async {
    Get.to(
      () => PlacePicker(
        apiKey:"AIzaSyDNps9wxy4nEFs1fFOgxjIcI5gTuK28r8s",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;

            if(result.name == null){
              businessNameController.text = result.formattedAddress!.toString().split(',')[0];
            }else{
              businessNameController.text = result.name!;
            }
            businessAddressController.text = result.formattedAddress!;
            Get.back();
          }
        },
        initialPosition: LatLng(
            latitude ?? 37.42796133580664, longitude ?? -122.085749655962),
        useCurrentLocation: true,
      ),
    );
  }

  onBusinessAddressClick() async {
    Get.to(
      () => PlacePicker(

        apiKey:"AIzaSyDNps9wxy4nEFs1fFOgxjIcI5gTuK28r8s",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            _lat = result.geometry!.location.lat;
            _long = result.geometry!.location.lng;
            _isAddressRemoved.value = false;
            if(result.name == null){
              businessNameController.text = result.formattedAddress!.toString().split(',')[0];
            }else{
              businessNameController.text = result.name!;
            }
            businessAddressController.text = result.formattedAddress!;
            Get.back();
          }
        },
        initialPosition: LatLng(
            latitude ?? 33.704526937198345, longitude ?? 73.07165924459696),
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

  Future uploadBusinessCard() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessCard = imageFile.path;
    }
  }

  Future uploadBusinessLogo() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessLogo = imageFile.path;
    }
  }

  Future uploadBusinessImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      businessImage = imageFile.path;
    }
  }

  Future uploadHappyHourMenuImage() async {
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (imageFile != null) {
      happyHourMenuImage = imageFile.path;
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
  ];

  String day = "Sunday";
  final dayList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
  ];
  String discount = "";

  final discountList = [
    "5",
    "10",
    "20",
    "30",
    "40",
    "50",
  ];
  String quantity = "";
  final quantityList = [
    "5",
    "10",
    "20",
    "30",
    "40",
    "50",
  ];

  List selecteddays = [];
  List<SelectDayTime> dayFromTimeToTimeList = [
    SelectDayTime(
        isSelect: false.obs,
        day: "Sunday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Monday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Tuesday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Wednesday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Thursday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Friday",
        image: "assets/icons/Ellipse 1.png"),
    SelectDayTime(
        isSelect: false.obs,
        day: "Saturday",
        image: "assets/icons/Ellipse 1.png"),
  ];
  List<SelectDayTime> dayTimeList = [
    SelectDayTime(
      isSelect: false.obs,
      day: "Sunday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Monday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Tuesday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Wednesday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Thursday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Friday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
    SelectDayTime(
      isSelect: false.obs,
      day: "Saturday",
      image: "assets/icons/Ellipse 1.png",
      secondTime: [],
    ),
  ];

//*Business Hour and Days *//
  final hourBformKey = GlobalKey<FormState>();
  String? bDay;
  String? bFromtime;
  String? bTotime;
  void bUpdateDay(index) async {
    dayFromTimeToTimeList[index].isSelect.value =
        !dayFromTimeToTimeList[index].isSelect.value;
    for (var days in dayFromTimeToTimeList) {
      if (days.isSelect.isTrue) {
        // dayFromTimeToTimeList[index].day = days.day;
        bDay = dayFromTimeToTimeList[index].day;
        update();
      }
    }
    selecteddays
        .removeWhere((e) => e['bDay'] == dayFromTimeToTimeList[index].day);
  }

  void bDayTime() {
    !selecteddays.contains("bDay");
    selecteddays.add({"bDay": bDay, "bFtime": bFromtime, "bTtime": bTotime});
  }

  //*Hour days and Times *//
  String? hDay;
  String? hFromTime;
  String? hToTime;
  String? hFromTime2;
  String? hToTime2;

  List hDayTimeList = [];

  void hUpdateDay(index) async {
    dayTimeList[index].isSelect.value = !dayTimeList[index].isSelect.value;
    for (var day in dayTimeList) {
      if (day.isSelect.isTrue) {
        // hDay = day.day.toString();
        hDay = dayTimeList[index].day;
        update();
      }
      hDayTimeList.removeWhere((e) => e['Hday'] == dayTimeList[index].day);

      // if (dayTimeList[index].isSelect.isTrue &&
      //     hDayTimeList.contains(dayTimeList[index].day)) {
      //   hDayTimeList.removeAt(index);
      // }
      // print(hDayTimeList);
    }
  }

  void hDayTime() {
    !hDayTimeList.contains("Hday");
    hDayTimeList.add({
      "Hday": hDay,
      "HfromTime": hFromTime,
      "HtoTime": hToTime,
    });
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

  List<LocalFoodModel> foodList = [];
  void addfoodmanually() {
    foodList.add(
      LocalFoodModel(
        name: addfoodManuallyController.text.toString(),
        quantity: 0,
        price: "",
        discount: 0,
        dropDown: ["%", "\$"],
        priceController: TextEditingController(),
        bothTimeFood: false.obs,
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
          dropDown: ["%", "\$"],
          priceController: TextEditingController(),
          bothTimeFood: false.obs,
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

  showBothTimeFood(index) {
    foodList[index].bothTimeFood.value = !foodList[index].bothTimeFood.value;
  }

  showBothTimeDrink(index) {
    localdrinkList[index].bothTimeDrink.value =
        !localdrinkList[index].bothTimeDrink.value;
  }

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
        ),
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
    alldailySpecialList.clear();
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

  void dailySpecialDoneTap() {
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
          isMonday &&
          isTuesday &&
          isWednesday &&
          isThursday &&
          isFriday &&
          isSaturday) {
        Get.back();
      }

      addToDailyySpecial();
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
      Get.back();
    }
    update();
  }

  void onEventDoneTap() {
    update();
    if (eventKey.currentState!.validate() == false) {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Select Day and Times");
    }
    if (eventKey.currentState?.validate() ?? false) {
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
    barTypeList[index].isSelect.value = !barTypeList[index].isSelect.value;
    for (var e in barTypeList) {
      if (e.isSelect.value == true) {
        barType = barTypeList[index].barType;
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
  String eventStarttime = "01:00 AM";
  String eventendtime = "01:00 PM";

  List selectedEvent = [];
  List eventList = [
    Event(isSelect: false.obs, event: "Pool Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Free Pool", day: "", time: ""),
    Event(isSelect: false.obs, event: "Dart Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Cornhole Tournment", day: "", time: ""),
    Event(
        isSelect: false.obs, event: "Beer Pong Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Other Tournament", day: "", time: ""),
    Event(isSelect: false.obs, event: "Karaoke", day: "", time: ""),
    Event(isSelect: false.obs, event: "Trivia Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Live Music ", day: "", time: ""),
    Event(isSelect: false.obs, event: "Comedy Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Open Mic", day: "", time: ""),
    Event(isSelect: false.obs, event: "Paint and Sip", day: "", time: ""),
    Event(isSelect: false.obs, event: "Ladies Night", day: "", time: ""),
    Event(isSelect: false.obs, event: "Industry Night", day: "", time: ""),
  ];

  String? eventname = "";

  eventListadded() {
    selectedEvent.add({
      "name": eventname!,
      "day": day,
      "fromtime": eventStarttime,
      "totime": eventendtime
    });
    update();
  }

  void updateEvent(index) async {
    eventList[index].isSelect.value = !eventList[index].isSelect.value;
    for (var event in eventList) {
      if (event.isSelect == true) {
        eventname = eventList[index].event;
        update();
      }
    }
    update();

    // if (eventList[index].isSelect.value == false &&
    //     selectedEvent.contains(eventname)) {
    //   selectedEvent.removeWhere((e) => e['name'] == eventname);

    //   // selectedEvent.remove({
    //   //   "name": eventname,
    //   //   "day": day,
    //   //   "fromtime": eventStarttime,
    //   //   "totime": eventendtime
    //   // });

    // } else {
    //   selectedEvent.add(eventname);
    // }
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

  void onHourScreenDoneTap() {
    update();
    Get.back();

    // var index = dayFromTimeToTimeList.where((e) => e.isSelect.isTrue).length;

    // if (index == 0) {
    //   Get.back();
    // }
    // if (!hourBformKey.currentState!.validate()) {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: "Select Time", description: "Please Select all the Time");
    // }
    // if (hourBformKey.currentState!.validate()) {
    //   if (dayFromTimeToTimeList[0].isSelect.isTrue &&
    //       bFromtime != null &&
    //       bTotime != null) {
    //     Get.back();
    //   }
    // }
  }

  final businessKey = GlobalKey<FormState>();

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

  // void onBusinessnextTap() {
  //   if (formKey.currentState!.validate()) {
  //     if (businessCard == "" ||
  //         businessImage == "" ||
  //         businessLogo == "" ||
  //         happyHourMenuImage == "") {
  //       Get.find<GlobalGeneralController>().errorSnackbar(
  //           title: "Image",
  //           description: "Make sure you have picked all The images");
  //     } else if (formKey.currentState!.validate() &&
  //         businessCard != "" &&
  //         businessImage != "" &&
  //         businessLogo != "" &&
  //         happyHourMenuImage != "") {
  //       Get.toNamed(Routes.businessDescriptionScreen);
  //     }
  //   }
  // }

  void onDescriptionNextTap() {
    Get.toNamed(Routes.addBusinessHourScreen);
    // if (descriptionController.text == "") {
    //   Get.find<GlobalGeneralController>().errorSnackbar(
    //       title: "Error", description: "Please Write The Description");
    // } else if (descriptionController.text != "") {
    //   Get.toNamed(Routes.addBusinessHourScreen);
    // }
  }

  void claimedHourTap() {
    /// TODO:
    if (businessImage != "" && businessLogo != "" && businessCard != "") {
      Get.toNamed(Routes.happyHourEditScreen, arguments: Get.arguments);
      // claimed(hourId);
    } else {
      Get.find<GlobalGeneralController>()
          .errorSnackbar(title: "Error", description: "Add All Images");
    }
  }

  final FavoriteProvider favoriteProvider = FavoriteProvider();
  final geo = Geoflutterfire();
  claimed(hourId) {
    if (Get.find<AuthController>().user.isBusiness) {
      // * mark hour as claimed.
      favoriteProvider.claimedHour(
        userId: Get.find<AuthController>().user.uid,
        hourId: hourId,
      );
    }
  }

  Future<void> updateBusinessHourToFireStore() async {
    // if (formKey.currentState!.validate()) {
    GeoFirePoint _position = geo.point(
        latitude: _lat == 0.0 ? hour.latitude! : _lat,
        longitude: _long == 0.0 ? hour.longitude! : _long);
    isLoading = true;
    await _addHappyHourProvider.updateHourInFirebase(
      docId: hour.hid!,
      businessName: businessNameController.text,
      businessAddress: businessAddressController.text,
      description: descriptionController.text,
      phoneNumber: phonenumberController.text,
      businessCard: await _addHappyHourProvider
          .uploadBusinessCardImageToFirebaseStorage(businessCard: businessCard),
      businessLogo: await _addHappyHourProvider
          .uploadBusinessLogoToFirebaseStorage(businessLogo: businessLogo),
      businessImage: await _addHappyHourProvider
          .uploadBusinessImageToFirebaseStorage(businessImage: businessImage),
      //todo: upload menuImage2
      menuImage: happyHourMenuImage,
      menuImage2: '',

      dayTime: hDayTimeList,
      fromTimeToTime: selecteddays,
      dailySpecial: alldailySpecialList,
      foodNames: foodList
          .map((e) => {
                "foodname": e.name,
                "foodcount": e.quantity,
                "fooddiscount": e.discount,
                "foodprice": e.price,
                "secondtime": e.time,
                "early": true,
                "late": true,
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
                "early": true,
                "late": true,
              })
          .toList(),
      amenities: amentyAddList,
      barType: barTypeAddList,
      event: selectedEvent,
      id: Get.find<AuthController>().user.uid,
      position: _position,
      latLong: {
        "latitude": _lat == 0.0 ? hour.latitude : _lat,
        "longitude": _long == 0.0 ? hour.longitude : _long,
      },
    );
    claimed(hour.hid);
    await Get.offNamed(Routes.claimPackagesScreen);

    isLoading = false;
    // Get.back();
  }
}

class Event {
  late RxBool isSelect;
  late String event;
  late String day;
  late String time;

  Event({
    required this.isSelect,
    required this.event,
    required this.day,
    required this.time,
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
  late List? secondTime;
  SelectDayTime({
    required this.isSelect,
    required this.day,
    required this.image,
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
  List<String> dropDown;
  TextEditingController priceController;
  TextEditingController? discountController;
  RxBool bothTimeFood;
  String time;

  LocalFoodModel({
    required this.name,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.dropDown,
    required this.priceController,
    this.discountController,
    required this.bothTimeFood,
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
