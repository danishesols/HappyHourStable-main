import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/data/models/hour_favorite_model.dart';
import 'package:happy_hour_app/global_widgets/hour_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';
import 'package:intl/intl.dart';

import '../core/colors.dart';
import '../global_controller/auth_controller.dart';
import '../global_controller/global_general_controller.dart';

class HoursListGenerator extends StatefulWidget {
  const HoursListGenerator({
    Key? key,
    required this.query,
    this.showUnfavoriteButton = false,
    this.showAllHours = false,
  }) : super(key: key);

  final Query<HoursFavoriteModel> query;
  final bool showUnfavoriteButton;
  final bool showAllHours;

  @override
  State<HoursListGenerator> createState() => _HoursListGeneratorState();
}

class _HoursListGeneratorState extends State<HoursListGenerator> {
  String showTime = '';
  getTime(HoursFavoriteModel hoursFavoriteModel) {
    showTime = '';
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('EEEE').format(now);
    String m = now.hour.toString() + "." + now.minute.toString();
    double hourOfDay = double.parse(m);
    /// *******************************///
    /// dailySpecial Happy Hour
    hoursFavoriteModel.dailySpecils?.forEach((dayTime) {
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

          print(
              "dailySpecils: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
          print("============================================");
        } else if (startHour == (now.hour + 1)) {
          String time =
          (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
              .toString();
          showTime = (dayTime['fromTime'].toString() +
              " - " +
              dayTime['toTime'].toString())
              .toString();
          print(
              "dailySpecils: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
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

          print(
              "dailySpecils: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
          print("============================================");
        }
      } else {
        /// for next day happy hour
        DateTime next = now.add(const Duration(days: 1));
        String nextDay = DateFormat('EEEE').format(next);
        if (dayTime['day'] == nextDay && now.hour >= 23) {
          if (startHourWithMin >= 0 && startHourWithMin < 1.1) {
            print("next day condition passed");
            String time =
            (dayTime['fromTime'].toString() + dayTime['toTime'].toString())
                .toString();
            showTime = (dayTime['fromTime'].toString() +
                " - " +
                dayTime['toTime'].toString())
                .toString();

            print(
                "dayLate: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          }
        }

        ///
      }
    });

    hoursFavoriteModel.dayLate?.forEach((dayTime) {
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
      int endHour = int.parse(dayTime['HtoTime2'].toString().split(':').first);

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

          print(
              "Day Late: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
          print("============================================");
        } else if (startHour == (now.hour + 1)) {
          String time = (dayTime['HfromTime2'].toString() +
                  dayTime['HtoTime2'].toString())
              .toString();
          showTime = (dayTime['HfromTime2'].toString() +
                  " - " +
                  dayTime['HtoTime2'].toString())
              .toString();

          print(
              "Day late: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
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

          print(
              "Day late: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
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
            print(
                "Day: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin");
            print("============================================");
          }
        }
        ///
      }
    });
    /// daily Happy Hour
    hoursFavoriteModel.day?.forEach((dayTime) {
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
          String time =
              (dayTime['HfromTime'].toString() + dayTime['HtoTime'].toString())
                  .toString();
          showTime = (dayTime['HfromTime'].toString() +
                  " - " +
                  dayTime['HtoTime'].toString())
              .toString();
          print(showTime);
          print(
              "Day: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin daily happy hour");
          print("============================================");
        } else if (startHour == (now.hour + 1)) {
          String time =
              (dayTime['HfromTime'].toString() + dayTime['HtoTime'].toString())
                  .toString();
          showTime = (dayTime['HfromTime'].toString() +
                  " - " +
                  dayTime['HtoTime'].toString())
              .toString();
          print(showTime);
          print(
              "Day: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin daily happy hour");
          print("============================================");
        } else if ((startHourWithMin.toString().split(".").first) ==
            (hourOfDay.toString().split(".").first)) {
          String time =
              (dayTime['HfromTime'].toString() + dayTime['HtoTime'].toString())
                  .toString();
          showTime = (dayTime['HfromTime'].toString() +
                  " - " +
                  dayTime['HtoTime'].toString())
              .toString();

          print(
              "Day: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin daily happy hour");
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
            print("Day: Title ${hoursFavoriteModel.businessName} \n Start Time is $startHourWithMin end Time is $endHourWithMin daily happy hour");
            print("============================================");
          }
        }
        ///
      }
    });
    print("timeeee $showTime");

    if(showTime != "") {
      return showTime;
    } else{
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<HoursFavoriteModel>(
      query: widget.query,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, snapshot) {
        HoursFavoriteModel hoursFavoriteModel = snapshot.data();
        HourCard hourCard = HourCard(
          name: hoursFavoriteModel.businessName,
          menuImage: hoursFavoriteModel.menuImage,
          description: hoursFavoriteModel.description,
          businessAddress: hoursFavoriteModel.businessAddress,
          time: getTime(hoursFavoriteModel),
          star: RatingBarIndicator(
            unratedColor: Colors.grey.shade300,
            direction: Axis.horizontal,
            rating: 5,
            //rating: hoursFavoriteModel.reviewList?[0]["stars"] ?? 0,
            itemCount: 5,
            itemSize: 20,
            itemBuilder: (context, index) => Image.asset(
              "assets/icons/Path 602@2x.png",
              height: 7,
              width: 10,
              color: primary,
            ),
          ),
          favourite: FavoriteButton(
            cardPadding: 10,
            size: 40,
            hoursFavoriteModel: hoursFavoriteModel,
          ),
          onTap: () {
            Get.toNamed(Routes.favoriteDetailScreen,
                arguments: hoursFavoriteModel);
            // Get.find<GlobalGeneralController>().onHourTap(
            //   hoursFavoriteModel: hoursFavoriteModel,
            // );
          },
          icon: widget.showUnfavoriteButton
              ? UnFavoriteButton(hoursFavoriteModel: hoursFavoriteModel)
              : FavoriteButton(hoursFavoriteModel: hoursFavoriteModel),
        );
        if (widget.showAllHours) {
          return hourCard;
        }
        return hourCard;
      },
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.hoursFavoriteModel,
    this.size,
    this.cardPadding,
  }) : super(key: key);

  final HoursFavoriteModel hoursFavoriteModel;
  final double? size;
  final double? cardPadding;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => CardIcon(
        icon: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid)
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        cardPadding: cardPadding ?? 6.0,
        size: size ?? 12,
        color: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid)
            ? primary
            : Colors.black,
        onTap: () {
          // print("${hoursFavoriteModel.hid}==============hourid");
          // print("${Get.find<AuthController>().user.uid}==============userid");
          // print(Get.find<AuthController>()
          //     .user
          //     .favoriteHours
          //     .contains(hoursFavoriteModel.hid));
          Get.find<GlobalGeneralController>().changeHourFavoriteStatus(
            hourId: hoursFavoriteModel.hid,
            //letter it will be replace with  hoursFavoriteModel.hid,  "lkGGGmjXs7CZF0oUxmR4"
            //hourId: hoursFavoriteModel.hid,
            userId: Get.find<AuthController>().user.uid,
            previousState: Get.find<AuthController>()
                .user
                .favoriteHours
                .contains(hoursFavoriteModel.hid),
          );
        },
      ),
    );
  }
}

