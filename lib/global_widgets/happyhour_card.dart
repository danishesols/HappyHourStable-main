import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/constants.dart';

class CustomHappyhourCard extends StatelessWidget {
  const CustomHappyhourCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.height,
    this.width,
    this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    required this.ontap,
    this.arrowImage,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final String? time;
  final String? timeIcon;
  final Widget rating;
  final String rateCount;
  final Widget? arrowImage;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        elevation: 5,
        color: whiteColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: image.isEmpty
                  ? const Center(
                      child: SpinKitCircle(
                        color: primary,
                        size: 70.0,
                      ),
                    )
                  : Container(
                      height: H * 0.12,
                      width: W * 0.25,
                      // child: SvgPicture.asset(image),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover),
                      ),
                    ),
            ),
            SizedBox(
              width: W * 0.005,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: SizedBox(
                width: W * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      maxLines: 2,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: H * 0.01,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          timeIcon ?? "",
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          time ?? "",
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        rating,
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          rateCount,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 4),
                child: arrowImage ?? const SizedBox()),
          ],
        ),
      ),
    );
  }
}

class CustomReviewCard extends StatelessWidget {
  const CustomReviewCard({
    Key? key,
    required this.subtitle,
    required this.image,
    this.height,
    this.width,
    required this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    this.replieTitle,
    this.replieSubTitle,
    this.replieImage,
    this.replieTime,
    this.showReply,
    this.onTap,
  }) : super(key: key);

  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final String time;
  final String? timeIcon;
  final String rating;
  final String rateCount;
  final String? replieTitle;
  final String? replieSubTitle;
  final String? replieImage;
  final String? replieTime;
  final bool? showReply;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: whiteColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: H * 0.1,
                    width: W * 0.2,
                    // child: SvgPicture.asset(image),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: bgColor,
                        image: DecorationImage(image: AssetImage(image))),
                  ),
                ),
                SizedBox(
                  width: W * 0.020,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      subtitle,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w300),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          rating,
                          height: H * 0.015,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: H * 0.015,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: H * 0.015,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: H * 0.015,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: H * 0.015,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          rateCount,
                          style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 8,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Visibility(
              visible: showReply ?? false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, bottom: 12.0),
                    child: Text("Replies"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16.0, bottom: 16.0),
                    child: Container(
                      height: H * 0.1,
                      width: W,
                      decoration: BoxDecoration(
                          color: const Color(0xFFF5F4F4),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: W * 0.14,
                              // child: SvgPicture.asset(image),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: bgColor,
                                  image: DecorationImage(
                                      image: AssetImage(replieImage ?? ""))),
                            ),
                          ),
                          SizedBox(
                            width: W * 0.020,
                          ),
                          SizedBox(
                            width: W * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0, left: 0, right: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        replieTitle ?? "",
                                        textAlign: TextAlign.start,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        replieTime ?? "",
                                        style: const TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: H * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        replieSubTitle ?? "",
                                        maxLines: 4,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  const NewCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.share,
    this.flag,
    this.height,
    this.width,
    required this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    this.isNetworkImage,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String? image;
  final Widget? share;
  final Widget? flag;
  final double? height;
  final double? width;
  final String time;
  final String? timeIcon;
  final Widget rating;
  final String rateCount;
  final bool? isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: H * 0.070,
            width: H * 0.070,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: isNetworkImage == true
                  ? Image.network(
                      image!,
                      fit: BoxFit.cover,
                    )
                  : image != null
                      ? Image.file(
                          File(image!),
                          fit: BoxFit.cover,
                        )
                      : null,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              shape: BoxShape.circle,
              image: isNetworkImage == false && image == null
                  ? const DecorationImage(
                      image: AssetImage("assets/icons/Group 11550.png"),
                      fit: BoxFit.fitHeight,
                    )
                  : null,
            ),
          ),
        ),
        SizedBox(
          width: W * 0.01,
        ),
        SizedBox(
          width: W * 0.48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Image.asset(
                    timeIcon ?? "",
                    height: H * 0.015,
                    //width: W * 0.04,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  rating,
                  SizedBox(
                    width: W * 0.02,
                  ),
                  Text(
                    rateCount,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 7,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.only(left: 1), child: share),
        Padding(padding: const EdgeInsets.only(left: 2, top: 0), child: flag)
      ],
    );
  }
}

