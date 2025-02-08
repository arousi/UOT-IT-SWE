import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter

import '../../../../core/utils/form_helpers.dart';
//import '../cubit/auth/auth_helper.dart';
import '../../logic/auth_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    logger.t('Building #SignUpForm');
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is AuthAuthenticated) {
          context.go('/home'); // Use GoRouter for navigation
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                FirstNameField(
                    controller: fNameController, focusNode: fNameFocusNode),
                const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
                LastNameField(
                    controller: lNameController, focusNode: lNameFocusNode),
                const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
                EmailField(
                    controller: emailController, focusNode: emailFocusNode),
                const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
                PasswordField(
                    controller: passwordController,
                    focusNode: passwordFocusNode),
                const Divider(
                  height: 1,
                  color: Colors.transparent,
                ),
                ConfirmPasswordField(
                    controller: confirmPasswordController,
                    focusNode: confirmPasswordFocusNode,
                    passwordController: passwordController),
                const Divider(
                  color: Colors.transparent,
                ),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                          ),
                          onPressed: () {
                            logger.i('Signup button pressed');
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
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'Already have an account? ',
                                  style: Theme.of(context).textTheme.bodyLarge),
                              TextSpan(
                                text: 'Sign In',
                                style: const TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context.go('/login');
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
        ),
      ),
    );
  }
}
