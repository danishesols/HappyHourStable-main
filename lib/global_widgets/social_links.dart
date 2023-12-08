import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global_controller/global_general_controller.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildIcon('insta_icon.webp','https://www.instagram.com/happy_hour_tap/'),
          _buildIcon('facebook_icon.webp','https://www.facebook.com/HappyHourTap/'),
          _buildIcon('twitter_icon.png','https://twitter.com/happyhourtap'),
          _buildIcon('tiktok_icon.png','https://www.tiktok.com/@happyhourtap'),
        ],
      ),
    );
  }

  Widget _buildIcon(String icon, String url) {
    return GestureDetector(
      onTap: () async {
        if (!await launchUrl(Uri.parse(url),
            mode: LaunchMode.externalNonBrowserApplication)) {
          Get.find<GlobalGeneralController>().errorSnackbar(
            title: "Error",
            description: 'Could not launch $url',
          );
        }
      },
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(5, 7),
              color: Colors.grey[200]!,
              blurRadius: 5,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Center(
          child: Image.asset(
            'assets/icons/$icon',
            height: 35,
            width: 35,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
