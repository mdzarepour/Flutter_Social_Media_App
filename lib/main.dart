import 'package:flutter/material.dart';
import 'package:social_connection/responsive/mobile_screen_layout.dart';
import 'package:social_connection/responsive/responsive_screen_layout.dart';
import 'package:social_connection/responsive/web_screen_layout.dart';
import 'package:social_connection/theme/app_theme.dart';

void main(List<String> args) {
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: ResponsiveScreenLayout(
        mobileScreen: MobileScreenLayout(),
        webScreen: WebScreenLayout(),
      ),
    );
  }
}
