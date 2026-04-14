import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincare_app/features/authentication/models/apiresult.dart';
import 'package:skincare_app/features/authentication/models/user.dart';
import 'auth_api.dart';

class AuthRepository {
  final AuthApi api = AuthApi();

  Future<ApiResult<bool>> login(String email, String password) async {
    try {
      final res = await api.login(email, password);

      final accessToken = res.data["accessToken"] as String?;
      final refreshToken = res.data["refreshToken"] as String?;

      if (accessToken == null || refreshToken == null) {
        return ApiResult(data: false, error: "Invalid response from server");
      }

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString("accessToken", accessToken);
      await prefs.setString("refreshToken", refreshToken);

      return ApiResult(data: true, message: "Login successful!");
    } catch (e) {
      if (e is DioException) {
        final message = e.response?.data["message"] ?? "Login failed";
        return ApiResult(data: false, error: message);
      }
      return ApiResult(data: false, error: "Something went wrong");
    }
  }

  Future<bool> register(
    String email,
    String password,
    String name,
    String phone,
  ) async {
    try {
      // final res = await api.register(email, password, name, phone);

      // final token = res.data["accessToken"];

      // if (token != null) {
      //   final prefs = await SharedPreferences.getInstance();
      //   await prefs.setString("token", token);
      // }
      // return true;
      final res = await api.register(email, password, name, phone);

      final accessToken = res.data["accessToken"];
      final refreshToken = res.data["refreshToken"];

      final prefs = await SharedPreferences.getInstance();

      if (accessToken != null) {
        await prefs.setString("accessToken", accessToken);
      }

      if (refreshToken != null) {
        await prefs.setString("refreshToken", refreshToken);
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateMe(
    String? name,
    String? email,
    String? phone,
    String? dob,
    String? imageUrl,
  ) async {
    try {
      final data = <String, dynamic>{};

      if (email != null) data["email"] = email;
      if (dob != null) data["dob"] = dob;
      if (name != null) data["name"] = name;
      if (phone != null) data["phone"] = phone;
      if (imageUrl != null) data["imageUrl"] = imageUrl;

      print("PATCH DATA: $data");

      final res = await api.updateMe(data);
      print('resData: $res.data');

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isLoggedIn() async {
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString("token");
    // return token != null && token.isNotEmpty;
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("accessToken");
    return token != null && token.isNotEmpty;
  }

  Future<User> getMe() async {
    final res = await api.getMe();
    print(res.data);
    return User.fromJson(res.data);
  }

  Future<ApiResult<bool>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final res = await api.changePassword(oldPassword, newPassword);
      print("ressss: " + res.toString());
      return ApiResult(data: true);
    } catch (e) {
      if (e is DioException) {
        print("e.response:" + e.response.toString());
        final message = e.response?.data["message"] ?? "Unknown error";
        return ApiResult(error: message);
      }
    }
    return ApiResult(error: "Something went wrong");
  }
}
