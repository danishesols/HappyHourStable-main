// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    Key? key,
    required this.title,
    required this.image,
    this.height,
    this.width,
    this.imagewidth,
    this.imageheight,
    this.onPressed,
  }) : super(key: key);
  final String title;
  final String image;
  final double? height;
  final double? width;
  final double? imagewidth;
  final double? imageheight;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 25, right: 10.0, top: 20, bottom: 20),
              child: SizedBox(
                child: SvgPicture.asset(
                  image,
                  height: imageheight,
                  width: imagewidth ?? 60,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomNotificationCard extends StatelessWidget {
  const CustomNotificationCard({
    Key? key,
    required this.title,
    required this.image,
    required this.subtitle,
    this.height,
    this.width,
  }) : super(key: key);
  final String title;
  final String image;
  final String subtitle;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: whiteColor,
      shadowColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 30, right: 10.0, top: 25, bottom: 25),
            child: Container(
                height: H * 0.05,
                width: W * 0.05,
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: Image(image: AssetImage(image))),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: H * 0.015,
              ),
              Text(
                subtitle,
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
              ),
            ],
          )
        ],
      ),
    );
  }
}
