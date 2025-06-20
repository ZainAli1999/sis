import 'dart:async';
import 'package:sis/core/common_widgets/custom_toast.dart';
import 'package:sis/core/enums/toast_enum.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sis/core/common_widgets/custom_button.dart';
import 'package:sis/core/common_widgets/custom_text_button.dart';
import 'package:sis/core/extensions/spacing_extension.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmailVerificationPageState();
}

class _EmailVerificationPageState extends ConsumerState<EmailVerificationPage> {
  StreamSubscription? _userChangesSubscription;

  @override
  void initState() {
    super.initState();

    _userChangesSubscription = FirebaseAuth.instance.userChanges().listen((
      user,
    ) async {
      if (user != null) {
        await user.reload();
        if (user.emailVerified && mounted) {
          showToast(
            content: "Email Verified Successfully",
            context: context,
            toastType: ToastType.success,
          );
          Go.namedReplace(context, RouteName.loginPage);
        }
      }
    });
  }

  @override
  void dispose() {
    _userChangesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(currentUserNotifierProvider)!;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Email Verification"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/svg/email-verification.svg",
                  width: 250,
                  fit: BoxFit.cover,
                ),
                50.kH,
                Text(
                  "Verify your email address!",
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.bold,
                ),
                15.kH,
                Text(
                  currentUser.email,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.w500,
                ),
                15.kH,
                Text(
                  "A verification email has been sent. Please verify your email address to continue.",
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.themeGreyTextColor,
                ),
                40.kH,
                CustomButton(
                  height: 55,
                  borderRadius: BorderRadius.circular(30),
                  onTap: () async {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .checkEmailVerification();
                  },
                  child: Text(
                    "Continue",
                    style: context.textTheme.bodySmall?.themeWhiteColor.bold,
                  ),
                ),
                20.kH,
                CustomTextButton(
                  buttonText: "Resend email",
                  buttonTextStyle: context.textTheme.bodySmall?.bold,
                  onTap: () async {
                    await ref
                        .read(authViewModelProvider.notifier)
                        .sendVerificationEmail();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
