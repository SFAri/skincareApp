import 'package:dio/dio.dart';
import 'package:skincare_app/features/survey/data/api/survey_api.dart';
import 'package:skincare_app/features/survey/models/survey_open_response.dart';
import 'package:skincare_app/features/survey/models/survey_result.dart';
import '../../models/survey.dart';
import '../../models/survey_answer.dart';

class SurveyRepository {
  final SurveyApi api = SurveyApi();
  final Dio dio = Dio(BaseOptions(baseUrl: "http://localhost:3000/api"));

  Future<List<Survey>> getAllSurveys() async {
    try {
      final res = await api.getAll();

      if (res.statusCode == 200) {
        List<Survey> surveys = (res.data as List)
            .map((survey) => Survey.fromJson(survey))
            .toList();
        return surveys;
      } else {
        throw Exception("Failed to load surveys");
      }
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  Future<SurveyOpenResponse> getSurvey(String surveyId) async {
    try {
      final res = await api.getDetailSurvey(surveyId);
      if (res.statusCode == 200) {
        print("ENTER 200------------");
        return SurveyOpenResponse.fromJson(res.data);
      } else {
        throw Exception("Failed to load survey: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
      throw e; // Ném lại lỗi để có thể xử lý sau
    }
  }

  // Future<void> submitSurvey({
  //   required String surveyId,
  //   required Map<String, String> answers,
  // }) async {
  //   await dio.post(
  //     "/survey-answers",
  //     data: {"surveyId": surveyId, "answers": answers},
  //   );
  // }

  // SURVEY-ANSWER
  Future<SurveyAnswer> getSurveyAnswer(String answerId) async {
    final res = await dio.get("/survey-answers/$answerId");

    return SurveyAnswer.fromJson(res.data);
  }

  // =========================
  // SUBMIT
  // =========================
  Future<SurveyResult?> submitSurvey({
    required String surveyId,
    required Map<String, String> answers,
  }) async {
    try {
      final res = await api.submitSurvey(
        surveyId: surveyId,
        answers: answers,
      );

      return SurveyResult.fromJson(res.data["result"]);
    } catch (e) {
      print("SUBMIT ERROR: $e");
      return null;
    }
  }
}
