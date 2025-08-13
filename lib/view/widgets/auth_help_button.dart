import 'package:flutter/material.dart';

class AuthHelpButton extends StatelessWidget {
  final Function() onTap;
  final String message;
  final String title;

  const AuthHelpButton({
    super.key,
    required this.onTap,
    required this.message,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.start,
        text: TextSpan(
          children: [
            TextSpan(style: textTheme.titleMedium, text: message),
            TextSpan(style: textTheme.titleSmall, text: title),
          ],
        ),
      ),
    );
  }
}
