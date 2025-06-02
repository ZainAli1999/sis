// import 'package:flutter/material.dart';
// import 'package:vshop/theme/colors.dart';
// import 'package:vshop/theme/font_structures.dart';
// import 'package:vshop/theme/spacing.dart';

// marketingBanner(size, context, String image) {
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
//           return Stack(
//             clipBehavior: Clip.none,
//             children: [
//               Container(
//                 height: size.height / 100 * 70,
//                 width: size.width,
//                 decoration: const BoxDecoration(
//                   color: themewhitecolor,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                         child: Image.asset(
//                           image,
//                           height: 215,
//                           width: size.width,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             const Text(
//                               "Marketing Advertisement",
//                               style: TextStyle(
//                                 fontSize: largefontsize6,
//                                 fontWeight: boldfontweight,
//                               ),
//                             ),
//                             Spacing.v(10),
//                             const Text(
//                               "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed tempor vel ex eu ullamcorper. Duis molestie, sem at ultricies ullamcorper,",
//                               style: TextStyle(
//                                 color: themegreytextcolor,
//                                 fontSize: mediumfontsize5,
//                               ),
//                             ),
//                             Spacing.v(20),
//                             Column(
//                               children: List.generate(
//                                 4,
//                                 (index) => const ListTile(
//                                   minVerticalPadding: 0,
//                                   minLeadingWidth: 0,
//                                   contentPadding: EdgeInsets.zero,
//                                   titleAlignment: ListTileTitleAlignment.center,
//                                   leading: CircleAvatar(
//                                     radius: 4,
//                                     backgroundColor: Palette.themecolor,
//                                   ),
//                                   title: Text("Lorem ipsum dolor sit amet,"),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: -60,
//                 left: 25,
//                 child: CircleAvatar(
//                   backgroundColor: Theme.of(context).colorScheme.surface,
//                   child: Icon(
//                     Icons.close,
//                     color: Theme.of(context).colorScheme.secondary,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   );
// }