class ClaimedHappyhourCard extends StatelessWidget {
  const ClaimedHappyhourCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.dialogShow,
    required this.popUpMenu,
    this.height,
    this.width,
    required this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    this.dialogPressed,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  final String dialogShow;
  final Widget popUpMenu;
  final double? height;
  final double? width;
  final String time;
  final String? timeIcon;
  final String rating;
  final String rateCount;
  final VoidCallback? dialogPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: whiteColor,
      shadowColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 2),
              child: Container(
                height: H * 0.11,
                width: W * 0.22,
                child: image != 'null' || image != null
                    ? Image.asset(
                        'assets/images/Rectangle 2698@2x.png',
                        fit: BoxFit.cover,
                      )
                    : null,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: whiteColor,
                  image: image != 'null' || image != null
                      ? DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover)
                      : null,
                ),
              ),
            ),
            SizedBox(
              width: W * 0.02,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: W * 0.36,
                  child: Text(
                    title,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: H * 0.010,
                ),
                SizedBox(
                  width: W * 0.4,
                  child: Text(
                    subtitle,
                    maxLines: 1,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(
                  height: H * 0.010,
                ),
                Row(
                  children: [
                    Image.asset(
                      timeIcon ?? "",
                      height: H * 0.02,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      time,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      rating,
                      height: H * 0.016,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      rating,
                      height: H * 0.016,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      rating,
                      height: H * 0.016,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      rating,
                      height: H * 0.016,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgPicture.asset(
                      rating,
                      height: H * 0.016,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      rateCount,
                      style: const TextStyle(
                          fontSize: 8, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: GestureDetector(
                    onTap: dialogPressed,
                    child: Container(
                      height: H * 0.1,
                      width: W * 0.1,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        dialogShow,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                //  Padding(
                //   padding: const EdgeInsets.only(left: 10.0, top: 10),
                //   child: GestureDetector(
                //     onTap: dialogPressed,
                //     child: ClipOval(
                //       child: Image.network(
                //         dialogShow,
                //         height: H * 0.057,
                //         width: W * 0.12,
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //     // Image.network(
                //     //   dialogShow,
                //     //   height: 70,
                //     // )
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Container(
                    height: H * 0.1,
                    width: W * 0.12,
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(offset: Offset(0, 0))],
                      shape: BoxShape.circle,
                      color: whiteColor,
                    ),
                    child: popUpMenu,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CustomHappyhourFavoriteCard extends StatelessWidget {
  const CustomHappyhourFavoriteCard({
    Key? key,
    required this.title,
    required this.favImage,
    required this.favoritePressed,
    required this.subtitle,
    required this.image,
    this.height,
    this.width,
    required this.time,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
  }) : super(key: key);
  final String title;
  final String favImage;
  final VoidCallback favoritePressed;
  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final String time;
  final String? timeIcon;
  final String rating;
  final String rateCount;

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
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100,
              width: 100,
              // child: SvgPicture.asset(image),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: AssetImage(image))),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                subtitle,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    timeIcon ?? "",
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    time,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    rating,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    rating,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    rating,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    rating,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SvgPicture.asset(
                    rating,
                    height: 15,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    rateCount,
                    style: const TextStyle(
                        fontSize: 8, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10),
            child: GestureDetector(
              onTap: favoritePressed,
              child: SizedBox(
                height: H * 0.11,
                width: W * 0.14,
                child: Image.asset(favImage),
                // decoration: BoxDecoration(
                //   boxShadow: const [BoxShadow(offset: Offset(0, 0))],
                //   shape: BoxShape.circle,
                //   color: whiteColor,
                //   image: DecorationImage(
                //       image: AssetImage(favImage), fit: BoxFit.cover),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHappyhourSearchCard extends StatelessWidget {
  const CustomHappyhourSearchCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    this.height,
    this.width,
    required this.yellowText,
    this.yellowText2,
    this.timeIcon,
    required this.rating,
    required this.rateCount,
    this.onTap,
    this.share,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  final double? height;
  final double? width;
  final String yellowText;
  final String? yellowText2;
  final String? timeIcon;
  final String rating;
  final String rateCount;
  final VoidCallback? onTap;
  final Widget? share;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        color: whiteColor,
        shadowColor: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: H * 0.12,
                width: W * 0.24,
                // child: SvgPicture.asset(image),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: SizedBox(
                width: W * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            yellowText,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                color: primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            yellowText2 ?? "",
                            style: const TextStyle(
                                color: primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          rating,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          rating,
                          height: 15,
                          width: 15,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          rateCount,
                          style: const TextStyle(
                              fontSize: 8, fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 0),
                child: share),
          ],
        ),
      ),
    );
  }
}

class ClaimCard extends StatelessWidget {
  const ClaimCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.claim,
    required this.share,
    this.height,
    this.width,
    required this.time,
    this.viewIcon,
    required this.rateCount,
    required this.ratingWidget,
  }) : super(key: key);
  final String title;
  final String subtitle;
  final String image;
  final Widget claim;
  final Widget share;
  final double? height;
  final double? width;
  final String time;
  final String? viewIcon;
  final String rateCount;
  final Widget ratingWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 70,
            width: 70,
            // child: SvgPicture.asset(image),
            decoration: BoxDecoration(
                color: whiteColor,
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(image))),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              subtitle,
              style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Image.asset(
                  viewIcon ?? "",
                  height: 20,
                  width: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  time,
                  style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [ratingWidget],
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 0), child: claim),
        Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 0), child: share),
      ],
    );
  }
}
