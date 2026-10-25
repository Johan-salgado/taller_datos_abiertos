class TouristAttraction {
  final int id;
  final String name;
  final String description;
  final List<String> images;
  final String? latitude;
  final String? longitude;
  final String? cityName;

  TouristAttraction({
    required this.id,
    required this.name,
    required this.description,
    required this.images,
    this.latitude,
    this.longitude,
    this.cityName,
  });

  factory TouristAttraction.fromJson(Map<String, dynamic> json) {
    List<String> imageList = [];
    if (json['images'] is List) {
      imageList = (json['images'] as List)
          .where((img) => img != null && img.toString().trim().isNotEmpty)
          .map((img) => img.toString())
          .toList();
    }

    String? city;
    if (json['city'] is Map<String, dynamic>) {
      city = json['city']['name'] as String?;
    }

    return TouristAttraction(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Atracción turística',
      description: json['description'] as String? ?? 'Sin descripción disponible',
      images: imageList,
      latitude: json['latitude']?.toString(),
      longitude: json['longitude']?.toString(),
      cityName: city,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'images': images,
      'latitude': latitude,
      'longitude': longitude,
      'cityName': cityName,
    };
  }
}
