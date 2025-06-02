import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sis/core/providers/current_user_notifier.dart';
import 'package:sis/core/route_structure/go_navigator.dart';
import 'package:sis/core/route_structure/go_router.dart';
import 'package:sis/core/utils/constants.dart';
import 'package:sis/features/auth/viewmodel/auth_viewmodel.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    final user = ref.read(currentUserNotifierProvider);

    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (!mounted) return;

        if (user == null) {
          Go.namedReplace(
            context,
            RouteName.loginPage,
          );
        } else if (user.status != 1) {
          await ref.read(authViewModelProvider.notifier).logout();
          if (!mounted) return;
          Go.namedReplace(
            context,
            RouteName.loginPage,
          );
        } else {
          Go.namedReplace(
            context,
            RouteName.homePage,
          );
        }
      },
    );
    super.initState();
  }

  void checkUser() {}

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
