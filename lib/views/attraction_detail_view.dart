import 'package:flutter/material.dart';
import '../models/tourist_attraction.dart';

class AttractionDetailView extends StatelessWidget {
  final TouristAttraction attraction;

  const AttractionDetailView({super.key, required this.attraction});

  @override
  Widget build(BuildContext context) {
    final hasImages = attraction.images.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(attraction.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Galería o Imagen principal
            Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  if (hasImages)
                    Image.network(
                      attraction.images.first,
                      height: 220,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                      ),
                    )
                  else
                    Container(
                      height: 180,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.landscape, size: 60, color: Colors.grey),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          attraction.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (attraction.cityName != null) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 16, color: Color(0xFF43A047)),
                              const SizedBox(width: 4),
                              Text(
                                attraction.cityName!,
                                style: const TextStyle(
                                  color: Color(0xFF43A047),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Tarjeta de Coordenadas
            if (attraction.latitude != null || attraction.longitude != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Coordenadas Geográficas',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const Divider(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.explore_outlined, size: 20, color: Color(0xFF43A047)),
                          const SizedBox(width: 12),
                          Text('Latitud: ${attraction.latitude ?? "N/A"}'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.explore_outlined, size: 20, color: Color(0xFF43A047)),
                          const SizedBox(width: 12),
                          Text('Longitud: ${attraction.longitude ?? "N/A"}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 12),

            // Tarjeta de Descripción
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Acerca del lugar',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 20),
                    Text(
                      attraction.description,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