class UnFavoriteButton extends StatelessWidget {
  const UnFavoriteButton({
    Key? key,
    required this.hoursFavoriteModel,
  }) : super(key: key);

  final HoursFavoriteModel hoursFavoriteModel;

  @override
  Widget build(BuildContext context) {
    return CardIcon(
      icon: FontAwesomeIcons.solidCircleXmark,
      cardPadding: 0.0,
      size: 30,
      color: primary,
      onTap: () {
        Get.find<GlobalGeneralController>().changeHourFavoriteStatus(
          hourId: hoursFavoriteModel.hid,
          userId: Get.find<AuthController>().user.uid,
          previousState: Get.find<AuthController>()
              .user
              .favoriteHours
              .contains(hoursFavoriteModel.hid),
        );
      },
    );
  }
}

class CardIcon extends StatelessWidget {
  const CardIcon({
    Key? key,
    required this.icon,
    this.color,
    this.size,
    this.onTap,
    this.cardPadding,
  }) : super(key: key);

  final IconData icon;
  final Color? color;
  final double? size;
  final void Function()? onTap;
  final double? cardPadding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5.0,
        child: Padding(
          padding: EdgeInsets.all(cardPadding ?? 10.0),
          child: FaIcon(
            icon,
            color: color ?? Colors.black,
            size: size,
          ),
        ),
      ),
    );
  }
}
