import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/responsive/responsive.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  bool _visiblePass = true;

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            final user = ref.read(firebaseAuthProvider).currentUser;

            if (user != null) {
              if (user.emailVerified) {
                showToast(
                  content: 'Login Successfully!',
                  context: context,
                  toastType: ToastType.success,
                );
                Go.namedReplace(
                  context,
                  RouteName.homePage,
                );
              } else {
                showToast(
                  content:
                      "Your email address is not verified. A new verification link has been sent to your email address.",
                  context: context,
                  toastType: ToastType.success,
                );
                Go.namedReplace(
                  context,
                  RouteName.emailVerificationPage,
                );
              }
            }
          },
          error: (error, st) {
            showToast(
              content: error.toString(),
              context: context,
              toastType: ToastType.error,
            );
          },
          loading: () {},
        );
      },
    );
    return Stack(
      children: [
        Scaffold(
          body: _buildPageBody(),
        ),
        if (isLoading) const LoadingProgress(),
      ],
    );
  }

  Widget _buildPageBody() {
    return Center(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Responsive(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AutofillGroup(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        Constants.appLogo,
                        height: 200,
                      ),
                    ),
                    20.kH,
                    Text(
                      "Sign In",
                      style: context.textTheme.titleMedium?.bold,
                    ),
                    Text(
                      "Please enter your details to sign in",
                      style:
                          context.textTheme.bodySmall?.themeGreyTextColor.w500,
                    ),
                    20.kH,
                    CustomTextField(
                      controller: _emailController,
                      validator: validateEmail,
                      textCapitalization: TextCapitalization.none,
                      hintText: "Email",
                      filled: true,
                      fillColor: context.colorScheme.surface,
                      prefix: const Icon(Icons.email),
                      autofillHints: const [
                        AutofillHints.email,
                      ],
                    ),
                    20.kH,
                    CustomTextField(
                      controller: _passwordController,
                      validator: validatePassword,
                      textCapitalization: TextCapitalization.none,
                      hintText: "Password",
                      filled: true,
                      fillColor: context.colorScheme.surface,
                      obscureText: _visiblePass,
                      prefix: const Icon(Icons.lock),
                      suffix: CustomIconButton(
                        onTap: () {
                          if (_visiblePass == true) {
                            setState(() {
                              _visiblePass = false;
                            });
                          } else if (_visiblePass == false) {
                            setState(() {
                              _visiblePass = true;
                            });
                          }
                        },
                        child: Icon(
                          _visiblePass == false
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Palette.themecolor,
                        ),
                      ),
                    ),
                    10.kH,
                    Align(
                      alignment: Alignment.bottomRight,
                      child: CustomTextButton(
                        buttonText: "Forgot Password?",
                        buttonTextStyle:
                            context.textTheme.bodySmall?.themeColor.bold,
                        onTap: () {
                          Go.named(
                            context,
                            RouteName.forgotPasswordPage,
                          );
                        },
                      ),
                    ),
                    40.kH,
                    CustomButton(
                      height: 55,
                      buttoncolor: Palette.themecolor,
                      borderRadius: BorderRadius.circular(30),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .signInUser(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                        } else {
                          showToast(
                            content: 'Please fill all the fields',
                            context: context,
                            toastType: ToastType.error,
                          );
                        }
                      },
                      child: Text(
                        "Login",
                        style:
                            context.textTheme.bodyMedium?.themeWhiteColor.bold,
                      ),
                    ),
                    // 25.kH,
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Text.rich(
                    //     TextSpan(
                    //       text: "Not Registered? ",
                    //       style: context.textTheme.bodySmall?.themeGreyTextColor,
                    //       children: [
                    //         TextSpan(
                    //           recognizer: TapGestureRecognizer()
                    //             ..onTap = () => Go.onNamedReplace(
                    //                   context,
                    //                   RouteName.signupPage,
                    //                 ),
                    //           text: "Create an account",
                    //           style: context.textTheme.bodySmall?.themeColor.bold,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // 20.kH,
                    // Center(
                    //   child: Text(
                    //     "OR",
                    //     style: context.textTheme.bodyLarge?.bold,
                    //   ),
                    // ),
                    // 20.kH,
                    // FadeInUp(
                    //   child: CustomButton(
                    //     onTap: () {},
                    //     height: 50,
                    //     buttoncolor: themegreycolor,
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         SvgPicture.asset(
                    //           "assets/images/svg/google.svg",
                    //           height: 30,
                    //           width: 30,
                    //           fit: BoxFit.cover,
                    //         ),
                    //         10.kW,
                    //         Text(
                    //           "Continue with Google",
                    //           style: context
                    //               .textTheme.bodyMedium?.themeBlackColor.bold,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // FadeInLeft(
                    //   child: CustomButton(
                    //     height: 55,
                    //     border: Border.all(
                    //       color: themegreytextcolor,
                    //     ),
                    //     buttoncolor: Colors.transparent,
                    //     borderRadius: BorderRadius.circular(30),
                    //     child: Text(
                    //       "Create a New Account",
                    //       style: TextStyle(
                    //         color: Theme.of(context).colorScheme.secondary,
                    //         fontSize: mediumfontsize1,
                    //         fontWeight: boldfontweight,
                    //       ),
                    //     ),
                    //     onTap: () {
                    //       Go.onNamedReplace(
                    //         context,
                    //         RouteName.signupPage,
                    //       );
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
