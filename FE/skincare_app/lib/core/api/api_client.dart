import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skincare_app/core/routes/app_router.dart';

class ApiClient {
  static ApiClient? _instance;
  late Dio dio;

  factory ApiClient(GlobalKey<NavigatorState> navigatorKey) {
    _instance ??= ApiClient._internal(navigatorKey);
    return _instance!;
  }

  ApiClient._internal(GlobalKey<NavigatorState> navigatorKey) {
    dio = Dio(
      BaseOptions(
        baseUrl: "http://localhost:3000/api", // ⚠️ fix localhost
        headers: {"Content-Type": "application/json"},
        connectTimeout: Duration(seconds: 10), // 🔥 thêm
        receiveTimeout: Duration(seconds: 10),
      ),
    );

    bool isRefreshing = false;

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString("accessToken");

          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }

          handler.next(options);
        },

        onError: (error, handler) async {
          final prefs = await SharedPreferences.getInstance();

          // 🔥 token hết hạn
          if (error.response?.statusCode == 401 && !isRefreshing) {
            isRefreshing = true;

            final refreshToken = prefs.getString("refreshToken");

            try {
              final res = await dio.post(
                "/auth/refresh",
                data: {"refreshToken": refreshToken},
              );

              final newAccessToken = res.data["accessToken"];

              // 🔥 lưu token mới
              await prefs.setString("accessToken", newAccessToken);

              // 🔥 retry request cũ
              final requestOptions = error.requestOptions;

              requestOptions.headers["Authorization"] =
                  "Bearer $newAccessToken";

              final cloneReq = await dio.fetch(requestOptions);

              isRefreshing = false;

              return handler.resolve(cloneReq);
            } catch (e) {
              // ❌ refresh cũng fail → logout
              await prefs.clear();

              navigatorKey.currentState?.pushNamedAndRemoveUntil(
                AppRouter.login,
                (route) => false,
              );
            }
          }

          handler.next(error);
        },
      ),
    );
  }
}
