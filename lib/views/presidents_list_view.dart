import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/president.dart';
import '../routes/app_router.dart';
import '../services/api_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class PresidentsListView extends StatefulWidget {
  const PresidentsListView({super.key});

  @override
  State<PresidentsListView> createState() => _PresidentsListViewState();
}

class _PresidentsListViewState extends State<PresidentsListView> {
  final ApiService _apiService = ApiService();
  late Future<List<President>> _futurePresidents;

  @override
  void initState() {
    super.initState();
    _loadPresidents();
  }

  void _loadPresidents() {
    setState(() {
      _futurePresidents = _apiService.getPresidents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Presidentes de Colombia'),
      ),
      body: FutureBuilder<List<President>>(
        future: _futurePresidents,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Cargando registros históricos...');
          }

          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _loadPresidents,
            );
          }

          final presidents = snapshot.data ?? [];
          if (presidents.isEmpty) {
            return const Center(
              child: Text('No se encontraron registros de presidentes.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadPresidents(),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: presidents.length,
              itemBuilder: (context, index) {
                final president = presidents[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(24),
                      child: president.image != null && president.image!.isNotEmpty
                          ? Image.network(
                              president.image!,
                              width: 48,
                              height: 48,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                width: 48,
                                height: 48,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.person, color: Colors.grey),
                              ),
                            )
                          : Container(
                              width: 48,
                              height: 48,
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                    ),
                    title: Text(
                      president.fullName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 2),
                        Text(
                          president.politicalParty ?? 'Partido no especificado',
                          style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                        ),
                        if (president.startPeriodDate != null)
                          Text(
                            'Período: ${president.startPeriodDate} - ${president.endPeriodDate ?? "Presente"}',
                            style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                          ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      context.pushNamed(
                        AppRouter.presidentDetail,
                        extra: president,
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
