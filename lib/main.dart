import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social_connection/firebase_options.dart';
import 'package:social_connection/responsive/mobile_screen_layout.dart';
import 'package:social_connection/responsive/responsive_screen_layout.dart';
import 'package:social_connection/responsive/web_screen_layout.dart';
import 'package:social_connection/core/theme/app_theme.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
