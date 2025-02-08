import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/db_helper.dart';
import '../../../../core/utils/form_helpers.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final logger = Logger();
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    logger.i('Building #LoginForm');

    return GestureDetector(
      onTap: () {
        logger.t('Tapped outside input fields');
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                EmailField(
                    controller: _emailController, focusNode: FocusNode()),
                const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
                PasswordField(
                    controller: _passwordController, focusNode: FocusNode()),
                const Divider(
                  color: Colors.transparent,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors
                        .amber, //was taking it from theme then many errors happened
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    logger.i('Login button pressed');
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic>? user = await DatabaseHelper()
                          .getUser(
                              _emailController.text, _passwordController.text);
                      if (user != null) {
                        logger.i('User found in database, navigating to home');
                        context.go('/home');
                      } else {
                        logger.w('User not found in database');
                        // Show an error message if the user does not exist
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User does not exist')),
                        );
                      }
                    } else {
                      logger.w('Login form validation failed');
                    }
                  },
                ),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.bodyLarge),
                      TextSpan(
                        text: 'Sign Up',
                        style: const TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/signup');
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
