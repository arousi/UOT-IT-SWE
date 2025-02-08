// auth_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart'; // Import Logger

import '../../../core/utils/db_helper.dart';
import '../../../shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final dbHelper = DatabaseHelper();
  final prefs = SharedPref();
  final logger = Logger(); // Initialize Logger

  AuthCubit() : super(AuthInitial()) {
    _checkToken();
  }

  Future<void> _checkToken() async {
    String? token  = 'dummy_token'; // await prefs.getToken();
    token = await prefs.getToken();

    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthInitial());
    }
  }

  /// Sign In (Login) method (existing)
  void login(String email, String password) async {
    logger.i('Logging in with email: $email');
    emit(AuthLoading());
    try {
      // Perform login logic (for example, check credentials)
      final user = await dbHelper.getUser(email, password);
      if (user != null) {
        // Save token and emit success
        await prefs.saveToken('dummy_token');
        emit(AuthAuthenticated());
        logger.i('User logged in successfully: $email');
      } else {
        emit(const AuthError("Invalid email or password"));
        logger.e('Login failed for $email: Invalid email or password');
      }
    } catch (e) {
      emit(const AuthError("Authentication failed"));
      logger.e('Login failed for $email', error: e);
    }
  }

  Future<void> logout(BuildContext context) async {
    emit(AuthLoading());
    await prefs.removeToken();
    Navigator.of(context).pushReplacementNamed('/login');

    emit(AuthInitial());
  }

  /// Sign Up method (new)
  void signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    logger.i('Signing up with email: $email');
    emit(AuthLoading());
    try {
      // Check if the user already exists by email only
      final user = await dbHelper.fetchUserFromDatabase(email);
      if (user != null) {
        emit(const AuthError("User already exists"));
        logger.e('Signup failed for $email: User already exists');
        return;
      }
      // Insert new user into the database with hashed password
      await dbHelper.insertUser(firstName, lastName, email, password);

      // Save token (for demo purposes, using a dummy token)
      await prefs.saveToken('dummy_token');
      emit(AuthAuthenticated());
      logger.i('User signed up successfully: $email');
    } catch (e) {
      emit(const AuthError("Sign up failed"));
      logger.e('Signup failed for $email', error: e);
    }
  }
}
