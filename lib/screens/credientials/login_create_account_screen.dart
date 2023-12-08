import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/global_widgets/main_button.dart';
import 'package:happy_hour_app/routes/app_routes.dart';

import '../../global_controller/global_general_controller.dart';
import '../home_screen/home_screen.dart';

class LoginCreateAccountScreen extends StatelessWidget {
  const LoginCreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Get.find<GlobalGeneralController>().onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
              //  Get.back();
              Get.to(const HomeScreen());
              },
              icon: SvgPicture.asset(
                "assets/icons/Group 9108.svg",
                height: 25,
                width: 25,
              )),
          title: const Text("Login or Create account"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: H * 0.009,
            ),
            SizedBox(
              height: H * 0.02,
            ),
            Center(
              child: Image(
                image: const AssetImage(
                  "assets/icons/Group 11411@2x.png",
                ),
                height: H * 0.25,
                width: W * 0.6,
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            const Center(
              child: Text(
                "Login or Create account",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Suspendisse fermentum consectetur enim",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            SizedBox(
              height: H * 0.05,
            ),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: primary),
                  borderRadius: BorderRadius.circular(45)),
              height: H * 0.09,
              width: W * 92,
              child: CustomWhiteButtonWidget(
                onPressed: () {
                  Get.toNamed(Routes.loginScreen);
                },
                horizontalPadding: 0,
                verticalPadding: 0,
                text: 'Login',
                textColor: blackColor,
                fontSize: 24,
                borderRadius: 45,
              ),
            ),
            SizedBox(
              height: H * 0.03,
            ),
            SizedBox(
              height: H * 0.09,
              width: W * 92,
              child: CustomElevatedButtonWidget(
                onPressed: () {
                  Get.toNamed(Routes.signUpScreen);
                },
                text: "Create Account",
                textColor: blackColor,
                fontSize: 24,
                verticalPadding: 0,
                borderRadius: 45,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
