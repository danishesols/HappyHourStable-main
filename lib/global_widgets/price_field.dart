import 'package:flutter/material.dart';

class PriceField extends StatelessWidget {
  const PriceField({
    Key? key,
    this.textEditingController,
    this.keyboardType,
    this.validator,
    this.onChanged,
    this.onTap,
    this.width,
    this.height,
  }) : super(key: key);

  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(45),
        child: TextFormField(
          validator: validator,
          onTap: onTap,
          controller: textEditingController,
          onChanged: onChanged,
          obscureText: false,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(8.0, 2.0, 2.0, 2.0),
            filled: false,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("\$"),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 0,
            ),
          ),
        ),
      ),
    );
  }
}
