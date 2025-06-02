// import 'package:flutter/material.dart';
// import 'package:responsive_framework/responsive_framework.dart';

// class ResponsiveContainer extends StatelessWidget {
//   final Widget child;

//   const ResponsiveContainer({super.key, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return MaxWidthBox(
//       maxWidth: 1200,
//       child: ResponsiveScaledBox(
//         // Define width based on conditions with a default value for large screens
//         width: ResponsiveValue<double>(
//           // defaultValue: 1200,
//           context,
//           conditionalValues: [
//             const Condition.equals(name: 'MOBILE', value: 450),
//             const Condition.between(start: 800, end: 1100, value: 800),
//             const Condition.between(start: 1000, end: 1200, value: 1000),
//             const Condition.largerThan(
//                 name: 'DESKTOP', value: 1200), // Handle large screens
//           ],
//         ).value,
//         child: child,
//       ),
//     );
//   }
// }
