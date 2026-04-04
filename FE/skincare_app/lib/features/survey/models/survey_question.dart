import 'package:skincare_app/features/survey/models/survey_option.dart';

class SurveyQuestion {
  final String id;
  final String surveyId;
  final String question;
  final List<SurveyOption> options;

  SurveyQuestion({
    required this.id,
    required this.surveyId,
    required this.question,
    required this.options,
  });

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) {
    return SurveyQuestion(
      id: json["id"] ?? '',
      surveyId: json["surveyId"] ?? '',
      question: json["question"] ?? '',
      options: (json["options"] as List? ?? [])
          .map((e) => SurveyOption.fromJson(e))
          .toList(),
    );
  }
}