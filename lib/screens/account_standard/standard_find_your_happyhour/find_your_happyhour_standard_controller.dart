import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/providers/add_review_provider.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/happyhour_model.dart';
import '../../../data/providers/add_happyhour_provider.dart';
import '../../../global_controller/global_general_controller.dart';

enum LocationPermissionStatus {
  denied,
  notEnabled,
  deniedForever,
  nullStatus,
  enabled,
}

class FindYourHappyHourStandardController extends GetxController {
  final AddReviewProvider _addReviewProvider = AddReviewProvider();
  final AddHappyHourProvider _addHappyHourProvider = AddHappyHourProvider();

  final RxList<HappyHourModel> _hoursList = <HappyHourModel>[].obs;
  List<HappyHourModel> get hoursInRadiusList => _hoursList;
  LocationPermissionStatus locationPermissionStatus =
      LocationPermissionStatus.nullStatus;
  bool isLoading = false;

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
        desiredAccuracy: LocationAccuracy.best);
    return currentLoc;
  }

  // enableLocationManually() async {
  //   bool isEnabled = await enableLocation();
  //   if (isEnabled) {
  //     await fetchHours();
  //   }
  // }

  fetchHours() async {
    isLoading = true;
    update();
    Position? currentLoc = await getCurrentPosition();
    if (currentLoc != null) {
      _addHappyHourProvider
          .fetchHourInradius(
        lat: currentLoc.latitude,
        long: currentLoc.longitude,
        // lat: _locationData?.latitude ?? 33.704526937198345,
        // long: _locationData?.longitude ?? 73.07165924459696,
       // rad: 10 * 1609.344,
       rad: 30,
        //rad: 10,
      )
          .listen((hours) async {
        Set<HappyHourModel> _temp = {};
        for (var hour in hours) {
          _temp.add(
            HappyHourModel.fromDocument(
              hour as DocumentSnapshot<Map<String, dynamic>>,
              hour.id.toString(),
            ),
          );
        }

        /// todo: working on hours starting within 1hr

        _hoursList.value = _temp.toList();
        newFilter();
        isLoading = false;
        update();
      });
    }
  }

  String showTime = "";
  newFilter() {
    print("Find Happy Hour Standard");
    Set<HappyHourModel> _temp = {};
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);
    String m = now.hour.toString() + "." + now.minute.toString();
    double hourOfDay = double.parse(m);
    print("current hour is $hourOfDay");
    for (var element in _hoursList) {
      /// *******************************///
      /// dailySpecial Happy Hour
      element.dailySpecils?.forEach((dayTime) {
        bool twoDayHHour = false; // for two combine days
        dayOfWeek = DateFormat('EEEE').format(now); // for two combine days
        int startHour = int.parse(dayTime['fromTime'].toString() != ""
            ? dayTime['fromTime'].toString().split(':').first
            : "0");
        String startMinutesString = dayTime['fromTime'].toString() != ""
            ? dayTime['fromTime'].toString().split(':')[1]
            : "0";
        int startMinutes = int.parse(startMinutesString.split(' ').first);
        int endHour = int.parse(dayTime['toTime'].toString().split(':').first);

        if (dayTime['fromTime'].toString().contains("PM")) {
          if (startHour != 12) {
            startHour = startHour + 12;
          }
        }
        if (dayTime['fromTime'].toString().contains("AM")) {
          if (startHour == 12) {
            startHour = 0;
          }
        }
        if (dayTime['toTime'].toString().contains("PM")) {
          if (endHour != 12) {
            endHour = endHour + 12;
          }
        }
        if (dayTime['toTime'].toString().contains("AM")) {
          if (dayTime['fromTime'].toString().contains("PM")) {
            if (endHour == 12) {
              endHour = 24;
            }
          } else if (endHour == 12) {
            endHour = 0;
          }
        }
        // for two combine day
        if (dayTime['fromTime'].toString().contains("PM")) {
          if (dayTime['toTime'].toString().contains("AM")) {
            DateTime previousDay = now.subtract(const Duration(days: 1));
            String today = DateFormat('EEEE').format(now);
            if (dayOfWeek != dayTime['day']) {
              int endHourOnn =
                  int.parse(dayTime['toTime'].toString().split(':').first);
              if (endHourOnn > hourOfDay) {
                dayOfWeek = DateFormat('EEEE').format(previousDay);
              }
              if (endHour > hourOfDay) {
                twoDayHHour = true;
              }
            }

            endHour += 24;
          }
        }

        if (dayTime['fromTime'].toString().contains("AM")) {
          if (dayTime['toTime'].toString().contains("AM")) {
            int endHourOnn =
                int.parse(dayTime['toTime'].toString().split(':').first);
            print("true");
            if (endHourOnn == 12) {
              endHour = 12;
            }
          }
        }
        //
        double startHourWithMin =
            double.parse(startHour.toString() + "." + startMinutes.toString());
        String minutesString = dayTime['toTime'].toString().split(':')[1];
        int minutes = int.parse(minutesString.split(' ').first);
        double endHourWithMin =
            double.parse(endHour.toString() + "." + minutes.toString());
        if (dayTime['day'] == dayOfWeek && endHourWithMin > hourOfDay) {
          if (startHourWithMin <= hourOfDay || twoDayHHour) {
            String time =
                (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
                    .toString();
            showTime = (dayTime['fromTime'].toString() +
                    " - " +
                    dayTime['toTime'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "dailySpecils: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          } else if (startHour == (now.hour + 1)) {
            String time =
                (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
                    .toString();
            showTime = (dayTime['fromTime'].toString() +
                    " - " +
                    dayTime['toTime'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "dailySpecils: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          } else if ((startHourWithMin.toString().split(".").first) ==
              (hourOfDay.toString().split(".").first)) {
            String time =
                (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
                    .toString();
            showTime = (dayTime['fromTime'].toString() +
                    " - " +
                    dayTime['toTime'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "dailySpecils: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          }
        } else {
          /// for next day happy hour
          DateTime next = now.add(const Duration(days: 1));
          String nextDay = DateFormat('EEEE').format(next);
          if (dayTime['day'] == nextDay && now.hour >= 23) {
            if (startHourWithMin >= 0 && startHourWithMin < 1.1) {
              print("next day condition passed");
              String time = (dayTime['fromTime'].toString() +
                      dayTime['toTime'].toString())
                  .toString();
              showTime = (dayTime['fromTime'].toString() +
                      " - " +
                      dayTime['toTime'].toString())
                  .toString();
              element.showTime = showTime;
              element.showTimeInCard?.add(time);
              print(
                  "dayLate: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
              print("============================================");
              _temp.add(element);
            }
          }

          ///
        }
      });

      /// *******************************///
      /// dailyLate Happy Hour

      element.dayLate?.forEach((dayTime) {
        bool twoDayHHour = false; // for two combine days
        dayOfWeek = DateFormat('EEEE').format(now); // for two combine days

        print(dayTime['Hday2']);
        print(dayTime['HfromTime2'].toString());
        int startHour = int.parse(dayTime['HfromTime2'].toString() != "" &&
                dayTime['HfromTime2'].toString() != 'null'
            ? dayTime['HfromTime2'].toString().split(':').first
            : "0");
        String startMinutesString = dayTime['HfromTime2'].toString() != "" &&
                dayTime['HfromTime2'].toString() != 'null'
            ? dayTime['HfromTime2'].toString().split(':')[1]
            : "0";
        int startMinutes = int.parse(startMinutesString.split(' ').first);
        int endHour =
            int.parse(dayTime['HtoTime2'].toString().split(':').first);

        if (dayTime['HfromTime2'].toString().contains("PM")) {
          if (startHour != 12) {
            startHour = startHour + 12;
          }
        }
        if (dayTime['HfromTime2'].toString().contains("AM")) {
          if (startHour == 12) {
            startHour = 0;
          }
        }
        if (dayTime['HtoTime2'].toString().contains("PM")) {
          if (endHour != 12) {
            endHour = endHour + 12;
          }
        }
        if (dayTime['HtoTime2'].toString().contains("AM")) {
          if (dayTime['fromTime2'].toString().contains("PM")) {
            if (endHour == 12) {
              endHour = 24;
            }
          } else if (endHour == 12) {
            endHour = 0;
          }
        }
        // for two combine day
        if (dayTime['HfromTime2'].toString().contains("PM")) {
          if (dayTime['HtoTime2'].toString().contains("AM")) {
            DateTime previousDay = now.subtract(const Duration(days: 1));
            String today = DateFormat('EEEE').format(now);
            if (dayOfWeek != dayTime['Hday2']) {
              int endHourOnn =
                  int.parse(dayTime['HtoTime2'].toString().split(':').first);
              if (endHourOnn > hourOfDay) {
                dayOfWeek = DateFormat('EEEE').format(previousDay);
              }
              if (endHour > hourOfDay) {
                twoDayHHour = true;
              }
            }
            endHour += 24;
          }
        }

        if (dayTime['HfromTime2'].toString().contains("AM")) {
          if (dayTime['HtoTime2'].toString().contains("AM")) {
            int endHourOnn =
                int.parse(dayTime['HtoTime2'].toString().split(':').first);
            print("true");
            if (endHourOnn == 12) {
              endHour = 12;
            }
          }
        }
        //

        double startHourWithMin =
            double.parse(startHour.toString() + "." + startMinutes.toString());
        String minutesString = dayTime['HtoTime2'].toString().split(':')[1];
        int minutes = int.parse(minutesString.split(' ').first);
        double endHourWithMin =
            double.parse(endHour.toString() + "." + minutes.toString());
        if (dayTime['Hday2'] == dayOfWeek && endHourWithMin > hourOfDay) {
          if (startHourWithMin <= hourOfDay || twoDayHHour) {
            String time = (dayTime['HfromTime2'].toString() +
                    dayTime['HtoTime2'].toString())
                .toString();
            showTime = (dayTime['HfromTime2'].toString() +
                    " - " +
                    dayTime['HtoTime2'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);

            print(
                "Day Late: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
            _temp.add(element);
          } else if (startHour == (now.hour + 1)) {
            String time = (dayTime['HfromTime2'].toString() +
                    dayTime['HtoTime2'].toString())
                .toString();
            showTime = (dayTime['HfromTime2'].toString() +
                    " - " +
                    dayTime['HtoTime2'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "Day late: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          } else if ((startHourWithMin.toString().split(".").first) ==
              (hourOfDay.toString().split(".").first)) {
            String time = (dayTime['HfromTime2'].toString() +
                    dayTime['HtoTime2'].toString())
                .toString();
            showTime = (dayTime['HfromTime2'].toString() +
                    " - " +
                    dayTime['HtoTime2'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "Day late: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          }
        } else {
          /// for next day happy hour
          DateTime next = now.add(const Duration(days: 1));
          String nextDay = DateFormat('EEEE').format(next);
          if (dayTime['Hday2'] == nextDay && now.hour >= 23) {
            if (startHourWithMin >= 0 && startHourWithMin < 1.1) {
              print("next day condition passed");
              String time = (dayTime['HfromTime2'].toString() +
                      dayTime['HtoTime2'].toString())
                  .toString();
              showTime = (dayTime['HfromTime2'].toString() +
                      " - " +
                      dayTime['HtoTime2'].toString())
                  .toString();
              element.showTime = showTime;
              element.showTimeInCard?.add(time);
              print(
                  "Day: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
              print("============================================");
              _temp.add(element);
            }
          }

          ///
        }
      });

      /// daily Happy Hour
      element.day?.forEach((dayTime) {
        showTime = '';
        bool twoDayHHour = false; // for two combine days
        dayOfWeek = DateFormat('EEEE').format(now); // for two combine days

        print("current day is $dayOfWeek");
        int startHour = int.parse(dayTime['HfromTime'].toString() != ""
            ? dayTime['HfromTime'].toString().split(':').first
            : "0");
        String startMinutesString = dayTime['HfromTime'].toString() != ""
            ? dayTime['HfromTime'].toString().split(':')[1]
            : "0";
        int startMinutes = int.parse(startMinutesString.split(' ').first);
        int endHour = int.parse(dayTime['HtoTime'].toString().split(':').first);

        if (dayTime['HfromTime'].toString().contains("PM")) {
          if (startHour != 12) {
            startHour = startHour + 12;
          }
        }
        if (dayTime['HfromTime'].toString().contains("AM")) {
          if (startHour == 12) {
            startHour = 0;
          }
        }
        if (dayTime['HtoTime'].toString().contains("PM")) {
          if (endHour != 12) {
            endHour = endHour + 12;
          }
        }
        if (dayTime['HtoTime'].toString().contains("AM")) {
          if (dayTime['fromTime'].toString().contains("PM")) {
            if (endHour == 12) {
              endHour = 24;
            }
          } else if (endHour == 12) {
            endHour = 0;
          }
        }
        // for two combine day
        if (dayTime['HfromTime'].toString().contains("PM")) {
          if (dayTime['HtoTime'].toString().contains("AM")) {
            DateTime previousDay = now.subtract(const Duration(days: 1));
            String today = DateFormat('EEEE').format(now);
            if (dayOfWeek != dayTime['Hday']) {
              int endHourOnn =
                  int.parse(dayTime['HtoTime'].toString().split(':').first);
              if (endHourOnn > hourOfDay) {
                dayOfWeek = DateFormat('EEEE').format(previousDay);
              }
              if (endHour > hourOfDay) {
                twoDayHHour = true;
              }
            }
            endHour += 24;
          }
        }
        if (dayTime['HfromTime'].toString().contains("AM")) {
          if (dayTime['HtoTime'].toString().contains("AM")) {
            int endHourOnn =
                int.parse(dayTime['HtoTime'].toString().split(':').first);
            print("true");
            if (endHourOnn == 12) {
              endHour = 12;
            }
          }
        }
        //

        double startHourWithMin =
            double.parse(startHour.toString() + "." + startMinutes.toString());
        String minutesString = dayTime['HtoTime'].toString().split(':')[1];
        int minutes = int.parse(minutesString.split(' ').first);
        double endHourWithMin =
            double.parse(endHour.toString() + "." + minutes.toString());
        if (dayTime['Hday'] == dayOfWeek && endHourWithMin > hourOfDay) {
          if (startHourWithMin <= hourOfDay || twoDayHHour) {
            String time = (dayTime['HfromTime'].toString() +
                    dayTime['HtoTime'].toString())
                .toString();
            showTime = (dayTime['HfromTime'].toString() +
                    " - " +
                    dayTime['HtoTime'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);

            print(
                "Day: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
            _temp.add(element);
          } else if (startHour == (now.hour + 1)) {
            String time = (dayTime['HfromTime'].toString() +
                    dayTime['HtoTime'].toString())
                .toString();
            showTime = (dayTime['HfromTime'].toString() +
                    " - " +
                    dayTime['HtoTime'].toString())
                .toString();
            element.showTimeInCard?.add(time);
            element.showTime = showTime;
            _temp.add(element);
            print(
                "Day: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          } else if ((startHourWithMin.toString().split(".").first) ==
              (hourOfDay.toString().split(".").first)) {
            String time = (dayTime['HfromTime'].toString() +
                    dayTime['HtoTime'].toString())
                .toString();
            showTime = (dayTime['HfromTime'].toString() +
                    " - " +
                    dayTime['HtoTime'].toString())
                .toString();
            element.showTime = showTime;
            element.showTimeInCard?.add(time);
            _temp.add(element);
            print(
                "Day: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          }
        } else {
          /// for next day happy hour
          DateTime next = now.add(const Duration(days: 1));
          String nextDay = DateFormat('EEEE').format(next);
          if (dayTime['Hday'] == nextDay && now.hour >= 23) {
            if (startHourWithMin >= 0 && startHourWithMin < 1.1) {
              print("next day condition passed");
              String time = (dayTime['HfromTime'].toString() +
                      dayTime['HtoTime'].toString())
                  .toString();
              showTime = (dayTime['HfromTime'].toString() +
                      " - " +
                      dayTime['HtoTime'].toString())
                  .toString();
              element.showTime = showTime;
              element.showTimeInCard?.add(time);
              print(
                  "Day: Title ${element.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
              print("============================================");
              _temp.add(element);
            }
          }

          ///
        }
      });
    }
    _hoursList.value = [];
    _hoursList.addAll(_temp);
  }

  /// old one
  // newFilter() {
  //   Set<HappyHourModel> _temp = {};
  //   DateTime now = DateTime.now();
  //   String dayOfWeek = DateFormat('EEEE').format(now);
  //   String m = now.hour.toString() + "." + now.minute.toString();
  //   double hourOfDay = double.parse(m);
  //   print("current hour is $hourOfDay");
  //   for (var element in _hoursList) {
  //     /// daily Happy Hour
  //     element.day?.forEach((dayTime) {
  //       print(dayTime['HfromTime'].toString().split(':').first);
  //       int startHour = int.parse(dayTime['HfromTime'].toString() != ""
  //           ? dayTime['HfromTime'].toString().split(':').first
  //           : "0");
  //       String startMinutesString = dayTime['HfromTime'].toString() != ""
  //           ? dayTime['HfromTime'].toString().split(':')[1]
  //           : "0";
  //       int startMinutes = int.parse(startMinutesString.split(' ').first);
  //       int endHour = int.parse(dayTime['HtoTime'].toString().split(':').first);
  //
  //       if (dayTime['HfromTime'].toString().contains("PM")) {
  //         if (startHour != 12) {
  //           startHour = startHour + 12;
  //         }
  //       }
  //       if (dayTime['HfromTime'].toString().contains("AM")) {
  //         if (startHour == 12) {
  //           startHour = 0;
  //         }
  //       }
  //       if (dayTime['HtoTime'].toString().contains("PM")) {
  //         if (endHour != 12) {
  //           endHour = endHour + 12;
  //         }
  //       }
  //       if (dayTime['HtoTime'].toString().contains("AM")) {
  //         if (dayTime['fromTime'].toString().contains("PM")) {
  //           if (endHour == 12) {
  //             endHour = 24;
  //           }
  //         } else if (endHour == 12) {
  //           endHour = 0;
  //         }
  //       }
  //       double startHourWithMin =
  //       double.parse(startHour.toString() + "." + startMinutes.toString());
  //       String minutesString = dayTime['HtoTime'].toString().split(':')[1];
  //       int minutes = int.parse(minutesString.split(' ').first);
  //       double endHourWithMin =
  //       double.parse(endHour.toString() + "." + minutes.toString());
  //       if (dayTime['Hday'] == dayOfWeek && endHourWithMin > hourOfDay) {
  //         if (startHourWithMin <= hourOfDay) {
  //           print(
  //               "HhourTime 1 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time = (dayTime['HfromTime'].toString() +
  //               dayTime['HtoTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if (startHour == (now.hour + 1)) {
  //           print(
  //               "condition 2 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time = (dayTime['HfromTime'].toString() +
  //               dayTime['HtoTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if ((startHourWithMin.toString().split(".").first) ==
  //             (hourOfDay.toString().split(".").first)) {
  //           print("condition 3 this run for $startHourWithMin");
  //           String time = (dayTime['HfromTime'].toString() +
  //               dayTime['HtoTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         }
  //       }
  //     });
  //
  //     /// *******************************///
  //     /// dailyLate Happy Hour
  //     element.dayLate?.forEach((dayTime) {
  //       print(dayTime['HfromTime2'].toString().split(':').first);
  //       int startHour = int.parse(dayTime['HfromTime2'].toString() != ""
  //           ? dayTime['HfromTime2'].toString().split(':').first
  //           : "0");
  //       String startMinutesString = dayTime['HfromTime2'].toString() != ""
  //           ? dayTime['HfromTime2'].toString().split(':')[1]
  //           : "0";
  //       int startMinutes = int.parse(startMinutesString.split(' ').first);
  //       int endHour =
  //       int.parse(dayTime['HtoTime2'].toString().split(':').first);
  //
  //       if (dayTime['HfromTime2'].toString().contains("PM")) {
  //         if (startHour != 12) {
  //           startHour = startHour + 12;
  //         }
  //       }
  //       if (dayTime['HfromTime2'].toString().contains("AM")) {
  //         if (startHour == 12) {
  //           startHour = 0;
  //         }
  //       }
  //       if (dayTime['HtoTime2'].toString().contains("PM")) {
  //         if (endHour != 12) {
  //           endHour = endHour + 12;
  //         }
  //       }
  //       if (dayTime['HtoTime2'].toString().contains("AM")) {
  //         if (dayTime['fromTime2'].toString().contains("PM")) {
  //           if (endHour == 12) {
  //             endHour = 24;
  //           }
  //         } else if (endHour == 12) {
  //           endHour = 0;
  //         }
  //       }
  //       double startHourWithMin =
  //       double.parse(startHour.toString() + "." + startMinutes.toString());
  //       String minutesString = dayTime['HtoTime2'].toString().split(':')[1];
  //       int minutes = int.parse(minutesString.split(' ').first);
  //       double endHourWithMin =
  //       double.parse(endHour.toString() + "." + minutes.toString());
  //       if (dayTime['Hday2'] == dayOfWeek && endHourWithMin > hourOfDay) {
  //         if (startHourWithMin <= hourOfDay) {
  //           print(
  //               "HHour2 1 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time = (dayTime['HfromTime2'].toString() +
  //               dayTime['HtoTime2'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if (startHour == (now.hour + 1)) {
  //           print(
  //               "condition 2 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time = (dayTime['HfromTime2'].toString() +
  //               dayTime['HtoTime2'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if ((startHourWithMin.toString().split(".").first) ==
  //             (hourOfDay.toString().split(".").first)) {
  //           print("condition 3 this run for $startHourWithMin");
  //           String time = (dayTime['HfromTime2'].toString() +
  //               dayTime['HtoTime2'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         }
  //       }
  //     });
  //
  //     /// *******************************///
  //     /// dailySpecial Happy Hour
  //     element.dailySpecils?.forEach((dayTime) {
  //       print(dayTime['fromTime'].toString().split(':').first);
  //       int startHour = int.parse(dayTime['fromTime'].toString() != ""
  //           ? dayTime['fromTime'].toString().split(':').first
  //           : "0");
  //       String startMinutesString = dayTime['fromTime'].toString() != ""
  //           ? dayTime['fromTime'].toString().split(':')[1]
  //           : "0";
  //       int startMinutes = int.parse(startMinutesString.split(' ').first);
  //       int endHour = int.parse(dayTime['toTime'].toString().split(':').first);
  //
  //       if (dayTime['fromTime'].toString().contains("PM")) {
  //         if (startHour != 12) {
  //           startHour = startHour + 12;
  //         }
  //       }
  //       if (dayTime['fromTime'].toString().contains("AM")) {
  //         if (startHour == 12) {
  //           startHour = 0;
  //         }
  //       }
  //       if (dayTime['toTime'].toString().contains("PM")) {
  //         if (endHour != 12) {
  //           endHour = endHour + 12;
  //         }
  //       }
  //       if (dayTime['toTime'].toString().contains("AM")) {
  //         if (dayTime['fromTime'].toString().contains("PM")) {
  //           if (endHour == 12) {
  //             endHour = 24;
  //           }
  //         } else if (endHour == 12) {
  //           endHour = 0;
  //         }
  //       }
  //       double startHourWithMin =
  //       double.parse(startHour.toString() + "." + startMinutes.toString());
  //       String minutesString = dayTime['toTime'].toString().split(':')[1];
  //       int minutes = int.parse(minutesString.split(' ').first);
  //       double endHourWithMin =
  //       double.parse(endHour.toString() + "." + minutes.toString());
  //       if (dayTime['day'] == dayOfWeek && endHourWithMin > hourOfDay) {
  //         if (startHourWithMin <= hourOfDay) {
  //           print(
  //               "Special 1 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time =
  //           (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if (startHour == (now.hour + 1)) {
  //           print(
  //               "condition 2 start time is $startHourWithMin end time is $endHourWithMin");
  //           String time =
  //           (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         } else if ((startHourWithMin.toString().split(".").first) ==
  //             (hourOfDay.toString().split(".").first)) {
  //           print("condition 3 this run for $startHourWithMin");
  //           String time =
  //           (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
  //               .toString();
  //           element.showTimeInCard?.add(time);
  //           _temp.add(element);
  //         }
  //       }
  //     });
  //   }
  //   _hoursList.value = [];
  //   _hoursList.addAll(_temp);
  // }
  // filterStartingWithinHour() {
  //   List<String> hourDuration = [];
  //   Set<String> times = {};
  //   Set hourIndicies = {};
  //   Set<String> dailytimes = {};
  //   Set<String> daytimes = {};
  //   Set<String> dayLateTimes = {};
  //   List<MapModel> hourMaps = [];
  //   Set<HappyHourModel> _temp = {};
  //   Set<String> freeHours = {};
  //   Set<String> freeAmsOrPms = {};
  //
  //   DateTime now = DateTime.now();
  //   String dayOfWeek = DateFormat('EEEE').format(now);
  //
  //   for (int minute = 0; minute < 60; minute++) {
  //     DateTime time = DateTime(now.year, now.month, now.day, now.hour-1,
  //         now.minute + minute, now.second);
  //     String formattedDate = DateFormat("hh:mm a").format(time);
  //     freeHours.add(formattedDate.split(':')[0].toLowerCase());
  //     freeAmsOrPms.add(formattedDate.split(' ')[1].toLowerCase());
  //     hourDuration.add(formattedDate.toString().trim().toLowerCase());
  //
  //   }
  //   print(hourDuration);
  //   for (int minute = 0; minute < 60; minute++) {
  //     DateTime time = DateTime(now.year, now.month, now.day, now.hour,
  //         now.minute + minute, now.second);
  //     String formattedDate = DateFormat("hh:mm a").format(time);
  //     freeHours.add(formattedDate.split(':')[0].toLowerCase());
  //     freeAmsOrPms.add(formattedDate.split(' ')[1].toLowerCase());
  //     hourDuration.add(formattedDate.toString().trim().toLowerCase());
  //   }
  //
  //   for (int hourIndex = 0; hourIndex < _hoursList.length; hourIndex++) {
  //     times = {};
  //
  //     if (_hoursList[hourIndex].dailySpecils != null &&
  //         _hoursList[hourIndex].dailySpecils!.isNotEmpty) {
  //       dailytimes = {};
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //       active < _hoursList[hourIndex].dailySpecils!.length;
  //       active++) {
  //         if (dayOfWeek.toLowerCase() ==
  //             _hoursList[hourIndex]
  //                 .dailySpecils![active]['day']
  //                 .toString()
  //                 .toLowerCase()) {
  //
  //           dailytimes.add(_hoursList[hourIndex]
  //               .dailySpecils![active]['fromTime']
  //               .toString()
  //               .trim()
  //               .toLowerCase());
  //         }
  //
  //       }
  //       if(dailytimes.isNotEmpty){
  //         times.addAll(dailytimes);
  //       }
  //     }
  //
  //     if (_hoursList[hourIndex].day != null &&
  //         _hoursList[hourIndex].day!.isNotEmpty) {
  //       daytimes = {};
  //       hourIndicies.add(hourIndex);
  //
  //       for (int active = 0;
  //       active < _hoursList[hourIndex].day!.length;
  //       active++) {
  //         if(_hoursList[hourIndex]
  //             .day![active]['Hday'].toString().toLowerCase() == dayOfWeek.toLowerCase()){
  //           daytimes.add(_hoursList[hourIndex]
  //               .day![active]['HfromTime']
  //               .toString()
  //               .trim()
  //               .toLowerCase());
  //         }
  //
  //       }
  //       if(daytimes.isNotEmpty){
  //         times.addAll(daytimes);
  //       }
  //
  //
  //     }
  //
  //     if (_hoursList[hourIndex].dayLate != null &&
  //         _hoursList[hourIndex].dayLate!.isNotEmpty) {
  //       dayLateTimes = {};
  //
  //       for (int active = 0;
  //       active < _hoursList[hourIndex].dayLate!.length;
  //       active++) {
  //         if(_hoursList[hourIndex]
  //             .dayLate![active]['Hday2'].toString().toLowerCase() == dayOfWeek.toLowerCase()){
  //           dayLateTimes.add(_hoursList[hourIndex]
  //               .dayLate![active]['HfromTime2']
  //               .toString()
  //               .trim()
  //               .toLowerCase());
  //         }
  //
  //       }
  //       if(dayLateTimes.isNotEmpty){
  //         times.addAll(dayLateTimes);
  //       }
  //     }
  //   print("times----- $times");
  //     hourMaps.add(MapModel(
  //         hourIndex: hourIndex,
  //         times: times.map((e) => e.toString().toLowerCase()).toList()));
  //   }
  //   _temp = {};
  //
  //   print('_temp.length: ${_temp.length}');
  //
  //   for (var hourMap in hourMaps) {
  //     /// remove am or pm. let say if times contains 3 AM and 3PM. and time is 3 PM then it will remove 3AM
  //     hourMap.times.removeWhere((element) =>
  //     !(freeAmsOrPms.contains(element.split(' ')[1].toLowerCase())));
  //   }
  //
  //   for (var hourMap in hourMaps) {
  //     /// remove times with hours not in duration within 1hour.
  //     hourMap.times.removeWhere(
  //             (element) => !(freeHours.contains(element.split(':')[0])));
  //   }
  //
  //   /// pick the hours....
  //   skip:
  //   for (var hourMap in hourMaps) {
  //     for (int i = 0; i < hourMap.times.length; i++) {
  //       String time = hourMap.times[i];
  //       if (hourDuration.contains(time.toString().trim().toLowerCase())) {
  //         _temp.add(_hoursList[hourMap.hourIndex]);
  //         continue skip;
  //       }
  //     }
  //   }
  //   print('_hoursList.length: ${_hoursList.length}');
  //
  //   _hoursList.value = [];
  //   _hoursList.value = _temp.toList();
  // }

  @override
  void onInit() {
    fetchHours();
    super.onInit();
  }

  void _launchURL(url) async {
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      Get.find<GlobalGeneralController>().errorSnackbar(
        title: "Error",
        description: 'Could not launch $url',
      );
    }
  }

  int count = 500;

  int? countNew;

  Future<void> viewCount(hourId) async {
    countNew = Random().nextInt(count);

    update();
    await _addReviewProvider.addCountOnHappyHour(
        hourId: hourId, count: countNew!);
  }

  onDirectionTap(uri) {
    _launchURL(Uri.parse(uri));
  }
  //
  // bool checkNotInList(String? id) {
  //   bool found = false;
  //   if (_temp.isNotEmpty) {
  //     for (int i = 0; i < _temp.length; i++) {
  //       if (_temp[i].id?.toLowerCase() == id?.toLowerCase()) {
  //         found = true;
  //         break;
  //       }
  //     }
  //   }
  //   return found;
  // }
}

class MapModel {
  int hourIndex;
  List<String> times;
  MapModel({required this.hourIndex, required this.times});

  toMap() {
    return {'hourIndex': hourIndex, 'times': times};
  }
}


