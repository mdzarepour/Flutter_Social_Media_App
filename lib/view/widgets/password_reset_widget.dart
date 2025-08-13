import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_connection/core/utils/app_strings.dart';
import 'package:social_connection/providers/auth_provider.dart';
import 'package:social_connection/resources/regex_methods.dart';
import 'package:social_connection/view/widgets/text_field_input_widget.dart';

class PasswordResetWidget extends StatefulWidget {
  const PasswordResetWidget({super.key});

  @override
  State<PasswordResetWidget> createState() => _PasswordResetWidgetState();
}

class _PasswordResetWidgetState extends State<PasswordResetWidget> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();
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
    final ColorScheme scheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        key: _formKey,
        child: Container(
          decoration: BoxDecoration(
            color: scheme.secondary,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          height: size.height * 0.3,
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
                width: size.width,
                height: size.height * 0.07,
                child: FilledButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _authProvider.sendPasswordResetEmail(
                        _emailController.text,
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
                        return Text('check your email');
                      }
                      return Text('send email');
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
