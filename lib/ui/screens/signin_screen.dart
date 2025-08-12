import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/providers/auth_provider.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/ui/screens/signup_screen.dart';
import 'package:social_connection/ui/widgets/text_field_input_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  late final AuthProvider _authProvider;
  final RegexMethods _regexMethods = RegexMethods();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: EdgeInsetsGeometry.symmetric(
                horizontal: constraints.maxWidth * 0.09,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: constraints.maxHeight * 0.2),
                  Text(style: textTheme.headlineLarge, AppStrings.signIn),
                  Text(style: textTheme.bodyMedium, AppStrings.signInMsg),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Form(
                    key: formKey,
                    child: Column(
                      spacing: constraints.maxHeight * 0.025,
                      children: [
                        TextFieldInputWidget(
                          controller: _emailController,
                          hint: AppStrings.email,
                          icon: Iconsax.send_1_copy,
                          validator: (value) =>
                              _regexMethods.emailValidator(value),
                        ),
                        TextFieldInputWidget(
                          controller: _passwordController,
                          hint: AppStrings.password,
                          icon: Iconsax.key_copy,
                          validator: (value) =>
                              _regexMethods.passwordValidator(value),
                        ),
                        _signInButton(constraints, scheme.secondaryContainer),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  style: textTheme.titleMedium,
                                  text: AppStrings.dontHaveAccount,
                                ),
                                TextSpan(
                                  style: textTheme.titleSmall,
                                  text: AppStrings.createAccount,
                                ),
                              ],
                            ),
                          ),
                        ),

                        Text(
                          textAlign: TextAlign.center,
                          style: textTheme.bodySmall,
                          context.watch<AuthProvider>().errorMessage ?? '',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  SizedBox _signInButton(BoxConstraints constraints, var color) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.06,
      child: FilledButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            _authProvider.signIn(
              _emailController.text,
              _passwordController.text,
            );
          }
        },
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            if (provider.authState == AuthState.loading) {
              return SpinKitThreeBounce(color: color, size: 20);
            }
            return Text(AppStrings.signIn);
          },
        ),
      ),
    );
  }
}
