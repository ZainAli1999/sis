import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_icon_button.dart';
import 'package:sis/core/common_widgets/custom_text_field.dart';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/common_widgets/loading_progress.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            showToast(
              content:
                  "New Password link has been sent to your email address. Please Verify",
              context: context,
              toastType: ToastType.success,
            );
            Go.namedReplace(
              context,
              RouteName.loginPage,
            );
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
          appBar: AppBar(
            leading: CustomIconButton(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.close,
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(authViewModelProvider.notifier)
                          .forgotPassword(
                            email: _emailController.text,
                          );
                    } else {
                      showToast(
                        context: context,
                        content: "Please enter a valid Email",
                        toastType: ToastType.error,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Text(
                    "Done",
                    style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                  ),
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Forgot password?",
                      style: context.textTheme.headlineSmall?.w600,
                    ),
                  ),
                  20.kH,
                  Center(
                    child: Text(
                      "Please enter your email address below and we will help you recover your account.",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                  40.kH,
                  SvgPicture.asset(
                    "assets/images/svg/forgot-password.svg",
                    height: 350,
                  ),
                  30.kH,
                  CustomTextField(
                    controller: _emailController,
                    validator: validateEmail,
                    labelText: "Email",
                    labelTextStyle: context.textTheme.bodySmall,
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    prefix: const Icon(Icons.email),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        if (isLoading) const LoadingProgress(),
      ],
    );
  }
}
