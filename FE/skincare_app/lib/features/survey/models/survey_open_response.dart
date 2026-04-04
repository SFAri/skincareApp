import 'package:skincare_app/features/survey/models/survey.dart';
import 'package:skincare_app/features/survey/models/survey_answer.dart';

class SurveyOpenResponse {
  final String mode;
  final Survey? survey;
  final SurveyAnswer? answer;

  SurveyOpenResponse({
    required this.mode,
    this.survey,
    this.answer,
  });

  factory SurveyOpenResponse.fromJson(Map<String, dynamic> json) {
    print("SURVEY OPEN RESPONSE JSON: $json");
    return SurveyOpenResponse(
      mode: json["mode"] ?? '',
      survey: json["survey"] != null 
          ? Survey.fromJson(json["survey"]) 
          : null,
      answer: json["answer"] != null
          ? SurveyAnswer.fromJson(json["answer"])
          : null,
    );
  }
}
