// import 'package:fresh_pick/theme/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// void showCircularLoadingDialog(context) {
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) => WillPopScope(
//         onWillPop: () async => true, child: const ProgressDialog()),
//   );
// }

// class ProgressDialog extends StatelessWidget {
//   const ProgressDialog({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         elevation: 20,
//         color: Palette.themecolor.withOpacity(0.9),
//         child: const SizedBox(
//           height: 130,
//           width: 130,
//           child: SpinKitFoldingCube(
//             color: themewhitecolor,
//           ),
//         ),
//       ),
//     );
//   }
// }