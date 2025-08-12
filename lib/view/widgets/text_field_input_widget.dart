import 'package:flutter/material.dart';

class TextFieldInputWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const TextFieldInputWidget({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      style: textTheme.bodyMedium,
      cursorColor: scheme.onSecondary,
      decoration: InputDecoration(hint: Text(hint), prefixIcon: Icon(icon)),
      validator: validator,
    );
  }
}
