import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/department.dart';
import '../routes/app_router.dart';
import '../services/api_service.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';

class DepartmentsListView extends StatefulWidget {
  const DepartmentsListView({super.key});

  @override
  State<DepartmentsListView> createState() => _DepartmentsListViewState();
}

class _DepartmentsListViewState extends State<DepartmentsListView> {
  final ApiService _apiService = ApiService();
  late Future<List<Department>> _futureDepartments;

  @override
  void initState() {
    super.initState();
    _loadDepartments();
  }

  void _loadDepartments() {
    setState(() {
      _futureDepartments = _apiService.getDepartments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Departamentos'),
      ),
      body: FutureBuilder<List<Department>>(
        future: _futureDepartments,
        builder: (context, snapshot) {
          // 1. Estado de Carga
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingView(message: 'Consultando departamentos de Colombia...');
          }

          // 2. Estado de Error
          if (snapshot.hasError) {
            return ErrorView(
              message: snapshot.error.toString(),
              onRetry: _loadDepartments,
            );
          }

          // 3. Estado de Éxito
          final departments = snapshot.data ?? [];
          if (departments.isEmpty) {
            return const Center(
              child: Text('No se encontraron registros de departamentos.'),
            );
          }

          return RefreshIndicator(
            onRefresh: () async => _loadDepartments(),
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: departments.length,
              itemBuilder: (context, index) {
                final department = departments[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFF0F3B66).withValues(alpha: 0.1),
                      child: const Icon(
                        Icons.map,
                        color: Color(0xFF0F3B66),
                      ),
                    ),
                    title: Text(
                      department.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      department.capital != null
                          ? 'Capital: ${department.capital}'
                          : 'Municipios: ${department.municipalities}',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      context.pushNamed(
                        AppRouter.departmentDetail,
                        extra: department,
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
