import 'package:flutter/material.dart';
import 'package:sis/core/utils/constants.dart';

class Palette {
  static const Color themecolor = Color(0xff2FA09C);
  // static const MaterialColor themecolor = MaterialColor(
  //   0xffFDD51B, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
  //   <int, Color>{
  //     50: Color(0xffFFC62A), //10%
  //     100: Color(0xffFFFFFF), //20%
  //     200: Color(0xffFFFFFF), //30%
  //     300: Color(0xffFFFFFF), //40%
  //     400: Color(0xffFFFFFF), //50%
  //     500: Color(0xffFFFFFF), //60%
  //     600: Color(0xffFFFFFF), //70%
  //     700: Color(0xffFFFFFF), //80%
  //     800: Color(0xffFFFFFF), //90%
  //     900: Color(0xffFFFFFF), //100%
  //   },
  // );
  static var darkModeAppTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Constants.appFontFamily,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: themewhitecolor,
        fontSize: 48,
      ),
      displayMedium: TextStyle(
        color: themewhitecolor,
        fontSize: 44,
      ),
      displaySmall: TextStyle(
        color: themewhitecolor,
        fontSize: 40,
      ),
      headlineLarge: TextStyle(
        color: themewhitecolor,
        fontSize: 36,
      ),
      headlineMedium: TextStyle(
        color: themewhitecolor,
        fontSize: 32,
      ),
      headlineSmall: TextStyle(
        color: themewhitecolor,
        fontSize: 28,
      ),
      titleLarge: TextStyle(
        color: themewhitecolor,
        fontSize: 26,
      ),
      titleMedium: TextStyle(
        color: themewhitecolor,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        color: themewhitecolor,
        fontSize: 22,
      ),
      bodyLarge: TextStyle(
        color: themewhitecolor,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: themewhitecolor,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: themewhitecolor,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: themewhitecolor,
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        color: themewhitecolor,
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        color: themewhitecolor,
        fontSize: 10,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: themeblackcolor,
      surfaceTintColor: themeblackcolor,
      iconTheme: IconThemeData(
        color: themewhitecolor,
      ),
      titleTextStyle: TextStyle(
        color: themewhitecolor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: Constants.appFontFamily,
      ),
    ),
  ).copyWith(
    scaffoldBackgroundColor: themeblackcolor,
    cardTheme: const CardThemeData(
      color: themeblackcolor,
      shadowColor: themegreytextcolor,
      elevation: 2,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Palette.themecolor,
    ),
    iconTheme: const IconThemeData(
      color: themewhitecolor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.themecolor,
      selectionColor: Palette.themecolor,
      selectionHandleColor: Palette.themecolor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: themewhitecolor,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
        color: themewhitecolor,
        fontSize: 15,
      ),
      floatingLabelStyle: TextStyle(
        color: themewhitecolor,
        fontSize: 15,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: themewhitecolor,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: themeblackcolor,
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themewhitecolor),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themewhitecolor),
      ),
      dialHandColor: themeblackcolor,
      dialTextColor: themewhitecolor,
    ),
    datePickerTheme: const DatePickerThemeData(
      dayForegroundColor: WidgetStatePropertyAll(themewhitecolor),
      weekdayStyle: TextStyle(color: themewhitecolor),
      todayForegroundColor: WidgetStatePropertyAll(themewhitecolor),
      yearStyle: TextStyle(
        color: themewhitecolor,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themewhitecolor),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themewhitecolor),
      ),
      rangePickerHeaderForegroundColor: themewhitecolor,
      rangeSelectionBackgroundColor: themewhitecolor,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.themecolor,
      brightness: Brightness.dark,
      primary: themeblackcolor,
      onPrimary: themeblackcolor,
      secondary: themewhitecolor,
      onSecondary: themeblackcolor,
      error: themeblackcolor,
      onError: themeblackcolor,
      surface: themedarkgreycolor,
      onSurface: themeblackcolor,
      outline: themewhitecolor,
      shadow: themegreycolorshade.shade800,
      surfaceDim: themedarkgreycolor,
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: themewhitecolor,
      collapsedTextColor: themewhitecolor,
      iconColor: themewhitecolor,
      collapsedIconColor: themewhitecolor,
    ),
    popupMenuTheme: const PopupMenuThemeData(
      color: themedarkgreycolor,
      elevation: 0,
      shadowColor: themegreycolor,
      surfaceTintColor: themedarkgreycolor,
      textStyle: TextStyle(
        color: themewhitecolor,
      ),
      position: PopupMenuPosition.under,
    ),
    primaryColor: themeblackcolor,
  );

  static var lightModeAppTheme = ThemeData(
    useMaterial3: true,
    fontFamily: Constants.appFontFamily,
    iconTheme: const IconThemeData(
      color: themeblackcolor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: themeblackcolor,
        fontSize: 48,
      ),
      displayMedium: TextStyle(
        color: themeblackcolor,
        fontSize: 44,
      ),
      displaySmall: TextStyle(
        color: themeblackcolor,
        fontSize: 40,
      ),
      headlineLarge: TextStyle(
        color: themeblackcolor,
        fontSize: 36,
      ),
      headlineMedium: TextStyle(
        color: themeblackcolor,
        fontSize: 32,
      ),
      headlineSmall: TextStyle(
        color: themeblackcolor,
        fontSize: 28,
      ),
      titleLarge: TextStyle(
        color: themeblackcolor,
        fontSize: 26,
      ),
      titleMedium: TextStyle(
        color: themeblackcolor,
        fontSize: 24,
      ),
      titleSmall: TextStyle(
        color: themeblackcolor,
        fontSize: 22,
      ),
      bodyLarge: TextStyle(
        color: themeblackcolor,
        fontSize: 20,
      ),
      bodyMedium: TextStyle(
        color: themeblackcolor,
        fontSize: 18,
      ),
      bodySmall: TextStyle(
        color: themeblackcolor,
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: themeblackcolor,
        fontSize: 14,
      ),
      labelMedium: TextStyle(
        color: themeblackcolor,
        fontSize: 12,
      ),
      labelSmall: TextStyle(
        color: themeblackcolor,
        fontSize: 10,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: themewhitecolor,
      surfaceTintColor: themewhitecolor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: themeblackcolor,
      ),
      titleTextStyle: TextStyle(
        color: themeblackcolor,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        fontFamily: Constants.appFontFamily,
      ),
    ),
  ).copyWith(
    scaffoldBackgroundColor: themewhitecolor,
    cardColor: themegreycolor,
    cardTheme: const CardThemeData(
      color: themewhitecolor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Palette.themecolor,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(
          color: themeblackcolor,
          fontSize: 15,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: themeblackcolor,
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Palette.themecolor,
      selectionColor: Palette.themecolor,
      selectionHandleColor: Palette.themecolor,
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: themeblackcolor,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(
        color: themeblackcolor,
        fontSize: 15,
      ),
      labelStyle: TextStyle(
        color: themeblackcolor,
        fontSize: 15,
      ),
      floatingLabelStyle: TextStyle(
        color: themeblackcolor,
        fontSize: 15,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 14,
      ),
    ),
    expansionTileTheme: const ExpansionTileThemeData(
      textColor: themeblackcolor,
      collapsedTextColor: themeblackcolor,
      iconColor: themeblackcolor,
      collapsedIconColor: themeblackcolor,
    ),
    primaryColor: themewhitecolor,
    popupMenuTheme: const PopupMenuThemeData(
      color: themewhitecolor,
      elevation: 10,
      surfaceTintColor: themewhitecolor,
      textStyle: TextStyle(
        color: themeblackcolor,
      ),
      position: PopupMenuPosition.under,
    ),
    timePickerTheme: const TimePickerThemeData(
      backgroundColor: themewhitecolor,
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themeblackcolor),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themeblackcolor),
      ),
      dialHandColor: themewhitecolor,
      dialTextColor: themeblackcolor,
    ),
    datePickerTheme: const DatePickerThemeData(
      dayForegroundColor: WidgetStatePropertyAll(themeblackcolor),
      weekdayStyle: TextStyle(color: themeblackcolor),
      todayForegroundColor: WidgetStatePropertyAll(themeblackcolor),
      yearStyle: TextStyle(
        color: themeblackcolor,
      ),
      cancelButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themeblackcolor),
      ),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(themeblackcolor),
      ),
      rangePickerHeaderForegroundColor: themeblackcolor,
      rangeSelectionBackgroundColor: themeblackcolor,
      rangePickerBackgroundColor: themeblackcolor,
      rangePickerHeaderBackgroundColor: themeblackcolor,
      rangePickerSurfaceTintColor: themeblackcolor,
      rangeSelectionOverlayColor: WidgetStatePropertyAll(themeblackcolor),
      headerForegroundColor: themeblackcolor,
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Palette.themecolor,
      brightness: Brightness.light,
      primary: themewhitecolor,
      onPrimary: themewhitecolor,
      secondary: themeblackcolor,
      onSecondary: themelightgreycolor,
      error: themewhitecolor,
      onError: themewhitecolor,
      surface: themegreycolor,
      onSurface: themegreytextcolor,
      surfaceDim: themelightgreycolor,
      outline: themegreycolor,
      shadow: themegreycolorshade.shade300,
    ),
  );
}

