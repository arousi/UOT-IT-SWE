import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:itse304_project/db_helper.dart';
import 'package:itse304_project/gui/auth/signupscreen.dart';

import '../../helpers/form_helpers.dart';
import '../main/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(controller: _emailController, focusNode: FocusNode()),
          PasswordField(
              controller: _passwordController, focusNode: FocusNode()),
          ElevatedButton(
              child: const Text('Login'),
              onPressed: () async {
                print('Email: $_emailController'.toString());
                //print('Hashed Password: $hashedPassword');
                if (_formKey.currentState!.validate()) {
                  Map<String, dynamic>? user = await DatabaseHelper()
                      .getUser(_emailController.text, _passwordController.text);
                  print('User: $user');
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  } else {
                    // Show an error message if the user does not exist
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('User does not exist')),
                    );
                  }
                }
              }),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                    text: 'Don\'t have an account? ',
                    style: TextStyle(color: Colors.black)),
                TextSpan(
                  text: 'Sign Up',
                  style: const TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
