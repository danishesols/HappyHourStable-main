// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:happy_hour_app/core/colors.dart';
import 'package:happy_hour_app/core/styles.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    Key? key,
    this.button,
    this.title,
    this.image,
  }) : super(key: key);
  final Widget? button;
  final String? title;
  final String? image;

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0, top: 8),
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              "assets/icons/Group 11395@2x.png",
            ),
          ),
        ),
      ),
      backgroundColor: bgColor,
      elevation: 0,
      title: Text(
        title ?? "",
        style: appbarTitleStyle,
      ),
      actions: [button ?? Container()],
    );
  }
}
