import 'package:flutter/material.dart';
import 'package:sis/core/theme/colors.dart';

extension TextStyleMapping on TextStyle {
  TextStyle get w400 => copyWith(fontWeight: FontWeight.w400);
  TextStyle get w500 => copyWith(fontWeight: FontWeight.w500);
  TextStyle get w600 => copyWith(fontWeight: FontWeight.w600);
  TextStyle get w700 => copyWith(fontWeight: FontWeight.w700);
  TextStyle get w800 => copyWith(fontWeight: FontWeight.w800);
  TextStyle get w900 => copyWith(fontWeight: FontWeight.w900);
  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);
  TextStyle get themeColor => copyWith(color: Palette.themecolor);
  TextStyle get themeGreyTextColor => copyWith(color: themegreytextcolor);
  TextStyle get themeWhiteColor => copyWith(color: themewhitecolor);
  TextStyle get themeBlackColor => copyWith(color: themeblackcolor);
  TextStyle get themeRedColor => copyWith(color: themeredcolor);
  TextStyle get underline => copyWith(
        decoration: TextDecoration.underline,
        color: themebluecolor,
        decorationColor: themebluecolor,
      );
}
