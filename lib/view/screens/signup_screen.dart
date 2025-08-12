import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/providers/auth_provider.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/view/widgets/text_field_input_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final AuthProvider _authProvider;
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _biographyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _biographyController.dispose();
    super.dispose();
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
                                RegexMethods.usernameValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _biographyController,
                            hint: AppStrings.biography,
                            icon: Iconsax.information_copy,
                            validator: (value) =>
                                RegexMethods.biographyValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _emailController,
                            hint: AppStrings.email,
                            icon: Iconsax.send_1_copy,
                            validator: (value) =>
                                RegexMethods.emailValidator(value),
                          ),
                          const SizedBox(height: 16),
                          TextFieldInputWidget(
                            controller: _passwordController,
                            hint: AppStrings.password,
                            icon: Iconsax.key_copy,
                            validator: (value) =>
                                RegexMethods.passwordValidator(value),
                          ),
                          const SizedBox(height: 32),
                          _signUpButton(constraints, scheme),
                          SizedBox(height: constraints.maxHeight * 0.02),
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
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _signUpButton(BoxConstraints constraints, ColorScheme scheme) {
    return SizedBox(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.06,
      child: FilledButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _authProvider.signUp(
              username: _usernameController.text,
              biography: _biographyController.text,
              email: _emailController.text,
              password: _passwordController.text,
            );
          }
        },
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            if (provider.authState == AuthState.loading) {
              return SpinKitThreeBounce(
                color: scheme.secondaryContainer,
                size: 20,
              );
            } else if (provider.authState == AuthState.successfull) {
              provider.authState = AuthState.empty;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pop(context);
              });
            } else if (provider.authState == AuthState.waitingVerify) {
              return Text(AppStrings.checkEmailVerify);
            }
            return Text(AppStrings.signUp);
          },
        ),
      ),
    );
  }
}
