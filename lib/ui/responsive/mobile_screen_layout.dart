import 'package:flutter/material.dart';

import 'package:social_connection/ui/screens/signup_screen.dart';

class MobileScreenLayout extends StatelessWidget {
  const MobileScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SignupScreen());
  }
}
