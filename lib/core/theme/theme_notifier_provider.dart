import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sis/core/theme/colors.dart';

part 'theme_notifier_provider.g.dart';

@Riverpod(keepAlive: true)
class ThemeNotifier extends _$ThemeNotifier {
  ThemeMode _mode = ThemeMode.light;

  @override
  Future<ThemeData> build() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme');

    if (theme == 'dark') {
      _mode = ThemeMode.dark;
      return Palette.darkModeAppTheme;
    } else {
      _mode = ThemeMode.light;
      return Palette.lightModeAppTheme;
    }
  }

  ThemeMode get mode => _mode;

  Future<void> toggleTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
      state = AsyncValue.data(Palette.lightModeAppTheme);
      await prefs.setString('theme', 'light');
    } else {
      _mode = ThemeMode.dark;
      state = AsyncValue.data(Palette.darkModeAppTheme);
      await prefs.setString('theme', 'dark');
    }
  }
}
