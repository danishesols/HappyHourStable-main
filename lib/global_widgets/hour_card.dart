import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../core/constants.dart';

class HourCard extends StatelessWidget {
  const HourCard({
    Key? key,
    // * assign the default values if variables are null.
    this.menuImage = "",
    this.favourite,
    required this.name,
    this.businessAddress,
    required this.onTap,
    this.description = "",
    required this.icon,
    this.star, this.time,
  }) : super(key: key);

  final String menuImage;
  final String name;
  final String description;
  final Widget? favourite;
  final String? businessAddress;
  final Widget? star;
  final String? time;
  final void Function() onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 1.0,
            ),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: H * 0.12,
                      width: W * 0.28,
                      // child: SvgPicture.asset(image),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(menuImage),
                              fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: W * 0.46,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        businessAddress ?? "",
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),

                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/icons/Group 11432.svg",
                            height: 20,
                            width: 20,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                           Text(
                            time??"",
                            style: TextStyle(
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
                          star ?? Container(),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "",
                            style: TextStyle(
                                fontSize: 8, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      //    menuImage == ""
                      //       ? const Center(
                      //           child: FaIcon(FontAwesomeIcons.circleExclamation),
                      //         )
                      //       : CachedNetworkImage(
                      //           imageUrl: menuImage,
                      //           placeholder: (context, url) =>
                      //               const CircularProgressIndicator(),
                      //           errorWidget: (context, url, error) =>
                      //               const Icon(Icons.error),
                      //         ),
                      // ),
                      // Flexible(
                      //   flex: 2,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             width: MediaQuery.of(context).size.width / 2,
                      //             child: Text(
                      //               name,
                      //               style: const TextStyle(
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.w700,
                      //               ),
                      //             ),
                      //           ),
                      //           // * dynamic icon
                      //           icon
                      //         ],
                      //       ),
                      //       const SizedBox(height: 8),
                      //       Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           SizedBox(
                      //             width: MediaQuery.of(context).size.width / 2,
                      //             child: Text(
                      //               description,
                      //               maxLines: 2,
                      //               overflow: TextOverflow.ellipsis,
                      //               style: const TextStyle(
                      //                 fontSize: 14,
                      //                 color: Colors.grey,
                      //               ),
                      //             ),
                      //           ),
                      //           // const Padding(
                      //           //   padding: EdgeInsets.only(right: 8.0),
                      //           //   child: FaIcon(
                      //           //     FontAwesomeIcons.chevronRight,
                      //           //     color: Colors.grey,
                      //           //   ),
                      //           // ),
                      //         ],
                      //       ),
                      //       const SizedBox(height: 8),
                      //       const SizedBox(height: 4),
                      //       // Align(
                      //       //   alignment: Alignment.bottomRight,
                      //       //   child: Text(
                      //       //     "Expires $offerExpireDate",
                      //       //     style: const TextStyle(
                      //       //       fontSize: 14,
                      //       //       color: Colors.grey,
                      //       //     ),
                      //       //   ),
                      //       // ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  width: W * 0.02,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 5.0, top: 0),
                    child: favourite
                    //  Image.asset(
                    //   "assets/icons/Group 11558.png",
                    //   height: H * 0.08,
                    //   width: W * 0.2,
                    // ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
