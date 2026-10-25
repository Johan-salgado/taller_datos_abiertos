import 'package:flutter/material.dart';
import '../models/president.dart';

class PresidentDetailView extends StatelessWidget {
  final President president;

  const PresidentDetailView({super.key, required this.president});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(president.fullName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Tarjeta de Perfil con Foto
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: president.image != null && president.image!.isNotEmpty
                            ? Image.network(
                                president.image!,
                                height: 200,
                                width: 160,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: 160,
                                  width: 160,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.person, size: 64, color: Colors.grey),
                                ),
                              )
                            : Container(
                                height: 160,
                                width: 160,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.person, size: 64, color: Colors.grey),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      president.fullName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E88E5).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        president.politicalParty ?? 'Independiente',
                        style: const TextStyle(
                          color: Color(0xFF1E88E5),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tarjeta de Mandato
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Período Presidencial',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today_outlined, size: 20, color: Color(0xFF1E88E5)),
                        const SizedBox(width: 12),
                        Text(
                          'Inicio: ${president.startPeriodDate ?? "No disponible"}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.event_available_outlined, size: 20, color: Color(0xFF1E88E5)),
                        const SizedBox(width: 12),
                        Text(
                          'Fin: ${president.endPeriodDate ?? "En ejercicio"}',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Tarjeta de Biografía
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reseña Histórica',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 20),
                    Text(
                      president.description,
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
