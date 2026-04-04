import 'package:dio/dio.dart';
import 'package:skincare_app/core/api/api_provider.dart';

class RoutineApi {
  final Dio dio = apiClient.dio;

  // GET ALL
  Future<Response> getAll() {
    return dio.get("/routines");
  }

  // GET BY ID
  Future<Response> getById(String id) {
    return dio.get("/routines/$id");
  }

  // SAVE ROUTINE
  Future<Response> saveRoutine(String routineId) {
    return dio.post("/user-routines/$routineId");
  }

  // UNSAVED ROUTINE
  Future<Response> unSaveRoutine(String routineId) {
    return dio.delete("/user-routines/$routineId");
  }

  // Future<Response> login(String email, String password) {
  //   return dio.post(
  //     "/auth/login",
  //     data: {"email": email, "password": password},
  //   );
  // }

  // Future<Response> register(
  //   String email,
  //   String password,
  //   String name,
  //   String phone,
  // ) {
  //   return dio.post(
  //     "/auth/register",
  //     data: {
  //       "email": email,
  //       "password": password,
  //       "name": name,
  //       "phone": phone,
  //     },
  //   );
  // }

  // Future<Response> getMe() {
  //   return dio.get("/auth/me");
  // }

  // Future<Response> updateMe(Map<String, dynamic> data) {
  //   return dio.patch("/users/update-info/me", data: data);
  // }

  // Future<Response> changePassword(String oldPassword, String newPassword) {
  //   return dio.patch("/users/me/password", data: {"oldPassword":oldPassword, "newPassword": newPassword});
  // }
}
