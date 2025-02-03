import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/navigation/nav_cubit.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {
        int selectedIndex = 0; // Default to Home
        if (state == NavigationState.profile) {
          selectedIndex = 1;
        }

        return BottomNavigationBar(
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 0) {
              context.read<NavigationCubit>().showHome();
            } else if (index == 1) {
              context.read<NavigationCubit>().showProfile();
            }
          },
        );
      },
    );
  }
}
