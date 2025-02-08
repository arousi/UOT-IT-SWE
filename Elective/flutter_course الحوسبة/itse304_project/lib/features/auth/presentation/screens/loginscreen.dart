import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../widgets/loginform.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    logger.i('Building LoginScreen');
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: const SafeArea(
        minimum: EdgeInsets.all(16),
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}
