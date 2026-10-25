import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/department.dart';
import '../models/president.dart';
import '../models/tourist_attraction.dart';
import '../models/typical_dish.dart';

import '../views/dashboard_view.dart';
import '../views/departments_list_view.dart';
import '../views/department_detail_view.dart';
import '../views/presidents_list_view.dart';
import '../views/president_detail_view.dart';
import '../views/attractions_list_view.dart';
import '../views/attraction_detail_view.dart';
import '../views/dishes_list_view.dart';
import '../views/dish_detail_view.dart';

class AppRouter {
  static const String home = 'home';

  static const String departmentsList = 'departments_list';
  static const String departmentDetail = 'department_detail';

  static const String presidentsList = 'presidents_list';
  static const String presidentDetail = 'president_detail';

  static const String attractionsList = 'attractions_list';
  static const String attractionDetail = 'attraction_detail';

  static const String dishesList = 'dishes_list';
  static const String dishDetail = 'dish_detail';

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: home,
        builder: (context, state) => const DashboardView(),
        routes: [
          GoRoute(
            path: 'departments',
            name: departmentsList,
            builder: (context, state) => const DepartmentsListView(),
            routes: [
              GoRoute(
                path: 'detail',
                name: departmentDetail,
                builder: (context, state) {
                  final department = state.extra as Department;
                  return DepartmentDetailView(department: department);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'presidents',
            name: presidentsList,
            builder: (context, state) => const PresidentsListView(),
            routes: [
              GoRoute(
                path: 'detail',
                name: presidentDetail,
                builder: (context, state) {
                  final president = state.extra as President;
                  return PresidentDetailView(president: president);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'attractions',
            name: attractionsList,
            builder: (context, state) => const AttractionsListView(),
            routes: [
              GoRoute(
                path: 'detail',
                name: attractionDetail,
                builder: (context, state) {
                  final attraction = state.extra as TouristAttraction;
                  return AttractionDetailView(attraction: attraction);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'dishes',
            name: dishesList,
            builder: (context, state) => const DishesListView(),
            routes: [
              GoRoute(
                path: 'detail',
                name: dishDetail,
                builder: (context, state) {
                  final dish = state.extra as TypicalDish;
                  return DishDetailView(dish: dish);
                },
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Ruta no encontrada')),
      body: Center(
        child: Text('No se encontró la página solicitada: ${state.uri}'),
      ),
    ),
  );
}
