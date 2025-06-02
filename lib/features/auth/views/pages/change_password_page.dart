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
import 'package:sis/core/utils/failure.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _currentVisiblePass = true;
  bool _newVisiblePass = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
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
                  "Password Changed Successfully. Please login with new password!",
              context: context,
              toastType: ToastType.success,
            );
          },
          error: (error, st) {
            final failure = error as Failure;
            showToast(
              content: failure.toString(),
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
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(authViewModelProvider.notifier)
                          .changePassword(
                            currentPassword: _currentPasswordController.text,
                            newPassword: _newPasswordController.text,
                          );
                    } else {
                      showToast(
                        content: "Please enter a valid Password",
                        context: context,
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Change Password?",
                      style: context.textTheme.headlineSmall?.w600,
                    ),
                  ),
                  20.kH,
                  Center(
                    child: Text(
                      "Change your password here",
                      textAlign: TextAlign.center,
                      style: context.textTheme.bodySmall,
                    ),
                  ),
                  40.kH,
                  SvgPicture.asset(
                    "assets/images/svg/change-password.svg",
                    height: 350,
                  ),
                  30.kH,
                  CustomTextField(
                    controller: _currentPasswordController,
                    validator: validatePassword,
                    labelText: "Current Password",
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    obscureText: _currentVisiblePass,
                    suffix: CustomIconButton(
                      onTap: () {
                        if (_currentVisiblePass == true) {
                          setState(() {
                            _currentVisiblePass = false;
                          });
                        } else if (_currentVisiblePass == false) {
                          setState(() {
                            _currentVisiblePass = true;
                          });
                        }
                      },
                      child: Icon(
                        _currentVisiblePass == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
                  20.kH,
                  CustomTextField(
                    controller: _newPasswordController,
                    validator: validatePassword,
                    labelText: "New Password",
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    obscureText: _newVisiblePass,
                    suffix: CustomIconButton(
                      onTap: () {
                        if (_newVisiblePass == true) {
                          setState(() {
                            _newVisiblePass = false;
                          });
                        } else if (_newVisiblePass == false) {
                          setState(() {
                            _newVisiblePass = true;
                          });
                        }
                      },
                      child: Icon(
                        _newVisiblePass == false
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.colorScheme.secondary,
                      ),
                    ),
                  ),
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
