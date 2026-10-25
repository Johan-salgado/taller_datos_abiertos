import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  /// URL base para consumir la API de Colombia.
  /// Se lee desde el archivo .env cargado con flutter_dotenv.
  /// Si por alguna razón no se encuentra, tiene un fallback seguro.
  static String get baseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';
  }

  // Endpoints solicitados
  static const String departmentsEndpoint = '/Department';
  static const String presidentsEndpoint = '/President';
  static const String attractionsEndpoint = '/TouristicAttraction';
  static const String dishesEndpoint = '/TypicalDish';
}
