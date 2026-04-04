import 'package:skincare_app/core/enums/role_enum.dart';
import 'package:skincare_app/features/survey/models/survey_answer.dart';
import 'package:skincare_app/features/authentication/models/user_routine.dart';

class User {
  final String id;
  final String email;
  final String? name;
  final String? phone;
  final String? imageUrl;
  final String? dob;
  final Role? role;
  final List<SurveyAnswer>? answers;
  final List<UserRoutine>? userRoutines;

  User({
    required this.id,
    required this.email,
    this.name,
    this.phone,
    this.imageUrl,
    this.dob,
    this.role,
    this.answers,
    this.userRoutines,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"]?.toString() ?? "",
      email: json["email"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      phone: json["phone"]?.toString() ?? "",
      imageUrl: json["imageUrl"]?.toString() ?? "",
      dob: json["dob"]?.toString() ?? "",
      role: roleFromString(json["role"] ?? "USER"),
      answers: (json["answers"] as List? ?? [])
          .map((e) => SurveyAnswer.fromJson(e))
          .toList(),
      userRoutines: (json["UserRoutine"] as List? ?? [])
          .map((e) => UserRoutine.fromJson(e))
          .toList(),
    );
  }
}