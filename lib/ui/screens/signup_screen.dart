import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/resources/auth_methods.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/ui/widgets/text_field_input_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final RegexMethods _regexMethods = RegexMethods();
  final AuthMethods _authMethods = AuthMethods();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.09,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.2),
                    Text(AppStrings.signUp, style: textTheme.headlineLarge),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    Text(AppStrings.signUpMsg, style: textTheme.bodyMedium),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFieldInputWidget(
                            controller: _usernameController,
                            hint: AppStrings.username,
                            icon: Iconsax.user_copy,
                            validator: (value) =>
                                _regexMethods.usernameValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _biographyController,
                            hint: AppStrings.biography,
                            icon: Iconsax.information_copy,
                            validator: (value) =>
                                _regexMethods.biographyValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _emailController,
                            hint: AppStrings.email,
                            icon: Iconsax.send_1_copy,
                            validator: (value) =>
                                _regexMethods.emailValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _passwordController,
                            hint: AppStrings.password,
                            icon: Iconsax.key_copy,
                            validator: (value) =>
                                _regexMethods.passwordValidator(value),
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.06,
                            child: FilledButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _signUp();
                                }
                              },
                              child: Text(
                                AppStrings.signIn,
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _signUp() {
    _authMethods.signUp(
      email: _emailController.text.trim(),
      biography: _biographyController.text,
      password: _passwordController.text.trim(),
      username: _usernameController.text.trim(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _biographyController.dispose();
  }
}
