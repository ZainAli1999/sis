// import 'package:flutter/material.dart';
// import 'package:sis/core/common_widgets/custom_button.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';

// class TermsConditionsPage extends StatefulWidget {
//   const TermsConditionsPage({super.key});

//   @override
//   State<TermsConditionsPage> createState() => _TermsConditionsPageState();
// }

// class _TermsConditionsPageState extends State<TermsConditionsPage> {
//   final List<Map<String, String>> terms = [
//     {
//       'title': '1. Introduction',
//       'content':
//           'Welcome to our mobile application. By accessing our app, you agree to the following terms.'
//     },
//     {
//       'title': '2. Intellectual Property Rights',
//       'content':
//           'We own all the intellectual property rights and materials contained in this app.'
//     },
//     {
//       'title': '3. Restrictions',
//       'content':
//           'You are specifically restricted from publishing any app material in any other media without consent.'
//     },
//     {
//       'title': '4. User Content',
//       'content':
//           'Any audio, video, text, images, or other material you choose to display will be in line with these terms.'
//     },
//     {
//       'title': '5. Limitation of Liability',
//       'content':
//           'In no event shall we, nor any of our officers, be held liable for anything arising out of your use of this app.'
//     },
//     {
//       'title': '6. Termination',
//       'content':
//           'We may terminate access to the app without notice for conduct that violates these terms.'
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Terms and Conditions',
//           style: context.textTheme.bodyMedium
//               ?.bold,
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(20),
//         children: terms.map((term) {
//           return Container(
//             margin: const EdgeInsets.only(bottom: 16),
//             decoration: BoxDecoration(
//               color: context.colorScheme.surface,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: Theme(
//               data: ThemeData().copyWith(dividerColor: Colors.transparent),
//               child: ExpansionTile(
//                 title: Text(
//                   term['title']!,
//                   style: context.textTheme.bodySmall?.bold,
//                 ),
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Text(
//                       term['content']!,
//                       style: context.textTheme.bodySmall?.themeGreyTextColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Expanded(
//               child: CustomButton(
//                 height: 45,
//                 buttoncolor: Palette.themecolor,
//                 borderRadius: BorderRadius.circular(30),
//                 onTap: () {},
//                 child: Text(
//                   "I Accept",
//                   style: context.textTheme.bodySmall?.themeWhiteColor.bold,
//                 ),
//               ),
//             ),
//             8.kW,
//             Expanded(
//               child: CustomButton(
//                 height: 45,
//                 buttoncolor: transparentcolor,
//                 border: Border.all(color: context.colorScheme.secondary),
//                 borderRadius: BorderRadius.circular(30),
//                 onTap: () {},
//                 child: Text(
//                   "Decline",
//                   style: context.textTheme.bodySmall?.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
