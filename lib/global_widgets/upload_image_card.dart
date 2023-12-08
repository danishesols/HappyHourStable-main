import 'package:flutter/material.dart';
import '../core/colors.dart';
import '../core/constants.dart';
import 'main_button.dart';

class UploadImageCard extends StatelessWidget {
  const UploadImageCard({
    Key? key,
    required this.title,
    required this.onpressed,
  }) : super(key: key);
  final String title;
  final VoidCallback onpressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: whiteColor,
      shadowColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: SizedBox(
        height: H * 0.15,
        width: W,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 64.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w300),
              ),
            ),
            CustomWhiteButtonWidget(
                horizontalPadding: 16,
                verticalPadding: 0,
                borderRadius: 10,
                text: "Upload",
                fontSize: 16,
                onPressed: onpressed)
          ],
        ),
      ),
    );
  }
}
