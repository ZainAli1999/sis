// import 'package:flutter/material.dart';
// import 'package:sis/core/common_widgets/custom_text_field.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';

// class HelpCenterPage extends StatefulWidget {
//   const HelpCenterPage({super.key});

//   @override
//   State<HelpCenterPage> createState() => _HelpCenterPageState();
// }

// class _HelpCenterPageState extends State<HelpCenterPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(
//           'Help Center',
//           style: context.textTheme.bodyMedium?.bold,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
//           child: Container(
//             padding: const EdgeInsets.all(20.0),
//             decoration: BoxDecoration(
//               color: context.colorScheme.primary,
//               borderRadius: BorderRadius.circular(25.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: context.colorScheme.secondary.withOpacity(0.15),
//                   blurRadius: 15,
//                   offset: const Offset(5, 5),
//                 ),
//                 BoxShadow(
//                   color: context.colorScheme.primary.withOpacity(0.9),
//                   blurRadius: 15,
//                   offset: const Offset(-5, -5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title
//                 Text(
//                   'Submit Your Issue',
//                   style: context.textTheme.titleMedium?.bold,
//                 ),
//                 20.kH,
//                 // Name Field
//                 CustomTextField(
//                   // validator: validateEmail,
//                   hintText: "Name",
//                   filled: true,
//                   fillColor: context.colorScheme.surface,
//                   prefix: const Icon(Icons.person_outline),
//                 ),
//                 20.kH,
//                 // Email Field
//                 CustomTextField(
//                   // validator: validateEmail,
//                   hintText: "Email",
//                   filled: true,
//                   fillColor: context.colorScheme.surface,
//                   prefix: const Icon(
//                     Icons.email_outlined,
//                   ),
//                 ),
//                 20.kH,
//                 // Subject Field
//                 CustomTextField(
//                   // validator: validateEmail,
//                   hintText: "Subject",
//                   filled: true,
//                   fillColor: context.colorScheme.surface,
//                   prefix: const Icon(Icons.subject),
//                 ),
//                 20.kH,
//                 // Description Field
//                 CustomTextField(
//                   // validator: validateEmail,
//                   hintText: "Description",
//                   maxLines: 5,
//                   alignLabelWithHint: true,
//                   filled: true,
//                   fillColor: context.colorScheme.surface,
//                   prefix: const Padding(
//                     padding: EdgeInsets.only(bottom: 95),
//                     child: Icon(Icons.description_outlined),
//                   ),
//                 ),
//                 30.kH,
//                 Center(
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       width: 180,
//                       height: 50,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [
//                             Palette.themecolor,
//                             Palette.themecolor.withOpacity(0.4)
//                           ],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(30),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Palette.themecolor.withOpacity(0.3),
//                             blurRadius: 10,
//                             offset: const Offset(5, 5),
//                           ),
//                           BoxShadow(
//                             color: context.colorScheme.primary.withOpacity(0.8),
//                             blurRadius: 10,
//                             offset: const Offset(-5, -5),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Submit',
//                           style: context
//                               .textTheme.bodyMedium?.themeWhiteColor.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper function to create Input Fields with neumorphic design
//   Widget buildInputField(BuildContext context, String label, IconData icon,
//       {int maxLines = 1,
//       TextInputType? keyboardType,
//       required Function(String?) onSaved,
//       required String? Function(String?) validator}) {
//     return Column(
//       children: [
//         TextFormField(
//           decoration: InputDecoration(
//             labelText: label,
//             prefixIcon: Icon(icon, color: Colors.blueAccent),
//             filled: true,
//             fillColor: const Color(0xFFF2F3F7),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15.0),
//               borderSide: BorderSide.none,
//             ),
//             contentPadding:
//                 const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
//           ),
//           maxLines: maxLines,
//           keyboardType: keyboardType,
//           validator: validator,
//           onSaved: onSaved,
//         ),
//         const SizedBox(height: 20.0),
//       ],
//     );
//   }
// }
