import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/providers/auth_provider.dart';

class TextFieldInputWidget extends StatelessWidget {
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final FormFieldValidator validator;

  const TextFieldInputWidget({
    super.key,
    required this.hint,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    final AuthProvider provider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return TextFormField(
      obscureText: provider.passwordVis,
      controller: controller,
      keyboardType: TextInputType.text,
      style: textTheme.bodyMedium,
      cursorColor: scheme.onSecondary,

      decoration: InputDecoration(
        suffix: isPassword
            ? InkWell(
                onTap: () {
                  provider.changePasswordVisibility();
                },
                child: Icon(
                  provider.passwordVis
                      ? Iconsax.eye_slash_copy
                      : Iconsax.eye_copy,
                ),
              )
            : null,
        hint: Text(hint),
        prefixIcon: Icon(icon),
      ),
      validator: validator,
    );
  }
}
