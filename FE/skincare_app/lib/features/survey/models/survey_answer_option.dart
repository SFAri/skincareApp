import 'package:skincare_app/features/survey/models/survey_answer.dart';
import 'package:skincare_app/features/survey/models/survey_option.dart';

class SurveyAnswerOption {
  final String id;
  final String optionId;
  final String answerId;
  final SurveyOption? option;
  final SurveyAnswer? answer;

  SurveyAnswerOption({
    this.option,
    required this.id,
    required this.optionId,
    required this.answerId,
    this.answer

  });

  factory SurveyAnswerOption.fromJson(Map<String, dynamic> json) {
    return SurveyAnswerOption(
      id: json["id"],
      optionId: json["optionId"],
      answerId: json["answerId"],
      option: json["option"] != null
      ? SurveyOption.fromJson(json["option"])
      :null,
      answer: json["answer"] != null
          ? SurveyAnswer.fromJson(json["answer"])
          : null,
    );
  }
}
