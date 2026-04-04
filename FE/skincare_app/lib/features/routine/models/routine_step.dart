import 'package:skincare_app/core/enums/routine_time_enum.dart';
import 'package:skincare_app/features/authentication/models/step.dart';
import 'package:skincare_app/features/product/models/step_product.dart';

class RoutineStep {
  final String id;
  final String routineId;
  final String stepId;
  final String? description;
  final int order;
  final RoutineTime time;
  final Step? step;
  final List<StepProduct> products;

  RoutineStep({
    required this.id,
    required this.routineId,
    required this.stepId,
    this.description,
    required this.order,
    required this.time,
    this.step,
    required this.products,
  });

  factory RoutineStep.fromJson(Map<String, dynamic> json) {
    return RoutineStep(
      id: json["id"] ?? '',
      routineId: json["routineId"] ?? '',
      stepId: json["stepId"] ?? '',
      description: json["description"] ?? '',
      order: json["order"] ?? 0,
      time: routineTimeFromString(json["time"]) ?? RoutineTime.MORNING,
      step: json["step"] != null ? Step.fromJson(json["step"]) : null,
      products: (json["products"] as List? ?? [])
          .map((e) => StepProduct.fromJson(e))
          .toList(),
    );
  }
}