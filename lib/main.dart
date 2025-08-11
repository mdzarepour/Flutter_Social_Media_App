import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/firebase_options.dart';
import 'package:social_connection/core/theme/app_theme.dart';
import 'package:social_connection/resources/auth_methods.dart';
import 'package:social_connection/ui/screens/home_screen.dart';
import 'package:social_connection/ui/screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthMethods())],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthMethods authMethods = Provider.of<AuthMethods>(
      context,
      listen: false,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: StreamBuilder<User?>(
        stream: authMethods.stateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          }
          return const SigninScreen();
        },
      ),
    );
  }
}
