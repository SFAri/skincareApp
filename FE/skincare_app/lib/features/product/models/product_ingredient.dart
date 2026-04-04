import 'package:skincare_app/features/product/models/ingredient.dart';

class ProductIngredient {
  final String productId;
  final String ingredientId;
  final Ingredient? ingredient;

  ProductIngredient({required this.ingredient, required this.productId, required this.ingredientId});

  factory ProductIngredient.fromJson(Map<String, dynamic> json) {
    return ProductIngredient(
      productId: json["productId"] ?? '',
      ingredientId: json["ingredientId"] ?? '',
      ingredient: json["ingredient"] != null
          ? Ingredient.fromJson(json["ingredient"])
          : null,
    );
  }
}
