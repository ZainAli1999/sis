// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:sis/core/common_widgets/country/country_model.dart';
// import 'package:sis/core/common_widgets/country/show_custom_country_picker.dart';
// import 'package:sis/core/common_widgets/snack_bar.dart';
// import 'package:sis/core/extensions/text_style_extension.dart';
// import 'package:sis/core/common_widgets/hyphen_text_input_formatter.dart';
// import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:sis/core/route_structure/go_navigator.dart';
// import 'package:sis/core/route_structure/go_router.dart';
// import 'package:sis/core/theme/colors.dart';
// import 'package:sis/core/extensions/spacing_extension.dart';
// import 'package:sis/core/common_widgets/custom_button.dart';
// import 'package:sis/core/common_widgets/custom_icon_button.dart';
// import 'package:sis/core/common_widgets/custom_text_field.dart';
// import 'package:sis/core/utils/constants.dart';
// import 'package:sis/core/utils/fields_validation.dart';
// import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

// class SignUpPage extends ConsumerStatefulWidget {
//   const SignUpPage({
//     super.key,
//   });

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends ConsumerState<SignUpPage> {
//   bool _visiblePass = true;
//   bool _confirmVisiblePass = true;

//   CountryModel selectedCountry =
//       CountryModel(name: 'Pakistan', code: '+92', flag: '🇵🇰');
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _designationController = TextEditingController();
//   final _cnicController = TextEditingController();
//   final _phoneNumberController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   // void pickCountry(ColorScheme colorScheme, Size size) {
//   //   showCountryPicker(
//   //       context: context,
//   //       useSafeArea: true,
//   //       moveAlongWithKeyboard: true,
//   //       countryListTheme: CountryListThemeData(
//   //         borderRadius: BorderRadius.circular(16),
//   //         bottomSheetHeight: size.height / 100 * 70,
//   //         backgroundColor: colorScheme.surface,
//   //         textStyle: TextStyle(
//   //           color: colorScheme.secondary,
//   //         ),
//   //         searchTextStyle: TextStyle(
//   //           color: colorScheme.secondary,
//   //         ),
//   //         inputDecoration: InputDecoration(
//   //           contentPadding: const EdgeInsets.symmetric(
//   //             vertical: 10,
//   //             horizontal: 12,
//   //           ),
//   //           prefix: Icon(
//   //             Icons.search,
//   //             color: colorScheme.secondary,
//   //             size: 20,
//   //           ),
//   //           hintText: "Search",
//   //           hintStyle: TextStyle(
//   //             color: colorScheme.secondary,
//   //           ),
//   //           enabledBorder: OutlineInputBorder(
//   //             borderSide: BorderSide(
//   //               color: colorScheme.secondary,
//   //             ),
//   //             borderRadius: BorderRadius.circular(12),
//   //           ),
//   //           focusedBorder: OutlineInputBorder(
//   //             borderSide: BorderSide(
//   //               color: colorScheme.secondary,
//   //             ),
//   //             borderRadius: BorderRadius.circular(12),
//   //           ),
//   //         ),
//   //       ),
//   //       onSelect: (Country onSelectCountry) {
//   //         setState(() {
//   //           country = onSelectCountry;
//   //         });
//   //       });
//   // }

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _cnicController.dispose();
//     _phoneNumberController.dispose();
//     _designationController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   final _formKey = GlobalKey<FormState>();

//   final String _pattern = r'^\d{5}-\d{8}-\d$'; // Pattern: 11111-555555re55-3

//   bool _validateInput() {
//     final regex = RegExp(_pattern);
//     return regex.hasMatch(_cnicController.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final userInfo = ref.watch(userInfoNotifierProvider);

//     final isLoading = ref
//         .watch(authViewModelProvider.select((val) => val?.isLoading == true));

//     ref.listen(
//       authViewModelProvider,
//       (_, next) {
//         next?.when(
//           data: (data) {
//             showSnackBar(context, 'Registered Successfully!');
//             Go.namedReplace(
//               context,
//               RouteName.homePage,
//             );
//           },
//           error: (error, st) {
//             showSnackBar(context, error.toString());
//           },
//           loading: () {},
//         );
//       },
//     );
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           SliverLayoutBuilder(
//             builder: (context, constraints) {
//               final scrolled = constraints.scrollOffset > 80;
//               return SliverAppBar(
//                 pinned: true,
//                 elevation: 0,
//                 centerTitle: true,
//                 title: Text(
//                   scrolled ? "Hi there Register Yourself" : "",
//                 ),
//                 leading: CustomIconButton(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Icon(
//                       Icons.arrow_back,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//           SliverToBoxAdapter(
//             child: Form(
//               key: _formKey,
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     FadeInLeft(
//                       child: Text(
//                         "Hi there! \nRegister Yourself",
//                         style: context.textTheme.headlineSmall?.bold,
//                       ),
//                     ),
//                     20.kH,
//                     Center(
//                       child: Image.asset(
//                         Constants.appLogo,
//                         height: 200,
//                       ),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _firstNameController,
//                       validator: validateName,
//                       hintText: "First Name",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.person),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _lastNameController,
//                       validator: validateName,
//                       hintText: "Last Name",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.person),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _designationController,
//                       validator: validateField,
//                       hintText: "Designation",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.email),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _cnicController,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                         HyphenTextInputFormatter(),
//                       ],
//                       textInputType: TextInputType.number,
//                       validator: validateCnic,
//                       hintText: "CNIC",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Padding(
//                         padding: EdgeInsets.only(
//                           left: 12,
//                           right: 10,
//                         ),
//                         child: FaIcon(
//                           FontAwesomeIcons.idCard,
//                           size: 15,
//                         ),
//                       ),
//                       prefixIconConstraints: const BoxConstraints(
//                         minWidth: 0,
//                         minHeight: 0,
//                       ),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _phoneNumberController,
//                       validator: validatePhone,
//                       prefix: GestureDetector(
//                         onTap: () {
//                           showCustomCountryPicker(context,
//                               (CountryModel country) {
//                             setState(() {
//                               selectedCountry = country;
//                             });
//                           });
//                           // pickCountry(colorScheme, size);
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 8,
//                           ),
//                           child: Text(
//                             selectedCountry.code,
//                             style: context.textTheme.bodySmall?.bold,
//                           ),
//                         ),
//                       ),
//                       textInputType: TextInputType.phone,
//                       hintText: "Phone Number",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefixIconConstraints: const BoxConstraints(
//                         minWidth: 0,
//                         minHeight: 0,
//                       ),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _emailController,
//                       validator: validateEmail,
//                       hintText: "Email",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.email),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _passwordController,
//                       validator: validatePassword,
//                       hintText: "Password",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.password),
//                       obscureText: _visiblePass,
//                       suffix: CustomIconButton(
//                         onTap: () {
//                           setState(() {
//                             _visiblePass = !_visiblePass;
//                           });
//                         },
//                         child: Icon(
//                           _visiblePass == false
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Palette.themecolor,
//                         ),
//                       ),
//                     ),
//                     20.kH,
//                     CustomTextField(
//                       controller: _confirmPasswordController,
//                       validator: validatePassword,
//                       hintText: "Confirm Password",
//                       filled: true,
//                       fillColor: context.colorScheme.surface,
//                       prefix: const Icon(Icons.password),
//                       obscureText: _confirmVisiblePass,
//                       suffix: CustomIconButton(
//                         onTap: () {
//                           setState(() {
//                             _confirmVisiblePass = !_confirmVisiblePass;
//                           });
//                         },
//                         child: Icon(
//                           _confirmVisiblePass == false
//                               ? Icons.visibility
//                               : Icons.visibility_off,
//                           color: Palette.themecolor,
//                         ),
//                       ),
//                     ),
//                     40.kH,
//                     FadeInRight(
//                       child: CustomButton(
//                         height: 55,
//                         buttoncolor: Palette.themecolor,
//                         borderRadius: BorderRadius.circular(30),
//                         onTap: () async {
//                           String phoneNumber =
//                               _phoneNumberController.text.trim();
//                           if (_formKey.currentState!.validate() &&
//                               _passwordController.text ==
//                                   _confirmPasswordController.text) {
//                             await ref
//                                 .read(authViewModelProvider.notifier)
//                                 .signUpUser(
//                                   firstName: _firstNameController.text,
//                                   lastName: _lastNameController.text,
//                                   phoneNumber:
//                                       '${selectedCountry.code}$phoneNumber',
//                                   cnic: _cnicController.text,
//                                   designation: _designationController.text,
//                                   email: _emailController.text,
//                                   password: _passwordController.text,
//                                 );
//                           } else {
//                             showSnackBar(
//                               context,
//                               'Please fill all the fields',
//                             );
//                           }
//                         },
//                         child: isLoading
//                             ? const Center(
//                                 child: CircularProgressIndicator(
//                                   color: themewhitecolor,
//                                 ),
//                               )
//                             : Text(
//                                 "Register",
//                                 style: context
//                                     .textTheme.bodyMedium?.themeWhiteColor.bold,
//                               ),
//                       ),
//                     ),
//                     20.kH,
//                     Text(
//                       "By clicking register you are clicking to the terms and conditions, privacy policy",
//                       textAlign: TextAlign.center,
//                       style: context.textTheme.bodySmall?.themeGreyTextColor,
//                     ),
//                     50.kH,
//                     Align(
//                       alignment: Alignment.center,
//                       child: Text.rich(
//                         TextSpan(
//                           text: "Already have an account? ",
//                           style:
//                               context.textTheme.bodySmall?.themeGreyTextColor,
//                           children: [
//                             TextSpan(
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () => Go.onNamedReplace(
//                                       context,
//                                       RouteName.loginPage,
//                                     ),
//                               text: "Login",
//                               style:
//                                   context.textTheme.bodySmall?.themeColor.bold,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     20.kH,
//                     Center(
//                       child: Text(
//                         "OR",
//                         style: context.textTheme.bodyLarge?.bold,
//                       ),
//                     ),
//                     20.kH,
//                     FadeInUp(
//                       child: CustomButton(
//                         onTap: () {},
//                         height: 50,
//                         buttoncolor: themegreycolor,
//                         borderRadius: BorderRadius.circular(30),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             SvgPicture.asset(
//                               "assets/images/svg/google.svg",
//                               height: 30,
//                               width: 30,
//                               fit: BoxFit.cover,
//                             ),
//                             10.kW,
//                             Text(
//                               "Signup with Google",
//                               style: context
//                                   .textTheme.bodyMedium?.themeBlackColor.bold,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
