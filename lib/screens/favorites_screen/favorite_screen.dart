import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:happy_hour_app/core/constants.dart';
import 'package:happy_hour_app/screens/favorites_screen/favorite_controller.dart';

import '../../core/colors.dart';
import '../../global_controller/auth_controller.dart';
import '../../global_widgets/favorite_happyhour.dart';
import '../../routes/app_routes.dart';

class FavoritesScreen extends GetView<FavoriteController> {
  const FavoritesScreen({Key? key}) : super(key: key);

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
          "Favorites",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
        ),
        centerTitle: true,
      ),
      // extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "List of Your added Favorites",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    GestureDetector(
                    child: Chip(
                          padding: const EdgeInsets.all(10),
                          avatar: Image.asset(
                            "assets/images/Group 3809.png",
                          ),
                          label: const Text("View Map" ,style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.grey[400],
                          elevation: 5,
                        ),
                      onTap: () {
                        Get.toNamed(Routes.mapScreen);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: H * 0.01,
              ),
              HoursListGenerator(
                query: controller.favoriteProvider.favoriteHoursQuery(
                  userId: Get.find<AuthController>().user.uid,
                ),
                showUnfavoriteButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
