import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:happy_hour_app/data/models/filter_model.dart';
import 'package:happy_hour_app/data/models/happyhour_model.dart';
import 'package:happy_hour_app/data/providers/add_happyhour_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../global_controller/global_general_controller.dart';
import '../account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';

class HappyHourFilterScreenController extends GetxController {
  final searchController = TextEditingController();
  final AddHappyHourProvider addHappyHourProvider = AddHappyHourProvider();
  double? currentLat;
  double? currentLng;
  FilterModel filter = FilterModel();
  List<HappyHourModel> searchList = [];
  String days = "Sunday";
  String time = "01:00 PM";
  String distance = "mi";
  String drink = "Drinks";
  String food = "Foods";
  String amenities = "Amenities";
  String events = "Events";
  String barType = "BarType";

  bool showFutureHours = false; //todo: to show and hide futrue hours

  List<String> searchListItem = [];

  var daysList = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];

  var timesList = [
    "01:00 PM",
    "02:00 PM",
    "03:00 PM",
    "04:00 PM",
    "05:00 PM",
    "06:00 PM",
    "07:00 PM",
    "08:00 PM",
    "09:00 PM",
    "10:00 PM",
    "11:00 PM",
    "12:00 PM",
    "01:00 AM",
    "02:00 AM",
    "03:00 AM",
    "04:00 AM",
    "05:00 AM",
    "06:00 AM",
    "07:00 AM",
    "08:00 AM",
    "09:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 AM",
  ];

  var distanceList = [
    'Mi',
    'Km',
  ];

  var drinkList = [
    "Domestic",
    "Bottle",
    "Domestic Can",
    "Domestic Draft",
    "Domestic Pitcher",
    "Craft Bottle",
    "Craft Can",
    "Craft Draft",
    "Craft Pitcher",
    "Import Bottle",
    "Import Can",
    "Import Draft",
    "Import Pitcher",
  ];

  var foodsList = [
    " Bone in Wings",
    "Boneless Wings",
    "Pizza",
    "Flat Bread",
    "Burger",
    "Sliders",
    "Nachos",
    "Nachos Chicken/Steak",
    "Nachos- Ahi",
  ];

  var amenitiesList = [
    " Pool Table",
    "Dart Boards",
    "Juke Box",
    "Arcade",
    "Shuffle Board",
    "Board Games",
  ];
  var eventsList = [
    "Pool Tournament",
    "Free Pool",
    "Dart Tournament",
    "Beer Pong Tournament",
    "Cornhole Tournament",
  ];
  var barList = [
    "Restaurant- Corporate",
    "Restaurant- Owner",
    "Bar- Standard",
    "Bar- Upscale",
    "Bar- Dive",
    "Sports Bar",
    "Brewery",
  ];

