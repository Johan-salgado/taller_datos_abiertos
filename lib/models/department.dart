class Department {
  final int id;
  final String name;
  final String description;
  final String? capital;
  final int municipalities;
  final num surface;
  final num population;
  final String? phonePrefix;

  Department({
    required this.id,
    required this.name,
    required this.description,
    this.capital,
    required this.municipalities,
    required this.surface,
    required this.population,
    this.phonePrefix,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    String? capName;
    if (json['cityCapital'] is Map<String, dynamic>) {
      capName = json['cityCapital']['name'];
    }

    return Department(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Sin nombre',
      description: json['description'] as String? ?? 'Sin descripción disponible',
      capital: capName,
      municipalities: json['municipalities'] as int? ?? 0,
      surface: json['surface'] as num? ?? 0,
      population: json['population'] as num? ?? 0,
      phonePrefix: json['phonePrefix']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capital': capital,
      'municipalities': municipalities,
      'surface': surface,
      'population': population,
      'phonePrefix': phonePrefix,
    };
  }
}
