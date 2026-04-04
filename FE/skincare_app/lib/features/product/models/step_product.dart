import 'package:skincare_app/features/product/models/product.dart';

class StepProduct {
  final String id;
  final String routineStepId;
  final String productId;
  final int? priority;
  final String? note;
  final Product? product;

  StepProduct({
    required this.id,
    required this.routineStepId,
    required this.productId,
    this.priority,
    this.note,
    this.product
  });

  factory StepProduct.fromJson(Map<String, dynamic> json) {
    return StepProduct(
      id: json["id"] ?? '',
      routineStepId: json["routineStepId"] ?? '',
      productId: json["productId"] ?? '',
      priority: json["priority"] ?? 1,
      note: json["note"] ?? '',
      product: json["product"] != null
          ? Product.fromJson(json["product"])
          : null,
    );
  }
}
