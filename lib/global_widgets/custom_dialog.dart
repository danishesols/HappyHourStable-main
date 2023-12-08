
// import 'package:flutter/material.dart';

// class CustomDialogBox extends StatelessWidget {
//   const CustomDialogBox({
//     Key? key,
//     this.foodList,
//     this.limit,
//   }) : super(key: key);
//   final List<FoodName>? foodList;
//   final int? limit;

//   @override
//   Widget build(BuildContext context) {
//     List<FoodName>? filterUser;
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//             shape: BoxShape.rectangle,
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: const [
//               BoxShadow(
//                   color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
//             ]),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//                 margin: const EdgeInsets.only(right: 10),
//                 child: Align(
//                     alignment: Alignment.topRight,
//                     child: Text("Select atleast$limit"))),
//             Flexible(
//               fit: FlexFit.loose,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.vertical,
//                 itemCount: filterUser!.length,
//                 itemBuilder: (context, index) {
//                   return Column(
//                     children: [
//                       CheckboxListTile(
//                         title: Text(
//                           filterUser[index].name,
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                         value: filterUser[index].isChecked,
//                         activeColor: Colors.blueGrey[200],
//                         checkColor: const Color(0xff00363A),
//                         onChanged: (val) {
//                           filterUser[index].isChecked = val;
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomRight,
//               child: GestureDetector(
//                 onTap: () {
//                   String name = "";
//                   for (int i = 0; i < filterUser.length; i++) {
//                     if (filterUser[i].isChecked!) {
//                       name = filterUser[i].name;
//                     }
//                   }

//                   Navigator.pop(context);
//                 },
//                 child: Container(
//                   padding:
//                       const EdgeInsets.only(right: 20, bottom: 20, top: 10),
//                   child: const Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       "Ok",
//                       style: TextStyle(fontSize: 18, color: Colors.green),
//                       textAlign: TextAlign.end,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class FoodName {
//   String name;
//   bool? isChecked = false;

//   FoodName(this.name);
// }
