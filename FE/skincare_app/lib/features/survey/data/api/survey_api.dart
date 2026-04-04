import 'package:dio/dio.dart';
import 'package:skincare_app/core/api/api_provider.dart';

class SurveyApi {
  final Dio dio = apiClient.dio;

  Future<Response> getAll() {
    return dio.get("/surveys");
  }

  Future<Response> getDetailSurvey(String surveyId) {
    return dio.get("/surveys/$surveyId");
  }

  // =========================
  // SUBMIT SURVEY
  // =========================
  Future<Response> submitSurvey({
    required String surveyId,
    required Map<String, String> answers,
  }) {
    final payload = {
      "answers": answers.entries
          .map((e) => {
                "questionId": e.key,
                "optionId": e.value,
              })
          .toList(),
    };

    return dio.post(
      "/surveys/$surveyId/submit",
      data: payload,
    );
  }
}
