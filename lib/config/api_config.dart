import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  static String get baseUrl {
    return dotenv.env['API_BASE_URL'] ?? 'https://api-colombia.com/api/v1';
  }

  static const String departmentsEndpoint = '/Department';
  static const String presidentsEndpoint = '/President';
  static const String attractionsEndpoint = '/TouristicAttraction';
  static const String dishesEndpoint = '/TypicalDish';
}
