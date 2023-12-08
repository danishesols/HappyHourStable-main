import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../../../core/colors.dart';
import '../../../core/constants.dart';
import 'business_items/addhappyhour_business_controller.dart';

class AddForBusinessOrGuestScreen
    extends GetView<AddHappyhourBusinessController> {
  const AddForBusinessOrGuestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: SvgPicture.asset(
            "assets/icons/Group 9108.svg",
            height: 25,
            width: 25,
          ),
        ),
        title: const Text("Add Happy Hour"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            SizedBox(
              height: H * 0.009,
            ),
            const Text(
              "Select Happy Hour Type",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            CardA(
              title: "Add for your own business",
              onPressed: () {
                Get.toNamed(Routes.addHappyHourBusinessAccountScreen);
              },
            ),
            SizedBox(
              height: H * 0.02,
            ),
            CardA(
              title: "Add for someone else's business",
              onPressed: () {
                Get.toNamed(Routes.guestFormScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardA extends StatelessWidget {
  const CardA({
    Key? key,
    required this.title,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Card(
        elevation: 5,
        color: whiteColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: SizedBox(
          height: H * 0.12,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
