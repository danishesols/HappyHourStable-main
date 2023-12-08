// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import '../screens/account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';
// import 'global_general_controller.dart';
//
// class CurrentLocationController{
//
//   static LocationPermissionStatus locationPermissionStatus =
//       LocationPermissionStatus.nullStatus;
//
//   static Future<bool> handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//
//     if (!serviceEnabled) {
//       Get.find<GlobalGeneralController>().errorSnackbar(
//           title: "Enable Location",
//           description:
//           "Location services are disabled. Please enable the services");
//       return false;
//     } else {
//       locationPermissionStatus = LocationPermissionStatus.enabled;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       locationPermissionStatus = LocationPermissionStatus.denied;
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         Get.find<GlobalGeneralController>().errorSnackbar(
//             title: "Enable Location",
//             description: "Location permissions are denied");
//         locationPermissionStatus = LocationPermissionStatus.denied;
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       locationPermissionStatus = LocationPermissionStatus.deniedForever;
//
//       Get.find<GlobalGeneralController>().errorSnackbar(
//           title: "Enable Location Manually",
//           description:
//           "Location permissions are permanently denied, we cannot request permissions.");
//       bool isAllowed = await openAppSettings();
//       return isAllowed;
//     }
//     locationPermissionStatus = LocationPermissionStatus.enabled;
//     return true;
//   }
//
//   static Future<Position?> getCurrentPosition() async {
//     final hasPermission = await handleLocationPermission();
//     if (!hasPermission) {
//
//       return null;
//     }
//     Position currentLoc = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     return currentLoc;
//   }
//   static Future<void> init() async{
//     Position? currentLoc = await getCurrentPosition();
//     if(currentLoc != null){
//       latitude = currentLoc.latitude;
//       longitude = currentLoc.longitude;
//     }
//     print('i have user current location now:-------');
//   }
// static double? latitude;
//  static  double?longitude;
// }
//