const transparentcolor = Colors.transparent;
const themeblackcolor = Color(0xff000000);
const themewhitecolor = Colors.white;
const themelightgreycolor = Color.fromARGB(255, 244, 244, 244);
const themegreycolor = Color(0xffE0E0E0);
const themegreycolorshade = Colors.grey;
const themegreytextcolor = Color(0xff959595);
const themedarkgreycolor = Color(0xff2A2727);
const themeredcolor = Color(0xffF9113B);
const themeyellowcolor = Color(0xffFCBE47);
const themeorangecolor = Color(0xffF09F33);
const themegreencolor = Color(0xff10CE8F);
const themeauthbuttoncolor = Color(0xff8E7F47);
const themebluecolor = Color(0xff1877F2);
const themetextfieldcolor = Color(0xffF4F4F4);
const themebrowncolor = Color(0xffC68304);
const themepurplecolor = Color(0xff800080);
const themelightbrowncolor = Color(0xffC8A575);
const themebrown2color = Color(0xff836A57);
const themepinkcolor = Color(0xffEC008C);
const themepinkcolor2 = Color(0xffFD3C5A);
const themedarkbluecolor = Color(0xff0E2936);
const themelightgreencolor = Color(0xffB2CCB3);
const themegreencolor2 = Color(0xff37B44E);
const themegreencolorshade1 = Color(0xff95B56A);
const themeorangebuttoncolor1 = Color(0xffFCBE47);
const themeorangebuttoncolor2 = Color(0xffFF820E);
const themebckgrndclr1 = Color(0xffF2EBE2);
const themebckgrndclr2 = Color(0xffC2ECFA);
const themebckgrndclr3 = Color(0xffF1FAFD);
const themelightyellowcolor = Color(0xffFDFEB0);
const themelightgreencolor2 = Color(0xffCEF0AC);
const themegoldencolor = Color(0xffD5AF33);
const themebookbutton = Color(0xffd4baa9);
const knthemeredcolor = Color.fromARGB(211, 254, 0, 0);
