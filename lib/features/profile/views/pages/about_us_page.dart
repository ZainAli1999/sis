// import 'package:flutter/material.dart';
// import 'package:sis/core/common_widgets/custom_cached_network_image.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';
// import 'package:sis/core/utils/constants.dart';

// class AboutUsPage extends StatefulWidget {
//   const AboutUsPage({super.key});

//   @override
//   State<AboutUsPage> createState() => _AboutUsPageState();
// }

// class _AboutUsPageState extends State<AboutUsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('About Us'),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Center(
//               child: Image.asset(
//                 Constants.appLogo,
//                 height: 200,
//               ),
//             ),
//             16.kH,
//             Text(
//               'Who We Are',
//               style: context.textTheme.headlineSmall?.themeColor.bold,
//             ),
//             8.kH,
//             Text(
//               'We are a passionate team of professionals dedicated to providing the best solutions to our clients. Our focus is on delivering high-quality services that make a difference.',
//               style: context.textTheme.bodySmall?.copyWith(height: 1.5),
//             ),
//             const Divider(
//               height: 40,
//             ),
//             Text(
//               'Meet the Team',
//               style: context.textTheme.titleMedium?.themeColor.bold,
//             ),
//             8.kH,
//             buildTeamMember(
//               name: 'John Doe',
//               role: 'CEO',
//               imagePath: 'assets/john_doe.png',
//             ),
//             buildTeamMember(
//               name: 'Jane Smith',
//               role: 'CTO',
//               imagePath: 'assets/jane_smith.png',
//             ),
//             buildTeamMember(
//               name: 'Mark Johnson',
//               role: 'Lead Developer',
//               imagePath: 'assets/mark_johnson.png',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildTeamMember({
//     required String name,
//     required String role,
//     required String imagePath,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         children: [
//           CustomCachedNetworkImage(
//             imageUrl:
//                 'https://img.freepik.com/free-photo/medium-shot-man-working-as-real-estate-agent_23-2151064978.jpg',
//             imageBuilder: (context, imageProvider) {
//               return CircleAvatar(
//                 radius: 40,
//                 backgroundImage: imageProvider,
//               );
//             },
//             animChild: const CircleAvatar(
//               backgroundColor: themegreycolor,
//               radius: 40,
//             ),
//           ),
//           16.kW,
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 name,
//                 style: context.textTheme.bodyMedium?.bold,
//               ),
//               Text(
//                 role,
//                 style: context.textTheme.labelLarge,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
