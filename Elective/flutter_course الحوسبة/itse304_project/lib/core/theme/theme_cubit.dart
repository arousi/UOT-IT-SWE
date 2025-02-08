import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:itse304_project/core/theme/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final logger = Logger();
  ThemeCubit() : super(ThemeState(themeData: customDarkTheme)) {
    loadTheme();
  }

  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      logger.i('SharedPreferences instance obtained');
      logger.i(
          'SharedPreferences contents: ${prefs.getKeys().map((key) => MapEntry(key, prefs.get(key)))}');

      if (!prefs.containsKey('isDarkMode')) {
        logger.i('isDarkMode key not found in SharedPreferences');
        final isSystemDark =
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark;
        logger.i('System theme detected: ${isSystemDark ? 'dark' : 'light'}');
        emit(ThemeState(
            themeData: isSystemDark ? customDarkTheme : customLightTheme));
        logger.i(
            'Theme emitted based on system theme: ${isSystemDark ? 'dark' : 'light'}');
      } else {
        final isDarkMode = prefs.getBool('isDarkMode')!;
        logger.i('isDarkMode key found in SharedPreferences: $isDarkMode');
        emit(ThemeState(
            themeData: isDarkMode ? customDarkTheme : customLightTheme));
        logger.i(
            'Theme emitted based on SharedPreferences: ${isDarkMode ? 'dark' : 'light'}');
      }
    } catch (e) {
      logger.e('Failed to load theme: $e');
      emit(ThemeState(themeData: customLightTheme)); // Default to light theme
      logger.i('Default light theme emitted due to error');
    }
  }

  void updateTheme(bool isDarkMode) {
    emit(ThemeState(
        themeData: isDarkMode ? ThemeData.dark() : ThemeData.light()));
  }

  Future<void> toggleTheme() async {
    final newTheme = state.themeData == customLightTheme
        ? customDarkTheme
        : customLightTheme;
    logger.i(
        'Toggling theme to: ${newTheme == customDarkTheme ? 'dark' : 'light'}');
    emit(ThemeState(themeData: newTheme));

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newTheme == customDarkTheme);
    logger.i('Theme preference saved: ${newTheme == customDarkTheme}');
  }
}
