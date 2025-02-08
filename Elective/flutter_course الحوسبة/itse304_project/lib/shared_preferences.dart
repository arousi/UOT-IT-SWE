import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  Future<void> saveToken(String token) async {
    log('Saving token: $token');
    final p = await prefs;
    await p.setString('auth_token', token);
  }

  Future<String?> getToken() async {
    final p = await prefs;
    String? token = p.getString('auth_token');
    log('Retrieved token: $token');
    return token;
  }

  Future<void> removeToken() async {
    log('Removing token');
    final p = await prefs;
    await p.remove('auth_token');
  }
}
