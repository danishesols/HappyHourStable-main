// import 'package:flutter/material.dart';

// class DatePickerTextFeild extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final VoidCallback ontap;
//   final double? height;
//   final double? width;
//   const DatePickerTextFeild(
//       {Key? key,
//       this.height,
//       this.width,
//       required this.hintText,
//       this.controller,
//       required this.ontap})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width ?? MediaQuery.of(context).size.width * 0.2,
//       height: height ?? MediaQuery.of(context).size.height / 16,
//       child: Material(
//         elevation: 13,
//         borderRadius: BorderRadius.circular(40),
//         child: TextField(
//           controller: controller ?? TextEditingController(),
//           decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: const TextStyle(color: Colors.grey),
//               contentPadding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 20.0),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                   borderSide: BorderSide.none,
//                   borderRadius: BorderRadius.circular(40))),
//           readOnly: true,
//           onTap: ontap,
//         ),
//       ),
//     );
//   }
// }


//  TextEditingController datecontroller = TextEditingController();
//    void endDatePicker(context) async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );

//     if (pickedDate != null) {
//       String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
//       datecontroller.text = formattedDate; //set output date to TextField value.
//     } else {
//       debugPrint("Date is not selected");
//     }
//   }