import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/tourist_attraction.dart';
import '../routes/app_router.dart';
import '../services/api_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class AttractionsListView extends StatefulWidget {
  const AttractionsListView({super.key});

  @override
  State<AttractionsListView> createState() => _AttractionsListViewState();
}

class _AttractionsListViewState extends State<AttractionsListView> {
  final ApiService _apiService = ApiService();
  late Future<List<TouristAttraction>> _futureAttractions;

  @override
  void initState() {
    super.initState();
    _loadAttractions();
  }

  void _loadAttractions() {
    setState(() {
      _futureAttractions = _apiService.getAttractions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Atracciones Turísticas')),
      body: FutureBuilder<List<TouristAttraction>>(
        future: _futureAttractions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(
              message: 'Descubriendo lugares turísticos...',
            );
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _loadAttractions,
            );
          }

          final attractions = snapshot.data ?? [];
          if (attractions.isEmpty) {
            return const Center(
              child: Text('No se encontraron atracciones turísticas.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadAttractions(),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: attractions.length,
              itemBuilder: (context, index) {
                final attraction = attractions[index];
                final hasImage = attraction.images.isNotEmpty;

                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: hasImage
                          ? Image.network(
                              attraction.images.first,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 52,
                                    height: 52,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.landscape,
                                      color: Colors.grey,
                                    ),
                                  ),
                            )
                          : Container(
                              width: 52,
                              height: 52,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.landscape,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    title: Text(
                      attraction.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      attraction.cityName != null
                          ? 'Ubicación: ${attraction.cityName}'
                          : 'Colombia',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      context.pushNamed(
                        AppRouter.attractionDetail,
                        extra: attraction,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
