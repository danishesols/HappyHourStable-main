// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:happy_hour_app/core/colors.dart';

import '../core/constants.dart';

class AccountTypeCard extends StatelessWidget {
  const AccountTypeCard({
    Key? key,
    required this.title,
    required this.text,
    required this.textsecond,
    this.button,
  }) : super(key: key);
  final String title;
  final String text;
  final String textsecond;
  final Widget? button;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: whiteColor,
      shadowColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.065,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              textsecond,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: yellowTextColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(" • Lorem Ipsum "),
                Text(" • Lorem Ipsum ")
              ],
            ),
          ),
          SizedBox(
            height: H * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [Text(" • Lorem Ipsum"), Text(" • Lorem Ipsum")],
            ),
          ),
          SizedBox(
            height: H * 0.03,
          ),
          SizedBox(height: H * 0.07, width: W * 0.55, child: button),
          SizedBox(
            height: H * 0.03,
          ),
        ],
      ),
    );
  }
}
