import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/home_screen/home_screen_controller.dart';
import '../../../routes/app_routes.dart';

class DrawerWidget extends GetView<HomeScreenController> {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: bgColor,
        child: Padding(
          padding: EdgeInsets.only(top: H * 0.06),
          child: Column(
            children: [
              Container(
                height: H * 0.2,
                width: W,
                decoration: const BoxDecoration(
                    color: bgColor,
                    image: DecorationImage(
                        image: AssetImage("assets/icons/Group 11411@2x.png"),
                        fit: BoxFit.cover)),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: bgColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: ListView(
                      children: [
                        // CustomListTile(
                        //   title: "Settings",
                        //   iconData: FontAwesomeIcons.cog,
                        //   onTap: controller.onSettingsTap,
                        // ),
                        CustomListTile(
                          title: "Language",
                          image: "assets/icons/Group 1029.svg",
                          onTap: () {
                            // Get.to(() => MyApp());
                          },
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

                        // CustomListTile(
                        //   title: "Delete Account",
                        //   iconData: FontAwesomeIcons.trashAlt,
                        //   onTap: () {},
                        //   color: tertiary,
                        // ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.image,
    required this.onTap,
    this.color,
  }) : super(key: key);

  final String title;
  final String image;
  final void Function()? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          leading: SvgPicture.asset(
            image,
            height: 30,
            width: 30,
            color: color ?? Colors.black,
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
