// auth_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../db_helper.dart';
import '../../shared_preferences.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    _checkToken();
  }
  Future<void> _checkToken() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final token = await SharedPref().getToken();

    if (token != null) {
      emit(AuthAuthenticated());
    } else {
      emit(AuthInitial());
    }
  }

  /// Sign In (Login) method (existing)
  void login(String email, String password) async {
    emit(AuthLoading());
    try {
      // Perform login logic (for example, check credentials)
      final user = await DatabaseHelper().getUser(email, password);
      if (user != null) {
        // Save token and emit success
        await SharedPref().saveToken('dummy_token');
        emit(AuthAuthenticated());
      } else {
        emit(const AuthError("Invalid email or password"));
      }
    } catch (e) {
      emit(const AuthError("Authentication failed"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await SharedPref().removeToken();
    emit(AuthInitial());
  }

  /// Sign Up method (new)
  void signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      // Check if the user already exists by email only
      final user = await DatabaseHelper().fetchUserFromDatabase(email);
      if (user != null) {
        emit(const AuthError("User already exists"));
        return;
      }
      // Insert new user into the database with hashed password
      await DatabaseHelper().insertUser(firstName, lastName, email, password);

      // Save token (for demo purposes, using a dummy token)
      await SharedPref().saveToken('dummy_token');
      emit(AuthAuthenticated());
    } catch (e) {
      emit(const AuthError("Sign up failed"));
    }
  }
}
