// sign_up_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../widgets/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss keyboard when tapping outside input fields.
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider(
        create: (_) => AuthCubit(),
        child: const Scaffold(
          backgroundColor: Color(0xFFF8F8F8),
          body: SafeArea(
            minimum: EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SignUpForm(),
            ),
          ),
        ),
      ),
    );
  }
}
