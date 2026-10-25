class TypicalDish {
  final int id;
  final String name;
  final String description;
  final String? ingredients;
  final String? imageUrl;
  final String? departmentName;

  TypicalDish({
    required this.id,
    required this.name,
    required this.description,
    this.ingredients,
    this.imageUrl,
    this.departmentName,
  });

  factory TypicalDish.fromJson(Map<String, dynamic> json) {
    String? depName;
    if (json['department'] is Map<String, dynamic>) {
      depName = json['department']['name'] as String?;
    }

    return TypicalDish(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Plato típico',
      description:
          json['description'] as String? ?? 'Sin descripción disponible',
      ingredients: json['ingredients'] as String?,
      imageUrl: json['imageUrl'] as String?,
      departmentName: depName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'ingredients': ingredients,
      'imageUrl': imageUrl,
      'departmentName': departmentName,
    };
  }
}
