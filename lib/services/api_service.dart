import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/department.dart';
import '../models/president.dart';
import '../models/tourist_attraction.dart';
import '../models/typical_dish.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<Department>> getDepartments() async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.departmentsEndpoint}',
    );
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data
            .map((item) => Department.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException(
          'Error del servidor al obtener departamentos: Código ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException('No se pudo establecer conexión a Internet.');
    } on FormatException {
      throw const FormatException(
        'Error en el formato de respuesta del servidor.',
      );
    }
  }

  Future<List<President>> getPresidents() async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.presidentsEndpoint}',
    );
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data
            .map((item) => President.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException(
          'Error del servidor al obtener presidentes: Código ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException('No se pudo establecer conexión a Internet.');
    } on FormatException {
      throw const FormatException(
        'Error en el formato de respuesta del servidor.',
      );
    }
  }

  Future<List<TouristAttraction>> getAttractions() async {
    final uri = Uri.parse(
      '${ApiConfig.baseUrl}${ApiConfig.attractionsEndpoint}',
    );
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data
            .map(
              (item) =>
                  TouristAttraction.fromJson(item as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw HttpException(
          'Error del servidor al obtener atracciones: Código ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException('No se pudo establecer conexión a Internet.');
    } on FormatException {
      throw const FormatException(
        'Error en el formato de respuesta del servidor.',
      );
    }
  }

  Future<List<TypicalDish>> getDishes() async {
    final uri = Uri.parse('${ApiConfig.baseUrl}${ApiConfig.dishesEndpoint}');
    try {
      final response = await _client.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
        return data
            .map((item) => TypicalDish.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw HttpException(
          'Error del servidor al obtener platos típicos: Código ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException('No se pudo establecer conexión a Internet.');
    } on FormatException {
      throw const FormatException(
        'Error en el formato de respuesta del servidor.',
      );
    }
  }
}
