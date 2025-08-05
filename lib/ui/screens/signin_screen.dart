import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/ui/widgets/text_field_input_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
                            controller: emailController,
                            hint: AppStrings.email,
                            icon: Iconsax.send_1_copy,
                            validator: (value) => emailValidator(value),
                          ),
                          TextFieldInputWidget(
                            controller: passwordController,
                            hint: AppStrings.password,
                            icon: Iconsax.key_copy,
                            validator: (value) => passwordValidator(value),
                          ),
                          SizedBox(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight * 0.06,
                            child: FilledButton(
                              child: Text(
                                style: textTheme.bodyMedium,
                                AppStrings.signIn,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {}
                              },
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

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'please enter email';
    } else {
      return null;
    }
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'please enter password';
    } else {
      return null;
    }
  }
}
