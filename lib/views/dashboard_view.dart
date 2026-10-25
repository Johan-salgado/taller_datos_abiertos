import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_router.dart';
import '../widgets/endpoint_card.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colombia Open Data'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Acerca de',
            onPressed: () {
              showAboutDialog(
                context: context,
                applicationName: 'Datos Abiertos de Colombia',
                applicationVersion: '1.0.0',
                applicationLegalese: 'Taller 4 - Consumo de API Pública\nUCEVA',
                children: const [
                  SizedBox(height: 12),
                  Text(
                    'Aplicación desarrollada en Flutter consumiendo api-colombia.com.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: const BoxDecoration(
                color: Color(0xFF0F3B66),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.public,
                          color: Color(0xFFF9A825),
                          size: 26,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Datos Abiertos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Explora la riqueza geográfica, histórica, turística y gastronómica de Colombia a través de su API pública.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                'Módulos Disponibles',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 10),
            EndpointCard(
              title: 'Departamentos',
              description: 'Consulta los 32 departamentos, capitales, áreas y población.',
              icon: Icons.map_outlined,
              iconColor: const Color(0xFF0F3B66),
              onTap: () => context.pushNamed(AppRouter.departmentsList),
            ),
            EndpointCard(
              title: 'Presidentes',
              description: 'Línea de tiempo de los mandatarios colombianos y sus períodos.',
              icon: Icons.account_balance_rounded,
              iconColor: const Color(0xFF1E88E5),
              onTap: () => context.pushNamed(AppRouter.presidentsList),
            ),
            EndpointCard(
              title: 'Atracciones Turísticas',
              description: 'Lugares emblemáticos, parques naturales y puntos de interés.',
              icon: Icons.landscape_rounded,
              iconColor: const Color(0xFF43A047),
              onTap: () => context.pushNamed(AppRouter.attractionsList),
            ),
            EndpointCard(
              title: 'Platos Típicos',
              description:
                  'Gastronomía tradicional colombiana, recetas e ingredientes.',
              icon: Icons.restaurant_menu_rounded,
              iconColor: const Color(0xFFFB8C00),
              onTap: () => context.pushNamed(AppRouter.dishesList),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
