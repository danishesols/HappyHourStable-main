import 'package:flutter/material.dart';
import 'package:happy_hour_app/core/colors.dart';

const titleStyle = TextStyle(
  fontSize: 50,
  color: blackColor,
  fontWeight: FontWeight.w700,
);

const bodyStyle = TextStyle(
  fontSize: 14,
  color: bgColor,
);

const headingStyle = TextStyle(
  fontSize: 24,
  color: primary,
  fontWeight: FontWeight.bold,
);

const appbarTitleStyle = TextStyle(
  fontSize: 16,
  color: blackColor,
);

const policyTitleStyle =
    TextStyle(fontSize: 24, color: blackColor, fontWeight: FontWeight.w500);
const decoration = InputDecoration(
  enabled: false,
  contentPadding: EdgeInsets.fromLTRB(12.0, 2.0, 8.0, 2.0),
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(45)),
  ),
);
