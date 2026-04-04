import 'package:skincare_app/features/product/models/step_product.dart';
import 'package:skincare_app/features/product/models/product_ingredient.dart';

class Product {
  final String id;
  final String name;
  final String? imageUrl;
  final String? usage;
  final String? brand;
  final String? shopeeUrl;
  final int? price;

  final List<ProductIngredient> ingredients;
  final List<StepProduct>? steps;

  Product({
    required this.id,
    required this.name,
    this.imageUrl,
    this.brand,
    this.shopeeUrl,
    this.usage,
    this.price,
    required this.ingredients,
    this.steps,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      brand: json['brand'] ?? '',
      shopeeUrl: json['shopeeUrl'] ?? '',
      usage: json['usage'] ?? '',
      price: json['price'] ?? 0,
      ingredients: (json['ingredients'] ?? [])
          .map<ProductIngredient>((e) => ProductIngredient.fromJson(e))
          .toList(),

      steps: json['steps'] != null
          ? (json['steps'] as List).map((e) => StepProduct.fromJson(e)).toList()
          : null,
    );
  }
}
