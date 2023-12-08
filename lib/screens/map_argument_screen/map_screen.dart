import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/screens/map_argument_screen/map_controller.dart';
import '../../routes/app_routes.dart';

class MapScreen extends GetView<MapController> {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SvgPicture.asset(
                "assets/icons/Group 9108.svg",
                height: 25,
                width: 25,
              ),
            )),
        title: const Text(
          "Happy Hour",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                //Get.toNamed(Routes.happyHourFilterScreen);
                showCustomDialog(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: primary,
                  child: SvgPicture.asset(
                    "assets/icons/Group 4822.svg",
                    height: 25,
                    width: 25,
                  ),
                  // backgroundImage: SvgPicture.asset(""),
                ),
              ),
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Container(
      //     height: Get.height,
      //     width: Get.width,

      //     child: Center(
      //       child: SizedBox(
      //         //  child:   Lottie.asset('assets/animations/coming-soon.json'),
      //         //child: Image.asset('assets/images/coming-soon.jpg'),
      //         child: Image.asset('assets/images/coming-soon5.png'),
      //       ),
      //     ),
      //   ),
      // ),
      body: GetBuilder<MapController>(
        init: MapController(),
        builder: (controller) {
          return Stack(children: [
            Obx(
              () => GoogleMap(
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: controller.defaultCameraPosition??const CameraPosition(
                  target: LatLng(37.3454, -122.3454),
                  zoom: 10,
                ),
                onMapCreated: controller.onMapCreated,
                markers: controller.markers,
      
              ),
            ),
            // GoogleMap(
            //   padding: const EdgeInsets.all(16),
            //   initialCameraPosition: controller.kGooglePlex,
            //   tiltGesturesEnabled: true,
            //   myLocationEnabled: true,
            //   myLocationButtonEnabled: true,
            //   onMapCreated: (GoogleMapController ctn) {
            //     // ignore: null_argument_to_non_null_type
            //     controller.complete.complete();
            //   },
            // ),
      
            /* this is Map List View Data
            Positioned(
              top: H * 0.12,
              right: 26,
              child: GestureDetector(
                child: Chip(
                  padding: const EdgeInsets.all(12),
                  avatar: Image.asset(
                    "assets/icons/Group 11516.png",
                  ),
                  label: const Text("List View"),
                  backgroundColor: whiteColor,
                  elevation: 5,
                ),
                onTap: () {
                  Get.toNamed(Routes.happyHourSearchResultScreen,
                      arguments: [""]);
                },
              ),
            ), */
          ]);
        },
      ),
    );
  }

  void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/images/coming-soon5.png'), // Replace with your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   top: 0,
                //   right: 0,
                //   child: IconButton(
                //     icon: const Icon(Icons.close, color: Colors.yellow),
                //     onPressed: () {
                //       Navigator.of(context).pop();
                //     },
                //   ),
                // ),
              ],
            ),
            //const SizedBox(height: 100.0), // Set the height of the dialog
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: const Center(
                    child:  Text(
                      'close',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
}
