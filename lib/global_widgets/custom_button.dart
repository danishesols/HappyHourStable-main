import 'package:flutter/material.dart';
import 'package:happy_hour_app/core/colors.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  const CustomElevatedButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.borderRadius,
    this.verticalPadding,
    this.horizontalPadding,
    this.fontSize,
  }) : super(key: key);

  final String text;
  final void Function()? onPressed;
  final Color? color;
  final double? borderRadius;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(color ?? primary),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding ?? 0,
          vertical: verticalPadding ?? 20,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: blackColor,
            fontSize: fontSize ?? 16,
          ),
        ),
      ),
    );
  }
}
