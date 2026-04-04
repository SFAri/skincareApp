import 'package:skincare_app/features/survey/models/survey_answer_option.dart';

class SurveyOption {
  final String id;
  final String questionId;
  final String option;
  final int score;
  // final List<SurveyAnswerOption> answerOption;

  SurveyOption({
    required this.id,
    required this.questionId,
    required this.option,
    required this.score,
    // required this.answerOption,
  });

  factory SurveyOption.fromJson(Map<String, dynamic> json) {
    return SurveyOption(
      id: json["id"] ?? '',
      questionId: json["questionId"] ?? '',
      option: json["option"] ?? '',
      score: json["score"] ?? 0,
      // answerOption: (json["answerOption"] as List? ?? [])
      //     .map((e) => SurveyAnswerOption.fromJson(e))
      //     .toList(),
    );
  }
}
