import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itse304_project/widgets/custom_navbar.dart';

import '../../cubit/auth/auth_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _State();
}

class _State extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen'),
            ElevatedButton(
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Sanad SWE Dept App"),
      ),
    ));
  }
}
