import 'package:skincare_app/features/survey/models/survey_answer.dart';
import 'package:skincare_app/features/survey/models/survey_question.dart';
import 'package:skincare_app/features/survey/models/survey_result.dart';

class Survey {
  final String id;
  final String title;
  final String description;
  final bool isPublished;
  final List<SurveyQuestion> questions;
  final List<SurveyResult> results;
  // final List<SurveyAnswer> answers;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;

  Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.isPublished,
    required this.questions,
    required this.results,
    // required this.answers,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
  });

  factory Survey.fromJson(Map<String, dynamic> json) {
    print("SURVEY JSON: $json");

    return Survey(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      description: json["description"] ?? '',
      isPublished: json["isPublished"] ?? false,
      questions: (json["questions"] as List? ?? [])
          .map((e) => SurveyQuestion.fromJson(e))
          .toList(),
      results: (json["results"] as List? ?? [])
          .map((e) => SurveyResult.fromJson(e))
          .toList(),
      // answers: (json["answers"] as List? ?? [])
      //     .map((a) => SurveyAnswer.fromJson(a))
      //     .toList(),
      createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toString()),
      updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toString()),
      isCompleted: json["isCompleted"] ?? false,
    );
  }
}
