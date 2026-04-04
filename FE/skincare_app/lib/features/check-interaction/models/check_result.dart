import 'package:skincare_app/core/enums/interaction_level.dart';

class CheckResult {
  final String id;
  final InteractionLevel level;
  final String message;

  CheckResult({
    required this.id,
    required this.level,
    required this.message
  });

  factory CheckResult.fromJson(Map<String, dynamic> json) {
    return CheckResult(
      id: json["id"],
      level: interactionLevelFromString(json["level"]) ?? InteractionLevel.WARNING,
      message: json["message"],
    );
  }
}