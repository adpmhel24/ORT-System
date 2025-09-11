import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthTokenProvider {
  Future<void> setToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
}

class SharedPrefsTokenProvider implements AuthTokenProvider {
  static const _tokenKey = 'auth_token';

  @override
  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }
}
