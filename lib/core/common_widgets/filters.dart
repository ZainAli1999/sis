// import 'package:fresh_pick/theme/colors.dart';
// import 'package:fresh_pick/theme/font_structures.dart';
// import 'package:fresh_pick/theme/spacing.dart';
// import 'package:fresh_pick/widgets/custom_button.dart';
// import 'package:fresh_pick/widgets/custom_drop_down.dart';
// import 'package:fresh_pick/widgets/custom_icon_button.dart';
// import 'package:fresh_pick/widgets/custom_text_field.dart';
// import 'package:flutter/material.dart';

// int limitValue = 0;
// int sortByValue = 0;
// filters(size, context) {
//   return showModalBottomSheet(
//     backgroundColor: themewhitecolor,
//     isScrollControlled: true,
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//     ),
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           return Container(
//             height: size.height / 100 * 70,
//             width: size.width,
//             decoration: const BoxDecoration(
//               color: themewhitecolor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(20),
//                 topRight: Radius.circular(20),
//               ),
//             ),
//             child: Stack(
//               children: [
//                 Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 10),
//                       child: Container(
//                         height: 5,
//                         width: 50,
//                         decoration: BoxDecoration(
//                           color: themegreycolor,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Text(
//                             "Filters",
//                             style: TextStyle(
//                               fontSize: largefontsize6,
//                               fontWeight: boldfontweight,
//                             ),
//                           ),
//                           CustomIconButton(
//                             onTap: () {
//                               Navigator.pop(context);
//                             },
//                             child: const Icon(Icons.close),
//                           ),
//                         ],
//                       ),
//                     ),
//                     10.kH,
//                     const Divider(
//                       height: 0,
//                     ),
//                     // Spacing.v(20),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             top: 20,
//                             bottom: 75,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.symmetric(
//                                   horizontal: 20,
//                                 ),
//                                 child: Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width: size.width / 100 * 55,
//                                       child: const CustomTextField(
//                                         textInputType: TextInputType.text,
//                                         hintText: "Search in Database",
//                                         filled: true,
//                                         fillColor: themetextfieldcolor,
//                                         isOutlinedInputBorder: true,
//                                         focusedBorderColor: Palette.themecolor,
//                                         borderWidth: 1.5,
//                                       ),
//                                     ),
//                                     10.kW,
//                                     Expanded(
//                                       child: CustomDropDown(
//                                         hint: 'City',
//                                         errorText: '',
//                                         value: limitValue,
//                                         items: [
//                                           const DropdownMenuItem(
//                                             value: 0,
//                                             child: Text('50'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 1,
//                                             child: Text('100'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 2,
//                                             child: Text('200'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 3,
//                                             child: Text('300'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 3,
//                                             child: Text('400'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 3,
//                                             child: Text('500'),
//                                           ),
//                                         ].cast<DropdownMenuItem<int>>(),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             limitValue = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                     10.kW,
//                                     Expanded(
//                                       child: CustomDropDown(
//                                         hint: 'Sort by',
//                                         errorText: '',
//                                         value: sortByValue,
//                                         items: [
//                                           const DropdownMenuItem(
//                                             value: 0,
//                                             child: Text('Asc'),
//                                           ),
//                                           const DropdownMenuItem(
//                                             value: 1,
//                                             child: Text('Desc'),
//                                           ),
//                                         ].cast<DropdownMenuItem<int>>(),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             sortByValue = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               20.kH,
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 20),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: size.width / 100 * 68,
//                                       child: const CustomTextField(
//                                         textInputType: TextInputType.text,
//                                         hintText: "Search in Table",
//                                         filled: true,
//                                         fillColor: themetextfieldcolor,
//                                         isOutlinedInputBorder: true,
//                                         focusedBorderColor: Palette.themecolor,
//                                         borderWidth: 1.5,
//                                       ),
//                                     ),
//                                     10.kW,
//                                     CustomButton(
//                                       onTap: () {},
//                                       height: 40,
//                                       width: 100,
//                                       buttoncolor: Palette.themecolor,
//                                       borderRadius: BorderRadius.circular(30),
//                                       child: const Icon(
//                                         Icons.search,
//                                         color: themewhitecolor,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SafeArea(
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Container(
//                       height: 60,
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       decoration: const BoxDecoration(
//                         color: themewhitecolor,
//                         border: Border(
//                           top: BorderSide(
//                             color: themegreytextcolor,
//                           ),
//                         ),
//                       ),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           CustomButton(
//                             height: 45,
//                             width: size.width,
//                             child: const Text(
//                               "Done",
//                               style: TextStyle(
//                                 color: themewhitecolor,
//                                 fontSize: mediumfontsize3,
//                               ),
//                             ),
//                             onTap: () {
//                               // Go.push(
//                               //   context,
//                               //   const SearchProjectsScreen(title: "Homes"),
//                               // );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
