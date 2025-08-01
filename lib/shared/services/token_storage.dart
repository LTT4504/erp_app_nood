// services/token_storage.dart
import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final _box = GetStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';
  static const _rememberMeKey = 'rememberMe';

  // --- TOKEN ---
  static Future<String?> getAccessToken() async {
  return _box.read<String>(_accessTokenKey);
}

  static Future<void> saveAccessToken(String token) async {
    await _box.write(_accessTokenKey, token);
  }

  static Future<void> clearAccessToken() async {
    await _box.remove(_accessTokenKey);
  }

  static String? getRefreshToken() => _box.read<String>(_refreshTokenKey);
  static Future<void> saveRefreshToken(String token) async {
    await _box.write(_refreshTokenKey, token);
  }

  static Future<void> clearRefreshToken() async {
    await _box.remove(_refreshTokenKey);
  }

  // --- REMEMBER ME ---
  static bool getRememberMe() => _box.read<bool>(_rememberMeKey) ?? false;

  static Future<void> setRememberMe(bool value) async {
    await _box.write(_rememberMeKey, value);
  }

  static String? getSavedUsername() => _box.read<String>(_usernameKey);
  static String? getSavedPassword() => _box.read<String>(_passwordKey);

  static Future<void> saveLoginInfo(String username, String password) async {
    await _box.write(_usernameKey, username);
    await _box.write(_passwordKey, password);
  }

  static Future<void> clearLoginInfo() async {
    await _box.remove(_usernameKey);
    await _box.remove(_passwordKey);
  }

  // --- CLEAR ALL ---
  static Future<void> clearAll() async {
    await _box.erase();
  }

  // --- LOGOUT LOGIC ---
  static Future<void> logout() async {
    await clearAccessToken();
    await clearRefreshToken();

    if (!getRememberMe()) {
      await clearLoginInfo();
      await _box.remove(_rememberMeKey);
    }
  }
}
