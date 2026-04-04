import 'package:skincare_app/features/routine/models/routine.dart';

class UserRoutine {
  final String id;
  final String userId;
  final String routineId;
  final DateTime savedAt;
  final Routine? routine;

  UserRoutine({
    required this.id,
    required this.userId,
    required this.routineId,
    required this.savedAt,
    this.routine,
  });

  factory UserRoutine.fromJson(Map<String, dynamic> json) {
    return UserRoutine(
      id: json["id"],
      userId: json["userId"],
      routineId: json["routineId"],
      savedAt: DateTime.parse(json["savedAt"]),
      routine:
          json["routine"] != null ? Routine.fromJson(json["routine"]) : null,
    );
  }
}