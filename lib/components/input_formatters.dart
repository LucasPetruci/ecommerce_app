import 'package:flutter/services.dart';

class InputFormatters extends TextInputFormatter {
  final String Function(String text) formatter;
  InputFormatters({required this.formatter});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final formattedText = formatter(newValue.text);
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

String formatCep(String cep) {
  final text = cep.replaceAll(RegExp(r'\D'), '');
  if (text.length > 5) {
    return '${text.substring(0, 5)}-${text.substring(5)}';
  } else {
    return text;
  }
}
