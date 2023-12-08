import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/data/providers/user_provider.dart';
import 'package:happy_hour_app/screens/home_screen/home_screen_controller.dart';

import '../../../../global_controller/auth_controller.dart';
import '../../../../routes/app_routes.dart';
import '../../../home_screen/widgets/drawer.dart';

class LoginDrawerWidget extends GetView<HomeScreenController> {
  const LoginDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: bgColor,
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Get.find<AuthController>().user.profileImage != null &&
                      Get.find<AuthController>().user.profileImage != ''
                  ? Image.network(
                      Get.find<AuthController>().user.profileImage!,
                      height: Get.height * 0.16,
                      // width: Get.width * 0.25,
                    )
                  : Image.asset(
                      "assets/icons/Group 11411@2x.png",
                      height: Get.height * 0.16,
                      // width: Get.width * 0.25,
                    ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: ListView(
                    children: [
                      CustomListTile(
                        title: "My Profile",
                        image: "assets/icons/Group 1033.svg",
                        onTap: () {
                          Get.toNamed(Routes.myProfileScreen);
                        },
                      ),
                      CustomListTile(
                        title: "Favorites",
                        image: "assets/icons/Group 11552.svg",
                        onTap: () {
                          Get.toNamed(Routes.favoritesScreen);
                        },
                      ),
                      CustomListTile(
                        title: "Language",
                        image: "assets/icons/Group 1029.svg",
                        onTap: () {},
                      ),
                      CustomListTile(
                        title: "Privacy Policy",
                        image: "assets/icons/Path 1052.svg",
                        onTap: () {
                          Get.toNamed(Routes.privacyPolicyScreen);
                        },
                      ),
                      CustomListTile(
                        title: "FAQ's",
                        image: "assets/icons/Group 1021.svg",
                        onTap: () {
                          Get.toNamed(Routes.faqScreen);
                        },
                      ),
                      CustomListTile(
                        title: "Terms of Use",
                        image: "assets/icons/Group 1031.svg",
                        onTap: () {
                          Get.toNamed(Routes.termOfUseScreen);
                        },
                      ),
                      CustomListTile(
                        title: "About Us",
                        image: "assets/icons/Group 1027.svg",
                        onTap: () {
                          Get.toNamed(Routes.aboutUsScreen);
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: CustomListTile(
                  title: "Log out",
                  image: "assets/icons/Group 991.svg",
                  onTap: () {
                  Get.find<AuthController>().logoutUser();
                  Get.toNamed(Routes.loginCreateAccountScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
