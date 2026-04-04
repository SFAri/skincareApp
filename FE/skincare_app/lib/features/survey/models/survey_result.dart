class SurveyResult {
  final String id;
  final String surveyId;
  final String title;
  final int minScore;
  final int maxScore;
  final String description;
  // List<SurveyAnswer> answers;

  SurveyResult({
    required this.id,
    required this.surveyId,
    required this.title,
    required this.minScore,
    required this.maxScore,
    required this.description,
    // required this.answers,
  });

  factory SurveyResult.fromJson(Map<String, dynamic> json) {
    return SurveyResult(
      id: json["id"] ?? '',
      surveyId: json["surveyId"] ?? '',
      title: json["title"] ?? '',
      minScore: json["minScore"] ?? 0,
      maxScore: json["maxScore"] ?? 0,
      description: json["description"] ?? '',
      // answers: (json["answer"] as List? ?? [])
      //     .map((a) => SurveyAnswer.fromJson(a))
      //     .toList(),
    );
  }
}
