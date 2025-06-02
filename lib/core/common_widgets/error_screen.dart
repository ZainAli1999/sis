import 'package:flutter/material.dart';
import 'package:sis/core/extensions/text_style_extension.dart';
import 'package:sis/core/extensions/theme_extension.dart';
// import 'package:lottie/lottie.dart';

class ErrorScreen extends StatefulWidget {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Page Not Found",
                  style: context.textTheme.headlineSmall?.bold,
                ),
              ),
              // Align(
              //   alignment: Alignment.center,
              //   child: Lottie.asset(
              //     "assets/images/animated/error.json",
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
