import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happy_hour_app/core/colors.dart';

class CustomCircleIndicator extends StatelessWidget {
  final Widget child;
  final bool isEnabled;
  final double opacity;
  final Color? color;
  const CustomCircleIndicator(
      {Key? key,
      required this.child,
      required this.isEnabled,
      this.color,
      required this.opacity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IgnorePointer(
          ignoring: isEnabled,
          child: Opacity(
            opacity: isEnabled ? opacity : 1.0,
            child: child,
          ),
        ),
        isEnabled
            ? Center(
                child: SpinKitCircle(
                  color: color ?? primary,
                  size: 60.0,
                ),
              )
            : Container()
      ],
    );
  }
}
