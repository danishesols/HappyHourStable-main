import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/global_widgets/custom_card.dart';

import '../../core/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
            )),
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 16),
                child: Text(
                  "Today",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CustomNotificationCard(
                          title: "Lorem ipsum",
                          subtitle:
                              "lorem ipsum dolor sit amit,consectater adipi.",
                          image: "assets/icons/Group 2187@2x.png"),
                    ),
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0, top: 16),
                child: Text(
                  "Last Week",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CustomNotificationCard(
                          title: "Lorem ipsum",
                          subtitle:
                              "lorem ipsum dolor sit amit,consectater adipi.",
                          image: "assets/icons/Group 2187@2x.png"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
