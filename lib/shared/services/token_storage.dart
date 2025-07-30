// services/token_storage.dart

import 'package:get_storage/get_storage.dart';

class TokenStorage {
  static final _box = GetStorage();
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  static String? getAccessToken() {
    return _box.read<String>(_accessTokenKey);
  }

  static Future<void> saveAccessToken(String token) async {
    await _box.write(_accessTokenKey, token);
  }

  static Future<void> clearAccessToken() async {
    await _box.remove(_accessTokenKey);
  }

  static String? getRefreshToken() {
    return _box.read<String>(_refreshTokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    await _box.write(_refreshTokenKey, token);
  }

  static Future<void> clearRefreshToken() async {
    await _box.remove(_refreshTokenKey);
  }

  static Future<void> clearAll() async {
    await _box.erase();
  }
}
