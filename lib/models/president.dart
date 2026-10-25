class President {
  final int id;
  final String name;
  final String lastName;
  final String? image;
  final String? startPeriodDate;
  final String? endPeriodDate;
  final String? politicalParty;
  final String description;

  President({
    required this.id,
    required this.name,
    required this.lastName,
    this.image,
    this.startPeriodDate,
    this.endPeriodDate,
    this.politicalParty,
    required this.description,
  });

  String get fullName => '$name $lastName'.trim();

  factory President.fromJson(Map<String, dynamic> json) {
    return President(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      image: json['image'] as String?,
      startPeriodDate: json['startPeriodDate'] as String?,
      endPeriodDate: json['endPeriodDate'] as String?,
      politicalParty:
          json['politicalParty'] as String? ??
          'Independiente / No especificado',
      description:
          json['description'] as String? ?? 'Sin información disponible',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'image': image,
      'startPeriodDate': startPeriodDate,
      'endPeriodDate': endPeriodDate,
      'politicalParty': politicalParty,
      'description': description,
    };
  }
}
