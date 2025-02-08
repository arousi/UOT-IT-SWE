import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart'; // Import Logger

import '../../features/auth/logic/auth_cubit.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// Controllers for form fields.
final TextEditingController fNameController = TextEditingController();
final TextEditingController lNameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();

// Focus nodes.
final FocusNode fNameFocusNode = FocusNode();
final FocusNode lNameFocusNode = FocusNode();
final FocusNode emailFocusNode = FocusNode();
final FocusNode passwordFocusNode = FocusNode();
final FocusNode confirmPasswordFocusNode = FocusNode();

void disposeFormHelpers() {
  fNameController.dispose();
  lNameController.dispose();
  emailController.dispose();
  passwordController.dispose();
  confirmPasswordController.dispose();

  fNameFocusNode.dispose();
  lNameFocusNode.dispose();
  emailFocusNode.dispose();
  passwordFocusNode.dispose();
  confirmPasswordFocusNode.dispose();
}

void submitForm({
  required BuildContext context,
  required GlobalKey<FormState> formKey,
  required bool isSignUp,
  required TextEditingController fNameController,
  required TextEditingController lNameController,
  required TextEditingController emailController,
  required TextEditingController passwordController,
}) {
  final logger = Logger();
  logger.i('Attempting to submit form. isSignUp: $isSignUp');
  if (formKey.currentState!.validate()) {
    final authCubit = context.read<AuthCubit>();
    if (isSignUp) {
      authCubit.signUp(
        firstName: fNameController.text,
        lastName: lNameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    } else {
      authCubit.login(
        emailController.text,
        passwordController.text,
      );
    }
  } else {
    logger.w('Form validation failed.');
  }
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Please enter your email';
  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Please enter your password';
  if (value.length < 6) return 'Password must be at least 6 characters long';
  return null;
}

String? validateConfirmPassword(
    String? value, TextEditingController passwordController) {
  if (value == null || value.isEmpty) return 'Please confirm your password';
  if (value != passwordController.text) return 'Passwords do not match';
  return null;
}

class FirstNameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const FirstNameField(
      {super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(labelText: 'First Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class LastNameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const LastNameField(
      {super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(labelText: 'Last Name'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your last name';
        }
        return null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const EmailField(
      {super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(labelText: 'Email'),
      validator: validateEmail,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const PasswordField({super.key, required this.controller, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(labelText: 'Password'),
      obscureText: true,
      validator: validatePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextEditingController passwordController;

  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      controller: controller,
      focusNode: focusNode,
      decoration: const InputDecoration(labelText: 'Confirm Password'),
      obscureText: true,
      validator: (value) => validateConfirmPassword(value, passwordController),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: (_) {
        if (formKey.currentState?.validate() ?? false) {
          formKey.currentState?.save();
          submitForm(
            context: context,
            formKey: formKey,
            fNameController: fNameController,
            lNameController: lNameController,
            emailController: emailController,
            passwordController: passwordController,
            isSignUp: true,
          );
        }
      },
    );
  }
}
