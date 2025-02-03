import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth/auth_cubit.dart';
//import '../cubit/auth/auth_helper.dart';
import '../gui/auth/loginscreen.dart';
import '../gui/main/homescreen.dart';
import '../helpers/form_helpers.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthAuthenticated) {
          // On successful authentication, navigate to the main screen.
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      child: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            FirstNameField(
                controller: fNameController, focusNode: fNameFocusNode),
            LastNameField(
                controller: lNameController, focusNode: lNameFocusNode),
            EmailField(controller: emailController, focusNode: emailFocusNode),
            PasswordField(
                controller: passwordController, focusNode: passwordFocusNode),
            ConfirmPasswordField(
                controller: confirmPasswordController,
                focusNode: confirmPasswordFocusNode,
                passwordController: passwordController),
            const SizedBox(height: 16),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        submitForm(
                          context: context,
                          formKey: formKey,
                          isSignUp: true,
                          fNameController: fNameController,
                          lNameController: lNameController,
                          emailController: emailController,
                          passwordController: passwordController,
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                              text: 'Already have an account? ',
                              style: TextStyle(color: Colors.black)),
                          TextSpan(
                            text: 'Sign In',
                            style: const TextStyle(color: Colors.blue),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
