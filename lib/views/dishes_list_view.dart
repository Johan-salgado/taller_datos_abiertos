import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/typical_dish.dart';
import '../routes/app_router.dart';
import '../services/api_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class DishesListView extends StatefulWidget {
  const DishesListView({super.key});

  @override
  State<DishesListView> createState() => _DishesListViewState();
}

class _DishesListViewState extends State<DishesListView> {
  final ApiService _apiService = ApiService();
  late Future<List<TypicalDish>> _futureDishes;

  @override
  void initState() {
    super.initState();
    _loadDishes();
  }

  void _loadDishes() {
    setState(() {
      _futureDishes = _apiService.getDishes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Platos Típicos')),
      body: FutureBuilder<List<TypicalDish>>(
        future: _futureDishes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(
              message: 'Cargando delicias colombianas...',
            );
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _loadDishes,
            );
          }

          final dishes = snapshot.data ?? [];
          if (dishes.isEmpty) {
            return const Center(
              child: Text('No se encontraron platos típicos.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadDishes(),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: dishes.length,
              itemBuilder: (context, index) {
                final dish = dishes[index];
                final hasImage =
                    dish.imageUrl != null && dish.imageUrl!.isNotEmpty;

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
                              dish.imageUrl!,
                              width: 52,
                              height: 52,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 52,
                                    height: 52,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.restaurant,
                                      color: Colors.grey,
                                    ),
                                  ),
                            )
                          : Container(
                              width: 52,
                              height: 52,
                              color: Colors.grey.shade200,
                              child: const Icon(
                                Icons.restaurant,
                                color: Colors.grey,
                              ),
                            ),
                    ),
                    title: Text(
                      dish.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      dish.departmentName != null
                          ? 'Origen: ${dish.departmentName}'
                          : 'Gastronomía Colombiana',
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
                      context.pushNamed(AppRouter.dishDetail, extra: dish);
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
