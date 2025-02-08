import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:itse304_project/core/widgets/custom_navbar.dart';
import 'package:logger/logger.dart';

import '../../../../core/widgets/customAppBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _State();
}

class _State extends State<ProfileScreen> {
  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    logger.i('Profile Screen Entered');
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Profile Screen'),
              ElevatedButton(
                onPressed: () {
                  logger.i('Logout button pressed');
                  context.go('/login');
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
