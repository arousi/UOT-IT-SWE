import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itse304_project/core/widgets/theme_toggle.dart';

import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return AppBar(
          actions: const [ThemeToggle()],
          backgroundColor: Colors.blue,
          title: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
