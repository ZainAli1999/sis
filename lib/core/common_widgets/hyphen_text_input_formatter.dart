import 'package:flutter/services.dart';

class HyphenTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    String formatted = '';
    if (digitsOnly.length > 5) {
      formatted += '${digitsOnly.substring(0, 5)}-';
      if (digitsOnly.length > 12) {
        formatted +=
            '${digitsOnly.substring(5, 12)}-${digitsOnly.substring(12, 13)}';
      } else {
        formatted += digitsOnly.substring(5);
      }
    } else {
      formatted = digitsOnly;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
