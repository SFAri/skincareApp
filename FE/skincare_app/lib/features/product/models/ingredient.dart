class Ingredient {
  final String id;
  final String name;
  final String description;

  Ingredient({required this.id, required this.name, required this.description});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(id: json['id'], name: json['name'], description: json["description"] ?? '');
  }
}
