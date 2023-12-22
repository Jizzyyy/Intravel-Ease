import 'package:flutter/services.dart';

class SingleSpace extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    if (newValue.text.length > 1 && newValue.text.endsWith('  ')) {
      final trimmedText = '${newValue.text.trim()} ';
      return TextEditingValue(
        text: trimmedText,
        selection: TextSelection.collapsed(offset: trimmedText.length),
      );
    }
    return newValue;
  }
}
