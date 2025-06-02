// import 'package:flutter/material.dart';
// import 'package:sis/core/common_widgets/custom_button.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';

// class FAQPage extends StatefulWidget {
//   const FAQPage({super.key});

//   @override
//   State<FAQPage> createState() => _FAQPageState();
// }

// class _FAQPageState extends State<FAQPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: CustomButton(
//             height: 55,
//             buttoncolor: Palette.themecolor,
//             borderRadius: BorderRadius.circular(30),
//             onTap: () {},
//             child: Text(
//               "Submit Your Question",
//               style: context.textTheme.bodySmall?.themeWhiteColor.bold,
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Frequently Asked Questions:',
//                   style: context.textTheme.headlineMedium?.bold,
//                 ),
//                 20.kH,
//                 _buildFAQSection(
//                   "Pineapple related questions:",
//                   [
//                     _buildCustomQuestion(
//                       "How do I update my Pineapple?",
//                     ),
//                     _buildCustomQuestion(
//                       "How do I switch off my Pineapple?",
//                       content: true,
//                     ),
//                     _buildCustomQuestion(
//                       "How do I reset my Pineapple?",
//                     ),
//                   ],
//                 ),
//                 _buildFAQSection(
//                   "System related questions:",
//                   [
//                     _buildCustomQuestion(
//                       "How to resolve system errors?",
//                     ),
//                   ],
//                 ),
//                 _buildFAQSection(
//                   "Support related questions:",
//                   [
//                     _buildCustomQuestion(
//                       "How do I contact support?",
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Custom widget to build each question section without the default icons
//   Widget _buildFAQSection(
//     String title,
//     List<Widget> children,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: context.colorScheme.surface,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Theme(
//         data: ThemeData().copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           title: Text(
//             title,
//             style: context.textTheme.bodySmall?.bold,
//           ),
//           tilePadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           trailing: const SizedBox.shrink(), // Remove default arrow icon
//           children: children,
//         ),
//       ),
//     );
//   }

//   // Custom question without expansion icon
//   Widget _buildCustomQuestion(String question, {bool content = false}) {
//     return Container(
//       decoration: BoxDecoration(
//         color: context.colorScheme.primary,
//         borderRadius: BorderRadius.circular(15),
//       ),
//       margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//       child: Theme(
//         data: ThemeData().copyWith(dividerColor: Colors.transparent),
//         child: ExpansionTile(
//           title: Text(
//             question,
//             style: context.textTheme.labelLarge,
//           ),
//           tilePadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//           trailing: Icon(
//             Icons.expand_more,
//             color: Colors.grey.shade600,
//           ), // Minimalist icon for expansion
//           children: content
//               ? [
//                   Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                     child: Text(
//                       'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
//                       style: context.textTheme.labelLarge?.themeGreyTextColor,
//                     ),
//                   )
//                 ]
//               : [],
//         ),
//       ),
//     );
//   }
// }
