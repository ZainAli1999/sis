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
import 'package:sis/core/theme/colors.dart';
import 'package:sis/core/utils/fields_validation.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class ChangeEmailPage extends ConsumerStatefulWidget {
  const ChangeEmailPage({super.key});

  @override
  ConsumerState<ChangeEmailPage> createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends ConsumerState<ChangeEmailPage> {
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _visiblePass = true;

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newEmailController.dispose();
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
                  "Email Changed Successfully. Please login with new email!",
              context: context,
              toastType: ToastType.success,
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
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomButton(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      await ref
                          .read(authViewModelProvider.notifier)
                          .changeEmail(
                            currentPassword: _currentPasswordController.text,
                            newEmail: _newEmailController.text,
                          );
                    } else {
                      showToast(
                        content: "Please enter a valid Email",
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
                      "Change Email?",
                      style: context.textTheme.headlineSmall?.w600,
                    ),
                  ),
                  20.kH,
                  Center(
                    child: Text(
                      "Change your email here",
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
                    hintText: "Current Password",
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
                  20.kH,
                  CustomTextField(
                    controller: _newEmailController,
                    validator: validateEmail,
                    hintText: "New Email",
                    labelText: "New Email",
                    labelTextStyle: context.textTheme.bodySmall,
                    filled: true,
                    fillColor: context.colorScheme.surface,
                    prefix: const Icon(Icons.email),
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
