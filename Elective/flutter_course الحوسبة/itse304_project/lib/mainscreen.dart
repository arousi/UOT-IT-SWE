import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // Import BlocProvider
import 'features/auth/logic/auth_cubit.dart'; // Import AuthCubit
import 'package:go_router/go_router.dart'; // Import GoRouterState

import 'core/widgets/customAppBar.dart';
import 'core/widgets/custom_navbar.dart';
import 'features/auth/presentation/screens/signupscreen.dart';

class MainScreen extends StatefulWidget {
  final Widget child;
  const MainScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final logger = Logger();

    return Scaffold(
      key: _scaffoldKey,
      appBar: const CustomAppBar(
        title: "Sanad SWE Dept App",
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          logger.i('MainScreen received AuthState: $state'); // Add this line
          if (state is AuthLoading) {
            logger.t('AuthLoading state');
            return const Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            logger.i('AuthAuthenticated state');
            return widget.child; // Screen from shell
          } else {
            logger.i('AuthInitial or AuthError state, showing SignUpScreen');
            return const SignUpScreen(); // If not authenticated, show SignUpScreen
          }
        },
      ),
      bottomNavigationBar: const CustomNavBar(),      
    );
  }
}
