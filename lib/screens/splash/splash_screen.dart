import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:happy_hour_app/screens/splash/splash_screen_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/images/Rectangle 2698.png",
          height: MediaQuery.of(context).size.height / 4,
        ),
      ),
    );
  }
}
