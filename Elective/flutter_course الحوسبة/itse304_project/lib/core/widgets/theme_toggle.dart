// lib/core/widgets/theme_toggle.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../theme/app_theme.dart';
import '../theme/theme_cubit.dart';
import '../theme/theme_state.dart';

class ThemeToggle extends StatelessWidget {
  const ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return Switch(
          activeTrackColor: Colors.grey,
          activeColor: Colors.black,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.white,
          value: themeState.themeData == customDarkTheme,
          onChanged: (value) {
            context.read<ThemeCubit>().toggleTheme();
          },
        );
      },
    );
  }
}
