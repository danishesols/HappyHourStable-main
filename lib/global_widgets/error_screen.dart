import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';

import '../core/constants.dart';
import '../routes/app_routes.dart';

class CustomError extends StatelessWidget {
  final String errorDetails;

  const CustomError({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

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
          "No Result Found",
          style: TextStyle(color: Colors.red),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 16.0,
            ),
            child: GestureDetector(
              onTap: () {
                Get.offNamed(Routes.happyHourFilterScreen);
              },
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
          )
        ],
      ),
      backgroundColor: bgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: H * 0.1,
            ),
            Image.asset(
              'assets/images/error.png',
              width: W * 0.96,
            ),
            SizedBox(
              height: H * 0.04,
            ),
            Text(
              errorDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: kDebugMode ? Colors.red : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
