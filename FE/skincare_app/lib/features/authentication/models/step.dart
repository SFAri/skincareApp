class Step {
  final String id;
  final String name;
  final String type;

  Step({required this.id, required this.name, required this.type});

  factory Step.fromJson(Map<String, dynamic> json) {
    return Step(id: json["id"] ?? '', name: json["name"] ?? '', type:json["type"] ??'');
  }

  @override
  String toString() {
    return 'Step(id: $id, name: $name, type: $type)';
  }
}
