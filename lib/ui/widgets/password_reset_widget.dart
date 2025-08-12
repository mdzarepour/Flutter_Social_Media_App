import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/providers/auth_provider.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/ui/widgets/text_field_input_widget.dart';

class PasswordResetWidget extends StatefulWidget {
  const PasswordResetWidget({super.key});

  @override
  State<PasswordResetWidget> createState() => _PasswordResetWidgetState();
}

class _PasswordResetWidgetState extends State<PasswordResetWidget> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  late final AuthProvider _authProvider;
  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
          key: formKey,
          child: Container(
            decoration: BoxDecoration(
              color: scheme.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            height: constraints.maxHeight * 0.5,
            child: Column(
              spacing: 25,
              children: [
                TextFieldInputWidget(
                  controller: _emailController,
                  hint: AppStrings.email,
                  icon: Iconsax.send_1_copy,
                  validator: (value) => RegexMethods.emailValidator(value),
                ),
                SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.11,
                  child: FilledButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        _authProvider.sendPasswordResetEmail(
                          _emailController.text,
                        );
                      }
                    },
                    child: Consumer<AuthProvider>(
                      builder: (context, provider, child) {
                        if (provider.authState == AuthState.loading) {
                          return Text('loading ..');
                        }
                        return Text('send reset email');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
