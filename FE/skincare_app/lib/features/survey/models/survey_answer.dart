import 'package:skincare_app/features/survey/models/survey.dart';
import 'package:skincare_app/features/survey/models/survey_answer_option.dart';
import 'package:skincare_app/features/survey/models/survey_result.dart';

class SurveyAnswer {
  final String id;
  final String surveyId;
  final String userId;
  final int totalScore;
  final List<SurveyAnswerOption> selectedOptions;
  final SurveyResult result;
  final Survey survey;
  final DateTime createdAt;

  SurveyAnswer({
    required this.id,
    required this.surveyId,
    required this.userId,
    required this.totalScore,
    required this.selectedOptions,
    required this.survey,
    required this.result,
    required this.createdAt,
  });

  factory SurveyAnswer.fromJson(Map<String, dynamic> json) {
    print("SURVEY ANSWER JSON: $json");

    return SurveyAnswer(
      id: json["id"] ?? '',
      surveyId: json["surveyId"] ?? '',
      userId: json["userId"] ?? '',
      totalScore: json["totalScore"] ?? 0,
      selectedOptions: (json["selectedOptions"] as List? ?? [])
          .map((e) => SurveyAnswerOption.fromJson(e))
          .toList(),
      survey: Survey.fromJson(json["survey"]),
      result: SurveyResult.fromJson(json["result"]),
      createdAt: DateTime.parse(
        json["createdAt"] ?? DateTime.now().toIso8601String(),
      ),
    );
  }
}
