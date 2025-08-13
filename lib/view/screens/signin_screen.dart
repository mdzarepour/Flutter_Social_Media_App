import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/providers/auth_provider.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/view/screens/signup_screen.dart';
import 'package:social_connection/view/widgets/auth_help_button.dart';
import 'package:social_connection/view/widgets/password_reset_widget.dart';
import 'package:social_connection/view/widgets/text_field_input_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  late final AuthProvider _authProvider;

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
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: size.width * 0.09,
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.2),
                Text(style: textTheme.headlineLarge, AppStrings.signIn),
                SizedBox(height: size.height * 0.01),
                Text(style: textTheme.bodyMedium, AppStrings.signInMsg),
                SizedBox(height: size.height * 0.05),
                Form(
                  key: formKey,
                  child: Column(
                    spacing: size.height * 0.025,
                    children: [
                      TextFieldInputWidget(
                        controller: _emailController,
                        hint: AppStrings.email,
                        icon: Iconsax.send_1_copy,
                        isPassword: false,
                        validator: (value) =>
                            RegexMethods.emailValidator(value),
                      ),
                      TextFieldInputWidget(
                        controller: _passwordController,
                        hint: AppStrings.password,
                        icon: Iconsax.key_copy,
                        isPassword: true,
                        validator: (value) =>
                            RegexMethods.passwordValidator(value),
                      ),
                      _signInButton(size, scheme.secondaryContainer),
                      Text(
                        textAlign: TextAlign.center,
                        style: textTheme.bodySmall,
                        context.watch<AuthProvider>().errorMessage ?? '',
                      ),
                      SizedBox(height: size.height * 0.002),
                    ],
                  ),
                ),
                AuthHelpButton(
                  message: AppStrings.dontHaveAccount,
                  title: AppStrings.createAccount,
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.02),
                AuthHelpButton(
                  message: AppStrings.forgetPassword,
                  title: AppStrings.resetPassword,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return PasswordResetWidget();
                      },
                    );
                  },
                ),
                SizedBox(height: size.height * 0.08),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signInButton(Size size, Color color) {
    return SizedBox(
      width: size.width,
      height: size.height * 0.06,
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
