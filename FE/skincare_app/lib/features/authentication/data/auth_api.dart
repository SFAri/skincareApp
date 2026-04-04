import 'package:dio/dio.dart';
import 'package:skincare_app/core/api/api_provider.dart';

class AuthApi {
  final Dio dio = apiClient.dio;

  Future<Response> login(String email, String password) {
    return dio.post(
      "/auth/login",
      data: {"email": email, "password": password},
    );
  }

  Future<Response> register(
    String email,
    String password,
    String name,
    String phone,
  ) {
    return dio.post(
      "/auth/register",
      data: {
        "email": email,
        "password": password,
        "name": name,
        "phone": phone,
      },
    );
  }

  Future<Response> getMe() {
    return dio.get("/auth/me");
  }

  Future<Response> updateMe(Map<String, dynamic> data) {
    return dio.patch("/users/update-info/me", data: data);
  }

  Future<Response> changePassword(String oldPassword, String newPassword) {
    return dio.patch("/users/me/password", data: {"oldPassword":oldPassword, "newPassword": newPassword});
  }
}
