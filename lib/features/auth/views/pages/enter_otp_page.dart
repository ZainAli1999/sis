// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pinput/pinput.dart';
// import 'package:sis/core/extensions/screen_size_extension.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/theme/colors.dart';

// class EnterOtpPage extends ConsumerStatefulWidget {
//   const EnterOtpPage({
//     super.key,
//   });

//   @override
//   ConsumerState<EnterOtpPage> createState() => _EnterOtpPageState();
// }

// class _EnterOtpPageState extends ConsumerState<EnterOtpPage> {
//   var code = "";
//   // void verifyOtp() async {
//   //   if (code.length == 6) {
//   //     final verificationId =
//   //         ref.read(userInfoNotifierProvider.notifier).getVerificationId();

//   //     if (verificationId != null) {
//   //       ref.read(authViewModelProvider.notifier).verifyOtp(
//   //             verificationId: verificationId,
//   //             otpCode: code.trim(),
//   //           );
//   //     } else {
//   //       showSnackBar(context, "Verification ID is not available.");
//   //     }
//   //   } else {
//   //     showSnackBar(context, "Please enter a valid 6-digit OTP.");
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final defaultPinTheme = PinTheme(
//       width: context.screenWidth / 100 * 18,
//       height: 80,
//       textStyle: context.textTheme.titleMedium?.themeColor.w600,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border: Border.all(color: themegreycolor),
//         borderRadius: BorderRadius.circular(20),
//       ),
//     );
//     final focusedPinTheme = defaultPinTheme.copyDecorationWith(
//       border: Border.all(color: Palette.themecolor),
//       borderRadius: BorderRadius.circular(20),
//     );

//     final submittedPinTheme = defaultPinTheme.copyWith(
//       decoration: defaultPinTheme.decoration?.copyWith(
//         color: Palette.themecolor.withOpacity(0.9),
//       ),
//       textStyle: context.textTheme.titleMedium?.themeWhiteColor.w600,
//     );

//     // final isLoading = ref
//     //     .watch(authViewModelProvider.select((val) => val?.isLoading == true));

//     // // Listen for the OTP verification result
//     // ref.listen(
//     //   authViewModelProvider,
//     //   (_, next) {
//     //     next?.when(
//     //       data: (data) {
//     //         showSnackBar(
//     //           context,
//     //           'OTP Verified',
//     //         );
//     //         Go.namedReplace(
//     //           context,
//     //           RouteName.homePage,
//     //         );
//     //       },
//     //       error: (error, st) {
//     //         showSnackBar(context, error.toString());
//     //       },
//     //       loading: () {},
//     //     );
//     //   },
//     // );
//     // final userInfo = ref.watch(userInfoNotifierProvider);

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(40.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Enter your OTP code",
//                       style: context.textTheme.titleMedium?.bold,
//                     ),
//                     const SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       "We just sent you a verification code via phone",
//                       style: context.textTheme.labelLarge?.w400,
//                     ),
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       "+921234567890",
//                       style: context.textTheme.labelLarge?.w400,
//                     ),
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     Center(
//                       child: Pinput(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         length: 6,
//                         defaultPinTheme: defaultPinTheme,
//                         focusedPinTheme: focusedPinTheme,
//                         submittedPinTheme: submittedPinTheme,
//                         onChanged: (value) {
//                           code = value; // Save the code entered by the user
//                         },
//                         showCursor: true,
//                         onCompleted: (pin) {
//                           // Trigger OTP verification when the code is completed
//                           // verifyOtp();
//                         },
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Center(
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // verifyOtp();
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Palette.themecolor,
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 20,
//                             horizontal: 100,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                         ),
//                         child: Text(
//                           "Verify",
//                           style: context
//                               .textTheme.bodyMedium?.themeWhiteColor.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Center(
//                       child: Text.rich(
//                         TextSpan(
//                           text: "Didn’t receive the code? ",
//                           style: context.textTheme.labelLarge?.w400,
//                           children: [
//                             TextSpan(
//                               text: "Resend",
//                               style:
//                                   context.textTheme.bodySmall?.themeColor.bold,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
