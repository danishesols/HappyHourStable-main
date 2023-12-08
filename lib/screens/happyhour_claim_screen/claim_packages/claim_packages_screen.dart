import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/account_type_card.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../../../global_widgets/custom_button.dart';

class ClaimPackagesScreen extends StatelessWidget {
  const ClaimPackagesScreen({Key? key}) : super(key: key);

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
        title: const Text("Package"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: H * 0.009,
            ),
            SizedBox(
              height: H * 0.02,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                "Subcription Packages",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccountTypeCard(
                title: 'Free Account',
                text:
                    "The free account will allow you to setup your business and let control your business information and much more.",
                textsecond: "Why you should subscribe",
                button: CustomElevatedButtonWidget(
                  verticalPadding: 0,
                  onPressed: () {
                    Get.offNamed(Routes.claimedScreen);
                    // Get.offNamed(Routes.addBusinessRequestSubmittedScreen);
                  },
                  text: 'Subscribe now',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AccountTypeCard(
                title: 'Paid Account',
                text:
                    "the paid account will allow you to set up your business and let control your business information.Also it will enable your business to show up above other unpaid accounts in the search results",
                textsecond: "Why you should subscribe",
                button: CustomElevatedButtonWidget(
                  verticalPadding: 0,
                  onPressed: () {
                    Get.toNamed(Routes.checkOutScreen);
                  },
                  text: 'Subscribe now',
                ),
              ),
            ),
            SizedBox(
              height: H * 0.009,
            ),
          ]),
        ),
      ),
    );
  }
}