//============Fetch Radius List ============//
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();

  final RxList<HappyHourModel> _hoursRadiusList = <HappyHourModel>[].obs;

  bool isLoading = false;
  LocationPermissionStatus locationPermissionStatus =
      LocationPermissionStatus.nullStatus;

  List<HappyHourModel> get hoursInRadiusList => _hoursRadiusList;

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

  fetchHoursinRadius() async {
    _hoursRadiusList.value = [];

    if (filter.lat == null || filter.lng == null) {
      Position? currentLoc = await getCurrentPosition();
      filter.lng = currentLoc!.latitude;
      filter.lat = currentLoc.longitude;
      currentLat = filter.lat;
      currentLng = filter.lng;
      update();
    }

    // if (filter.locationUnit.toLowerCase() == 'km') {
    //   filter.range = range * 0.621371;
    // } else {
    //   filter.range = range;
    // }
    _addHappyHourProvider
        .fetchHourInradius(
      lat: filter.lat,
      long: filter.lng,
      rad: range,
    )
        .listen((hours) {
      List<HappyHourModel> _temp = [];
      for (var hour in hours) {
        _temp.add(HappyHourModel.fromDocument(
            hour as DocumentSnapshot<Map<String, dynamic>>,
            hour.id.toString()));
      }
      _hoursRadiusList.value = _temp;
      update();
      //  print(_temp.length);
    });
  }

  final Rx<double> _range = 10.0.obs;
  double get range => _range.value;
  set range(value) => _range.value = value;

  void setRange(double slide) {
    range = slide;
    update();
  }

  Future<void> getAllHoursData() async {
    hoursModelList = <HappyHourModel>[];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("happyhours").get();

    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    for (var element in allData) {
      HappyHourModel user = HappyHourModel.fromDoc(Map.from(element as Map));
      hoursModelList.add(user);
    }
  }

  @override
  void onInit() async {
    fetchHoursinRadius();
    await getAllHoursData();

    super.onInit();
  }

  // fetchAllHours() {
  //   hoursModelList = _addHappyHourProvider.happyHourModelDataList;
  // }

  final Rx<List<HappyHourModel>> _hourModelList = Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursModelList => _hourModelList.value;
  set hoursModelList(value) => _hourModelList.value = value;

  //Filtered list
  final Rx<List<HappyHourModel>> _hourModelListFilter =
      Rx<List<HappyHourModel>>([]);
  List<HappyHourModel> get hoursCityListFilter => _hourModelListFilter.value;
  set hoursCityListFilter(value) => _hourModelListFilter.value = value;

  onSearch(String query) {
    // if (days.isNotEmpty) {
    //   for (var e in hoursModelList) {
    //     if (e.day?[0].containsKey("Hday")) {
    //       if (e.day![0]["Hday"].toString() == days) {
    //         if (time.isNotEmpty) {
    //           for (var e in hoursModelList) {
    //             if (e.day?[0].containsKey("HfromTime")) {
    //               if (e.day?[0]["HfromTime"].toString() == time) {
    //                 hoursCityListFilter = hoursModelList;
    //               }
    //             }
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    // if (days.isNotEmpty) {
    //   hoursCityListFilter = hoursModelList.where((e) {
    //     return e.day?.first.containsKey("Hday");
    //   }).toList();
    // }
    // if (days.isNotEmpty) {
    //   hoursCityListFilter = hoursModelList.where((e) {
    //     return e.day?.first.containsKey("HfromTime");
    //   }).toList();
    // }
    if (query.isNotEmpty) {
      hoursCityListFilter = hoursModelList.where((element) {
        return element.businessAddress!
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    } else {
      hoursCityListFilter = hoursModelList;
    }
    update();
    // print(hoursCityListFilter);
  }

  // applyDayFilter() async {
  //   List<HappyHourModel> filteredHours = [];
  //   Set<int> hoursIndicies = {};
  //
  //   SkipLoop:
  //   for (int hourIndex = 0; hourIndex < hoursInRadiusList.length; hourIndex++) {
  //     /// ============================== check in daily special ==================
  //     if (hoursInRadiusList[hourIndex].dailySpecils != null &&
  //         hoursInRadiusList[hourIndex].dailySpecils!.isNotEmpty) {
  //       for (int i = 0;
  //           i < hoursInRadiusList[hourIndex].dailySpecils!.length;
  //           i++) {
  //         if (hoursInRadiusList[hourIndex]
  //                 .dailySpecils![i]['day']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     ///================================================================================
  //     ///
  //     /// ============================== check in early day times ==================
  //     if (hoursInRadiusList[hourIndex].day != null &&
  //         hoursInRadiusList[hourIndex].day!.isNotEmpty) {
  //       for (int i = 0; i < hoursInRadiusList[hourIndex].day!.length; i++) {
  //         if (hoursInRadiusList[hourIndex]
  //                 .day![i]['Hday']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day!.toString().trim().toLowerCase()) {
  //           // DayFilterModel day = DayFilterModel(
  //           //     day: filter.day.toString().toString(), hourIndex: hourIndex);
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     ///================================================================================
  //     /// ============================== check in early day times ==================
  //     if (hoursInRadiusList[hourIndex].dayLate != null &&
  //         hoursInRadiusList[hourIndex].dayLate!.isNotEmpty) {
  //       for (int i = 0; i < hoursInRadiusList[hourIndex].dayLate!.length; i++) {
  //         if (hoursInRadiusList[hourIndex]
  //                 .dayLate![i]['Hday2']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day!.toString().trim().toLowerCase()) {
  //           // DayFilterModel day = DayFilterModel(
  //           //     day: filter.day.toString().toString(), hourIndex: hourIndex);
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     ///================================================================================
  //   }
  //
  //   filteredHours = [];
  //   List<int> indicies = hoursIndicies.toList();
  //   for (int i = 0; i < indicies.length; i++) {
  //     filteredHours.add(_hoursRadiusList[indicies[i]]);
  //   }
  //
  //   _hoursRadiusList.value = filteredHours;
  //
  //   print('filteredHours: ${filteredHours.first.businessName}');
  //
  //   update();
  // }

  getResults() async {
    isLoading = true;
    update();
    await fetchHoursinRadius();
    if (filter.day != null || filter.day != '') {
      //await applyDayFilter();
    }
    if (filter.time != null || filter.time != '') {
      //await applyTimeFilter();
    }
    isLoading = false;
    update();
    // if (filter.drink != null && filter.drink != '') {}
    // if (filter.food != null && filter.food != '') {}
    // if (filter.amenity != null && filter.amenity != '') {}
    // if (filter.event != null && filter.event != '') {}
    // if (filter.bartype != null && filter.bartype != '') {}
  }

  void assignValueToCity(String p1) {
    filter.city = p1;
  }

  onBusinessNameClick() async {
    var loc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentLat = loc.latitude;
    currentLng = loc.longitude;
    update();
    await Get.to(
      () => PlacePicker(
        apiKey: "AIzaSyDNps9wxy4nEFs1fFOgxjIcI5gTuK28r8s",
        onPlacePicked: (PickResult result) {
          if (result.formattedAddress != null) {
            filter.lng = result.geometry!.location.lat;
            filter.lat = result.geometry!.location.lng;
            currentLat = filter.lat;
            currentLng = filter.lng;
            searchController.text =
                result.formattedAddress!.toString().split(',')[2];
            update();
            Get.back();
          }
        },
        initialPosition: LatLng(
            currentLat!, currentLng!),
        useCurrentLocation: true,
      ),
    );
  }

  String? nameValidator(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Business Name is required';
    }
    if (value.trim().length < 2) {
      return 'Username must be at least 4 characters in length';
    }
    // Return null if the entered Business name is valid
    return null;
  }

  ///original
  // applyDayFilter() async {
  //   Set<HappyHourModel> filteredHours = {};
  //   Set<int> hoursIndicies = {};
  //
  //   SkipLoop:
  //   for (int hourIndex = 0; hourIndex < _hoursRadiusList.length; hourIndex++) {
  //     /// ============================== check in daily special ==================
  //     if (_hoursRadiusList[hourIndex].dailySpecils != null &&
  //         _hoursRadiusList[hourIndex].dailySpecils!.isNotEmpty) {
  //       for (int i = 0;
  //           i < _hoursRadiusList[hourIndex].dailySpecils!.length;
  //           i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .dailySpecils![i]['day']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in early day times ==================
  //     if (_hoursRadiusList[hourIndex].day != null &&
  //         _hoursRadiusList[hourIndex].day!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].day!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .day![i]['Hday']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day!.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in late day times ==================
  //     if (_hoursRadiusList[hourIndex].dayLate != null &&
  //         _hoursRadiusList[hourIndex].dayLate!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].dayLate!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .dayLate![i]['Hday2']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day!.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in event times ==================
  //     if (_hoursRadiusList[hourIndex].event != null &&
  //         _hoursRadiusList[hourIndex].event!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].event!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .event![i]['day']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.day!.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue SkipLoop;
  //         }
  //       }
  //     }
  //   }
  //
  //   filteredHours = {};
  //   List<int> indicies = hoursIndicies.toList();
  //   for (int i = 0; i < indicies.length; i++) {
  //     filteredHours.add(_hoursRadiusList[indicies[i]]);
  //   }
  //
  //   _hoursRadiusList.value = [];
  //   _hoursRadiusList.value = filteredHours.toList();
  //
  //   update();
  // }
  ///
  // applyDayFilter() {
  //   Set times = {};
  //   Set hourIndicies = {};
  //   Set dailySpecialsDays = {};
  //   Set earlyDays = {};
  //   Set lateDays = {};
  //   Set eventDays = {};
  //   Set allTimes = {};
  //   List<MapModel> hourMaps = [];
  //   Set<HappyHourModel> _temp = {};
  //
  //   /// todo: here i am picking starting times
  //   for (int hourIndex = 0; hourIndex < _hoursRadiusList.length; hourIndex++) {
  //     times.clear();
  //
  //     /// todo: here i am picking starting times for daily specials
  //     if (_hoursRadiusList[hourIndex].dailySpecils != null &&
  //         _hoursRadiusList[hourIndex].dailySpecils!.isNotEmpty) {
  //       dailySpecialsDays.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].dailySpecils!.length;
  //           active++) {
  //         dailySpecialsDays.add(_hoursRadiusList[hourIndex]
  //             .dailySpecils![active]['day']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for early day times
  //     if (_hoursRadiusList[hourIndex].day != null &&
  //         _hoursRadiusList[hourIndex].day!.isNotEmpty) {
  //       earlyDays.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].day!.length;
  //           active++) {
  //         earlyDays.add(_hoursRadiusList[hourIndex]
  //             .day![active]['Hday']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for day late times
  //     if (_hoursRadiusList[hourIndex].dayLate != null &&
  //         _hoursRadiusList[hourIndex].dayLate!.isNotEmpty) {
  //       lateDays.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].dayLate!.length;
  //           active++) {
  //         lateDays.add(_hoursRadiusList[hourIndex]
  //             .dayLate![active]['Hday2']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for events times
  //     if (_hoursRadiusList[hourIndex].event != null &&
  //         _hoursRadiusList[hourIndex].event!.isNotEmpty) {
  //       eventDays.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].event!.length;
  //           active++) {
  //         eventDays.add(_hoursRadiusList[hourIndex]
  //             .event![active]['day']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     times.addAll(dailySpecialsDays);
  //     times.addAll(earlyDays);
  //     times.addAll(lateDays);
  //     times.addAll(eventDays);
  //     hourMaps.add(MapModel(
  //         hourIndex: hourIndex,
  //         times: times.map((e) => e.toString()).toList()));
  //   }
  //
  //   /// todo: picking unique starting times
  //   for (int h = 0; h < hourMaps.length; h++) {
  //     for (int time = 0; time < hourMaps[h].times.length; time++) {
  //       allTimes.add(hourMaps[h].times[time]);
  //     }
  //   }
  //
  //   for (var day in allTimes) {
  //     day = day.toString().trim().toLowerCase();
  //     int index = -1;
  //     skip:
  //     for (int i = 0; i < hourMaps.length; i++) {
  //       if (hourMaps[i].times.contains(day)) {
  //         index = i;
  //       } else {
  //         continue skip;
  //       }
  //     }
  //
  //     if (index != -1) {
  //       _temp.add(_hoursRadiusList[index]);
  //     }
  //   }
  //
  //   _hoursRadiusList.value = [];
  //   _hoursRadiusList.value = _temp.toSet().toList();
  //   update();
  // }

  ///
  // applyTimeFilter() async {
  //   Set<HappyHourModel> filteredHours = {};
  //   Set<int> hoursIndicies = {};
  //
  //   Skip:
  //   for (int hourIndex = 0; hourIndex < _hoursRadiusList.length; hourIndex++) {
  //     /// ============================== check in daily special ==================
  //     if (_hoursRadiusList[hourIndex].dailySpecils != null &&
  //         _hoursRadiusList[hourIndex].dailySpecils!.isNotEmpty) {
  //       for (int i = 0;
  //           i < _hoursRadiusList[hourIndex].dailySpecils!.length;
  //           i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .dailySpecils![i]['fromTime']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.time.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue Skip;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in early day times ==================
  //     if (_hoursRadiusList[hourIndex].day != null &&
  //         _hoursRadiusList[hourIndex].day!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].day!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .day![i]['HfromTime']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.time!.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue Skip;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in early day times ==================
  //     if (_hoursRadiusList[hourIndex].dayLate != null &&
  //         _hoursRadiusList[hourIndex].dayLate!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].dayLate!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //                 .dayLate![i]['HfromTime2']
  //                 .toString()
  //                 .trim()
  //                 .toLowerCase() ==
  //             filter.time!.toString().trim().toLowerCase()) {
  //           hoursIndicies.add(hourIndex);
  //           continue Skip;
  //         }
  //       }
  //     }
  //
  //     /// ============================== check in event times ==================
  //     if (_hoursRadiusList[hourIndex].event != null &&
  //         _hoursRadiusList[hourIndex].event!.isNotEmpty) {
  //       for (int i = 0; i < _hoursRadiusList[hourIndex].event!.length; i++) {
  //         if (_hoursRadiusList[hourIndex]
  //             .event![i]['fromtime']
  //             .toString()
  //             .trim()
  //             .toLowerCase() ==
  //             filter.time!.toString().trim().toLowerCase()) {
  //
  //           hoursIndicies.add(hourIndex);
  //           continue Skip;
  //         }
  //       }
  //     }
  //
  //     ///================================================================================
  //   }
  //
  //   filteredHours = {};
  //   List<int> indicies = hoursIndicies.toList();
  //   for (int i = 0; i < indicies.length; i++) {
  //     filteredHours.add(_hoursRadiusList[indicies[i]]);
  //   }
  //
  //   _hoursRadiusList.value = [];
  //   _hoursRadiusList.value = filteredHours.toList();
  //
  //   update();
  // }
  ///
  // applyTimeFilter() {
  //   Set times = {};
  //   Set hourIndicies = {};
  //   Set dailytimes = {};
  //   Set daytimes = {};
  //   Set dayLateTimes = {};
  //   Set eventTimes = {};
  //   Set allTimes = {};
  //   List<MapModel> hourMaps = [];
  //   Set<HappyHourModel> _temp = {};
  //
  //   /// todo: here i am picking starting times
  //   for (int hourIndex = 0; hourIndex < _hoursRadiusList.length; hourIndex++) {
  //     times.clear();
  //
  //     /// todo: here i am picking starting times for daily specials
  //     if (_hoursRadiusList[hourIndex].dailySpecils != null &&
  //         _hoursRadiusList[hourIndex].dailySpecils!.isNotEmpty) {
  //       dailytimes.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].dailySpecils!.length;
  //           active++) {
  //         dailytimes.add(_hoursRadiusList[hourIndex]
  //             .dailySpecils![active]['fromTime']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for early day times
  //     if (_hoursRadiusList[hourIndex].day != null &&
  //         _hoursRadiusList[hourIndex].day!.isNotEmpty) {
  //       daytimes.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].day!.length;
  //           active++) {
  //         daytimes.add(_hoursRadiusList[hourIndex]
  //             .day![active]['HfromTime']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for day late times
  //     if (_hoursRadiusList[hourIndex].dayLate != null &&
  //         _hoursRadiusList[hourIndex].dayLate!.isNotEmpty) {
  //       dayLateTimes.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].dayLate!.length;
  //           active++) {
  //         dayLateTimes.add(_hoursRadiusList[hourIndex]
  //             .dayLate![active]['HfromTime2']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     /// todo: here i am picking starting times for events times
  //     if (_hoursRadiusList[hourIndex].event != null &&
  //         _hoursRadiusList[hourIndex].event!.isNotEmpty) {
  //       eventTimes.clear();
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //           active < _hoursRadiusList[hourIndex].event!.length;
  //           active++) {
  //         eventTimes.add(_hoursRadiusList[hourIndex]
  //             .event![active]['fromtime']
  //             .toString()
  //             .trim()
  //             .toLowerCase());
  //         hourIndicies.add(hourIndex);
  //       }
  //     }
  //
  //     times.addAll(dailytimes);
  //     times.addAll(daytimes);
  //     times.addAll(dayLateTimes);
  //     times.addAll(eventTimes);
  //     hourMaps.add(MapModel(
  //         hourIndex: hourIndex,
  //         times: times.map((e) => e.toString()).toList()));
  //   }
  //
  //   /// todo: picking unique starting times
  //   for (int h = 0; h < hourMaps.length; h++) {
  //     for (int time = 0; time < hourMaps[h].times.length; time++) {
  //       allTimes.add(hourMaps[h].times[time]);
  //     }
  //   }
  //
  //   for (var time in allTimes) {
  //     time = time.toString().trim().toLowerCase();
  //     int index = -1;
  //     skip:
  //     for (int i = 0; i < hourMaps.length; i++) {
  //       if (hourMaps[i].times.contains(time)) {
  //         index = i;
  //       } else {
  //         continue skip;
  //       }
  //     }
  //
  //     if (index != -1) {
  //       _temp.add(_hoursRadiusList[index]);
  //     }
  //   }
  //
  //   _hoursRadiusList.value = [];
  //   _hoursRadiusList.value = _temp.toSet().toList();
  //   update();
  // }
}

//==============*New Search Method *================//

class DayFilterModel {
  int hourIndex;
  String day;
  DayFilterModel({required this.day, required this.hourIndex});
}
