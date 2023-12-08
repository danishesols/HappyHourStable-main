import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/data/providers/favorite_provider.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/global_widgets/exit_app.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/global_widgets/text_field.dart';
import 'package:intl/intl.dart';
import '../data/models/hour_favorite_model.dart';

class GlobalGeneralController extends GetxController {
  final FavoriteProvider _favoriteProvider = FavoriteProvider();

  errorSnackbar({
    required String title,
    required String description,
  }) {
    Get.snackbar(
      title,
      description,
      overlayBlur: 1,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.error, color: Colors.red),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      duration: const Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  infoSnackbar({
    required String title,
    required String description,
  }) async {
    Get.snackbar(
      title,
      description,
      overlayBlur: 1,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.info, color: primary),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      duration: const Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  successSnackbar({
    required String title,
    required String description,
  }) {
    Get.snackbar(
      title,
      description,
      overlayBlur: 1,
      snackPosition: SnackPosition.TOP,
      icon: const Icon(Icons.check, color: Colors.green),
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      duration: const Duration(seconds: 5),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  // toastMessage({required message}) {
  //   return Fluttertoast.showToast(
  //       msg: message,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.CENTER,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.white,
  //       textColor: Colors.red,
  //       fontSize: 16.0);
  // }

  String convertTimeStampToDate(date) {
    return DateFormat().format(
      DateTime.fromMillisecondsSinceEpoch(
        // * convert received timestamp's seconds to milliseconds by multiply it by 1000.
        date.seconds * 1000,
      ),
    );
  }

  // double? lat;
  // double? long;

  //  getlocation() async {
  //   Position currentLoc = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //
  //   long = currentLoc.longitude;
  //   lat = currentLoc.latitude;
  //   update();
  // }

  @override
  Future<void> onInit() async {
    // await getlocation();

    super.onInit();
  }

  // * General methods used throughtout the app.

  //*favorite hour going to next screen is comented will be confirm to goto new screen
  onHourTap({required HoursFavoriteModel hoursFavoriteModel}) {
    _favoriteProvider.getHour(hourId: hoursFavoriteModel.hid).listen(
      (doc) {
        // HourModel hourModel = HourModel.fromDocument(doc);
        // Get.toNamed(
        //   Routes.favoriteDetailScreen,
        //   arguments: [hourModel, hoursFavoriteModel],
        // );
        // HoursFavoriteModel hourFavoriteModel =
        //     HoursFavoriteModel.fromJson(doc);
        // Get.toNamed(
        //   Routes.favoriteDetailScreen,
        //   arguments: [hourFavoriteModel, hoursFavoriteModel],
        // );
      },
    );
  }

  // * update the favorite property of Hour card when user click on favorite icon of it.
  changeHourFavoriteStatus({
    required String hourId,
    required String userId,
    required bool previousState,
  }) async {
    _favoriteProvider.changeHourFavoriteStatus(
      hourId: hourId,
      userId: Get.find<AuthController>().user.uid,
      previousState: previousState,
    );
  }

  Future<dynamic> dialogueCard(
    BuildContext context,
    String title,
    String middleText,
    String buttonText,
    VoidCallback onConfrim,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/Group 2062.png"),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: H * 0.01,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.04,
              ),
              Center(
                child: Text(
                  middleText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: H * 0.06,
              ),
              Center(
                child: CustomElevatedButtonWidget(
                  horizontalPadding: 60,
                  verticalPadding: 22,
                  borderRadius: 35,
                  fontSize: 24,
                  textColor: blackColor,
                  text: (buttonText),
                  onPressed: onConfrim,
                ),
              ),
              SizedBox(height: H * 0.03),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> addNewItemDialog(
    BuildContext context,
    String title,
    VoidCallback onConfrim,
    Widget widget,
    Widget addButton,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.45,
            width: W * 0.9,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/icons/Group 2062.png"),
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    height: H * 0.01,
                  ),
                  Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: H * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Center(child: widget),
                  ),
                  SizedBox(
                    height: H * 0.02,
                  ),
                  Center(
                    child: addButton,
                  ),
                  SizedBox(
                    height: H * 0.01,
                  ),
                  Center(
                    child: TextButton(
                        onPressed: onConfrim,
                        child: const Text(
                          "+ Add Manually",
                          style: TextStyle(color: primary),
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> addNewItemManualyyDialog(
    BuildContext context,
    String title,
    VoidCallback onConfrim,
    TextEditingController textController,
  ) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: SizedBox(
            height: H * 0.4,
            width: W * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16.0),
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/icons/Group 2062.png"),
                        ),
                      ),
                    ),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: H * 0.01,
                ),
                Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(
                  height: H * 0.04,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: CustomTextFieldWidget(
                    hintText: "Item Name",
                    textEditingController: textController,
                  ),
                ),
                SizedBox(
                  height: H * 0.04,
                ),
                Center(
                  child: CustomElevatedButtonWidget(
                      horizontalPadding: 60,
                      verticalPadding: 22,
                      borderRadius: 35,
                      fontSize: 24,
                      textColor: blackColor,
                      text: ("Add"),
                      onPressed: () {}),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> favoriteCard(
    BuildContext context,
    String title,
    String middleText,
    String buttonText,
    VoidCallback onConfrim,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: H * 0.05,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.04,
              ),
              Center(
                child: Text(
                  middleText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: H * 0.06,
              ),
              Center(
                child: CustomElevatedButtonWidget(
                  horizontalPadding: 50,
                  verticalPadding: 18,
                  borderRadius: 35,
                  fontSize: 20,
                  textColor: blackColor,
                  text: (buttonText),
                  onPressed: onConfrim,
                ),
              ),
              SizedBox(height: H * 0.03),
            ],
          ),
        );
      },
    );
  }

  Future<dynamic> upgradeAccountDialog(
    BuildContext context,
    String title,
    String middleText,
    String buttonText,
    VoidCallback onConfrim,
    // String buttonText2,
    // VoidCallback onConfrim2,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: H * 0.05,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.04,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    middleText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.03,
              ),
              Center(
                child: CustomElevatedButtonWidget(
                  horizontalPadding: 30,
                  verticalPadding: 20,
                  borderRadius: 35,
                  fontSize: 16,
                  textColor: blackColor,
                  text: (buttonText),
                  onPressed: onConfrim,
                ),
              ),
              SizedBox(
                height: H * 0.03,
              ),
              // Center(
              //   child: CustomElevatedButtonWidget(
              //     horizontalPadding: 60,
              //     verticalPadding: 20,
              //     borderRadius: 35,
              //     fontSize: 16,
              //     textColor: blackColor,
              //     text: (buttonText2),
              //     onPressed: onConfrim2,
              //   ),
              // ),
              // SizedBox(height: H * 0.03),
            ],
          ),
        );
      },
    );
  }
  Future<dynamic> yesOrNoDialog(
    BuildContext context,
    String title,
    String middleText,
    String buttonText,
    VoidCallback onConfrim,
    String buttonText2,
    VoidCallback onConfrim2,
  ) {
    return showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: H * 0.05,
              ),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.04,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    middleText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              SizedBox(
                height: H * 0.03,
              ),
              Center(
                child: CustomElevatedButtonWidget(
                  horizontalPadding: 60,
                  verticalPadding: 20,
                  borderRadius: 35,
                  fontSize: 16,
                  textColor: blackColor,
                  text: (buttonText),
                  onPressed: onConfrim,
                ),
              ),
              SizedBox(
                height: H * 0.03,
              ),
              Center(
                child: CustomElevatedButtonWidget(
                  horizontalPadding: 60,
                  verticalPadding: 20,
                  borderRadius: 35,
                  fontSize: 16,
                  textColor: blackColor,
                  text: (buttonText2),
                  onPressed: onConfrim2,
                ),
              ),
              SizedBox(height: H * 0.03),
            ],
          ),
        );
      },
    );
  }

  bool isDialogShowing = true;
  showProgressDialog(
      {BuildContext? context, bool? barrierDismissal, Color? color}) {
    isDialogShowing = true;
    showDialog(
        useRootNavigator: false,
        useSafeArea: false,
        barrierDismissible: barrierDismissal ?? false,
        context: context!,
        builder: (context) => Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.transparent,
                      spreadRadius: 5,
                      blurRadius: 5,
                      offset: Offset(3, 5), // changes position of shadow
                    ),
                  ],
                ),
                height: 120,
                width: 120,
                child: Center(
                  child: SpinKitCircle(
                    color: color ?? primary,
                    size: 50.0,
                  ),
                ),
              ),
            )).then((value) {
      isDialogShowing = false;
    });
  }

  static Future<bool> checkInternetConnectivity() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        } else {
          return false;
        }
      } on SocketException catch (_) {
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return false;
    }
  }

  Future<bool> onWillPop(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ExitAppDialog(
              description: 'Do you really want to quit?',
              leftButtonText: 'Cancel',
              rightButtonText: 'OK',
              onAgreeTap: () {
                SystemNavigator.pop();
              });
        });
    return false;
  }


// Center spinner({Color? color}) {
//   return Center(
//     child: SpinKitCircle(
//       color: color ?? primary,
//       size: 50.0,
//     ),
//   );
// }

}
