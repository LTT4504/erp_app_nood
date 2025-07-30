// services/auth_service.dart

import 'package:dio/dio.dart';
import '../api/api_client.dart';
import '../api/api_constant.dart';

import '../models/model/response/auth_respon.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;

  Future<AuthResponse> login({
    required String username,
    required String password,
    bool rememberMe = false,
  }) async {
    final response = await _dio.post(ApiConstant.login, data: {
      'username': username,
      'password': password,
      'rememberMe': rememberMe,
    });

    return AuthResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    await _dio.post(ApiConstant.logout);
  }

  Future<AuthResponse> refreshToken(String refreshToken) async {
    final response = await _dio.post(ApiConstant.refreshToken, data: {
      'refreshToken': refreshToken,
    });
    return AuthResponse.fromJson(response.data);
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post(ApiConstant.forgotPassword, data: {
      'email': email,
    });
  }
}
