import 'package:dio/dio.dart';
import 'package:skincare_app/core/api/api_provider.dart';

class InteractionApi {
  final Dio dio = apiClient.dio;

  Future<Response> checkInteraction(String ingredientA, String ingredientB) {
    return dio.get(
      "/check-interaction?first=$ingredientA&second=$ingredientB"
    );
  }
}
