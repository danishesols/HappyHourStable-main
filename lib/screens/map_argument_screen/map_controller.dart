// ignore_for_file: prefer_typing_uninitialized_variables, unnecessary_null_comparison

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../core/constants.dart';
import '../../global_controller/auth_controller.dart';
import '../../global_controller/global_general_controller.dart';
import '../../routes/app_routes.dart';
import '../account_standard/standard_find_your_happyhour/find_your_happyhour_standard_controller.dart';

class MapController extends GetxController {
  final List hours = Get.arguments;
  // final Completer<GoogleMap> complete = Completer();
  late Uint8List mapMarkerStandard;
  late Uint8List mapMarkerBusiness;

  double? latitude;
  double? longitude;
  var locationPermissionStatus;
  CameraPosition? defaultCameraPosition;
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
      var locationPermissionStatus = LocationPermissionStatus.enabled;
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
      return null;
    }
    Position currentLoc = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return currentLoc;
  }

  Position? currentLoc;
  @override
  Future<void> onInit() async {
    super.onInit();

    Future.microtask(() async {
      currentLoc = await getCurrentPosition();
      if (currentLoc != null) {
        latitude = currentLoc?.latitude;
        longitude = currentLoc?.longitude;
        defaultCameraPosition = CameraPosition(
          target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
          //zoom: 12.5,
          zoom: 10,
        );
        update();
      }
    });

    // final ByteData standard =
    //     await rootBundle.load('assets/icons/Group 11720.png');
    // mapMarkerStandard = standard.buffer.asUint8List();
    final ByteData standard =
        await rootBundle.load('assets/icons/black-dot.png');
    mapMarkerStandard = standard.buffer.asUint8List();

    final ByteData business =
        await rootBundle.load('assets/icons/Group 11720.png');
    mapMarkerBusiness = business.buffer.asUint8List();
    // mapMarkerStandard =
    //     await getBytesFromAsset('assets/icons/Group 8550.png', 100);
    // mapMarkerBusiness = await getBytesFromAsset('assets/icons/map.png', 120);
  }

  // * observable variables
  final _markers = <Marker>{}.obs;
  // ignore: invalid_use_of_protected_member
  get markers => _markers.value;
  set addMarker(value) => _markers.add(value);

  onMapCreated(GoogleMapController controller) async {
    currentLoc = await getCurrentPosition();

    for (final hour in Get.arguments) {
      addMarker = Marker(
        markerId: MarkerId(hour.businessName.toString()),
        infoWindow: InfoWindow(
            onTap: () async {
              final box = GetStorage();
              if (box.read("islogin")==true) {
                await Get.toNamed(Routes.businessHappyHourDetailScreen,
                    arguments: hour);
              }else {
                await Get.toNamed(Routes.happyHourDetailScreen, arguments: hour);
              }
             
            },
            title: hour.businessName,
            snippet: hour.businessName,
            anchor: const ui.Offset(0.9, 1)
            // anchor: const ui.Offset(0.5, 1.0),
            ),

        position: LatLng(hour.latitude, hour.longitude),
        // icon: BitmapDescriptor.defaultMarker,
        icon: hour.id == ""
            ? BitmapDescriptor.fromBytes(mapMarkerStandard)
            : BitmapDescriptor.fromBytes(mapMarkerBusiness),
        // icon: hour.paid.toString() != ""
        //     ? BitmapDescriptor.fromBytes(mapMarkerBusiness)
        //     : BitmapDescriptor.fromBytes(mapMarker),
      );
      latitude = hour.latitude;
      longitude = hour.longitude;
    }
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(currentLoc?.latitude ?? latitude!,
            currentLoc?.longitude ?? longitude!),
        zoom: 10)));
  }
}

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
      targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
      .buffer
      .asUint8List();
}
