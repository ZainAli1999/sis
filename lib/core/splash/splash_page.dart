import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/providers/firebase_providers.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';
// import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    await Future.delayed(const Duration(seconds: 2));

    final firebaseUser = ref.read(firebaseAuthProvider).currentUser;
    final currentUser = ref.read(currentUserNotifierProvider);

    if (!mounted) return;

    if (firebaseUser == null) {
      Go.namedReplace(context, RouteName.loginPage);
      return;
    }

    if (!firebaseUser.emailVerified) {
      Go.namedReplace(context, RouteName.emailVerificationPage);
      return;
    }

    if (currentUser == null || currentUser.status != 1) {
      await ref.read(authViewModelProvider.notifier).logout();
      if (!mounted) return;
      Go.namedReplace(context, RouteName.loginPage);
      return;
    }

    Go.namedReplace(context, RouteName.homePage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  Constants.appLogo,
                  height: 250,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
