// import 'package:flutter/material.dart';
// import 'package:sis/core/common_widgets/custom_button.dart';
// import 'package:sis/core/common_widgets/custom_text_field.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';

// class ChangePasswordPage extends StatefulWidget {
//   const ChangePasswordPage({super.key});

//   @override
//   State<ChangePasswordPage> createState() => _ChangePasswordPageState();
// }

// class _ChangePasswordPageState extends State<ChangePasswordPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "Change Password",
//         ),
//       ),
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: CustomButton(
//             height: 55,
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {},
//             child: Text(
//               "Save Changes",
//               style: context.textTheme.bodyMedium?.themeWhiteColor.bold,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomTextField(
//                     // validator: validateName,
//                     hintText: "Old Password",
//                     filled: true,
//                     fillColor: context.colorScheme.surface,
//                     prefix: const Icon(Icons.person),
//                   ),
//                   20.kH,
//                   CustomTextField(
//                     // validator: validateEmail,
//                     hintText: "New Password",
//                     filled: true,
//                     fillColor: context.colorScheme.surface,
//                     prefix: const Icon(Icons.email),
//                   ),
//                   20.kH,
//                   CustomTextField(
//                     // validator: validateEmail,
//                     hintText: "Confirm Password",
//                     filled: true,
//                     fillColor: context.colorScheme.surface,
//                     prefix: const Icon(Icons.email),
//                   ),

//                   // CustomTextField(
//                   //   controller: _passwordController,
//                   //   // validator: validatePassword,
//                   //   hintText: "Password",
//                   //   filled: true,
//                   //   fillColor: themetextfieldcolor,
//                   //   obscureText: visiblePass,
//                   //   prefix: const Icon(Icons.lock),
//                   //   suffix: CustomIconButton(
//                   //     onTap: () {
//                   //       if (visiblePass == true) {
//                   //         setState(() {
//                   //           visiblePass = false;
//                   //         });
//                   //       } else if (visiblePass == false) {
//                   //         setState(() {
//                   //           visiblePass = true;
//                   //         });
//                   //       }
//                   //     },
//                   //     child: Icon(
//                   //       visiblePass == false
//                   //           ? CupertinoIcons.eye
//                   //           : CupertinoIcons.eye_fill,
//                   //       color: Palette.themecolor,
//                   //     ),
//                   //   ),
//                   // ),
//                   // 20.kH,
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
