import 'package:flutter/material.dart';
import 'package:happy_hour_app/core/colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    Key? key,
    this.labelText,
    this.textEditingController,
    this.keyboardType,
    this.maxLines = 1,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.obscureText = false,
    this.enabled,
    this.onChanged,
    this.blurRadius,
    this.elevation,
    this.hintText,
    this.borderRadius,
    this.onTap,
    this.readOnly,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool? enabled;
  final void Function(String)? onChanged;
  final double? blurRadius;
  final double? elevation;
  final String? hintText;
  final double? borderRadius;
  final void Function()? onTap;
  final bool? readOnly;

  final InputBorder bordersStyle = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(45)),
    borderSide: BorderSide(color: bgColor),
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 45),
      ),
      elevation: elevation ?? 5,
      child: TextFormField(
        readOnly: readOnly ?? false,
        onTap: onTap ?? () {},
        enabled: enabled,
        // initialValue: initialV,
        controller: textEditingController,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: obscureText,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 35, 20, 20),
          fillColor: whiteColor,
          filled: true,
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w300),
          alignLabelWithHint: true,
          border: bordersStyle,
          enabledBorder: bordersStyle,
          focusedBorder: bordersStyle,
          disabledBorder: bordersStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}
