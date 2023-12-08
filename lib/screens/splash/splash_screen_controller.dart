import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:happy_hour_app/global_controller/auth_controller.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../../core/constants.dart';

class SplashController extends GetxController {
  // * instances
  final box = GetStorage();

  @override
  Future<void> onInit() async {
    // * wait for 2 seconds and then move to next screen.
   await Future.delayed(
      const Duration(seconds: 4),
      () async {
        final _isTrue = box.read(showstartedScreen);
        if (_isTrue) {
          await box.write(showstartedScreen, false);
          await Get.offNamed(Routes.startedScreen);
        }
        // * and if this is false then move to get started screens.
        else {
          // * and if this is true then move to get business Account screens.
          if (Get.find<AuthController>().user.isBusiness &&
              box.read(loginRememberMeStatus)) {
            await Get.offNamed(Routes.businessAccountHomeScreen);
          } else if (Get.find<AuthController>().user.isBusiness) {
            await Get.offNamed(Routes.businessAccountHomeScreen);
          }
          // * and if this is true then move to get Standard Account screens.
          else if (!Get.find<AuthController>().user.isBusiness &&
              box.read(loginRememberMeStatus)) {
            await Get.offNamed(Routes.loginHomeScreen);
          } else {
            _isTrue
                ? await Get.offNamed(Routes.startedScreen)
                : await Get.offNamed(Routes.homeScreen);
          }
        }
        Get.delete<SplashController>();
      },
    );

    // Future.delayed(
    //   const Duration(seconds: 3),
    //   () async {
    //    // Get.offNamed(Routes.startedScreen);
    //     //Get.toNamed("/NextScreen");
    //     final _isTrue = box.read(showIntroScreens);

    //     if (_isTrue) {
    //       Get.offNamed(Routes.startedScreen);
    //       box.write(showIntroScreens, false);
    //     }
    //     // * and if this is false then move to get started screens.
    //     else {
    //       if (box.read(loginRememberMeStatus)) {
    //         Get.offNamed(Routes.homeScreen);
    //       } else {
    //         Get.offNamed(Routes.startedScreen);
    //       }
    //     }

    //     Get.delete<SplashController>();
    //   },
    // );
    super.onInit();
  }
}

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:happy_hour_app/global_controller/auth_controller.dart';
// import 'package:happy_hour_app/routes/app_routes.dart';

// import '../../core/constants.dart';

// class SplashController extends GetxController {
//   // * instances
//   final box = GetStorage();

//   @override
//   void onInit() {
//     // * wait for 2 seconds and then move to next screen.
//     Future.delayed(
//       const Duration(seconds: 2),
//       () async {
//         final _isTrue = box.read(showstartedScreen);

//         if (_isTrue) {
//           Get.offNamed(Routes.startedScreen);
//           box.write(showstartedScreen, false);
//         }
//         // * and if this is false then move to get started screens.
//         else {
//           // * and if this is true then move to get business Account screens.
//           if (box.read(loginRememberMeStatus) &&
//               Get.find<AuthController>().user.isBusiness) {
//             await Get.offNamed(Routes.businessAccountHomeScreen);
//           }
//           // * and if this is true then move to get Standard Account screens.
//           else if (box.read(loginRememberMeStatus) &&
//               !Get.find<AuthController>().user.isBusiness) {
//             await Get.offNamed(Routes.loginHomeScreen);
//           } else {
//             await Get.offNamed(Routes.startedScreen);
//           }
//         }

//         Get.delete<SplashController>();
//       },
//     );

//     // Future.delayed(
//     //   const Duration(seconds: 3),
//     //   () async {
//     //    // Get.offNamed(Routes.startedScreen);
//     //     //Get.toNamed("/NextScreen");
//     //     final _isTrue = box.read(showIntroScreens);

//     //     if (_isTrue) {
//     //       Get.offNamed(Routes.startedScreen);
//     //       box.write(showIntroScreens, false);
//     //     }
//     //     // * and if this is false then move to get started screens.
//     //     else {
//     //       if (box.read(loginRememberMeStatus)) {
//     //         Get.offNamed(Routes.homeScreen);
//     //       } else {
//     //         Get.offNamed(Routes.startedScreen);
//     //       }
//     //     }

//     //     Get.delete<SplashController>();
//     //   },
//     // );
//     super.onInit();
//   }
// }
