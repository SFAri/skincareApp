import 'package:skincare_app/features/routine/models/routine_step.dart';

class Routine {
  final String id;
  final String title;
  final String? desc;
  final List<RoutineStep> routineSteps;
  bool isSaved;

  Routine({
    required this.id,
    required this.title,
    required this.isSaved,
    this.desc,
    required this.routineSteps,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json["id"] ?? '',
      title: json["title"] ?? '',
      desc: json["desc"] ?? '',
      isSaved: json["isSaved"] ?? false,
      routineSteps: (json["routineSteps"] as List? ?? [])
          .map((e) => RoutineStep.fromJson(e))
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Routine(id: $id, title: $title, steps: ${routineSteps.length})';
  }
}
