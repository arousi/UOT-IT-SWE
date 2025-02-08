import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itse304_project/core/widgets/customAppBar.dart';
import 'package:logger/logger.dart';

import '../../../../core/widgets/custom_navbar.dart';
import '../../../auth/logic/auth_cubit.dart';
import '../../../auth/presentation/screens/signupscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    logger.i('Home Screen Entered');
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          logger.i('AuthInitial');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignUpScreen()),
            (route) => false,
          );
        }
      },
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text('Home Screen')),
            ],
          ),
        ),
      ),
    );
  }
}
