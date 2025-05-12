
class ApiConstants {
  static const String baseUrl = 'https://staging.vet-mkononi.co.ke/api/v1';

  static const Map<String, String> defaultHeaders = {
    'x-api-version': '1.0.0',
    'Content-Type': 'application/json',
  };

  static String loginUrl() => '$baseUrl/auth/login';
  static String farmerListUrl() => '$baseUrl/farmers/list';
  static String addFarmerUrl() => '$baseUrl/farmers/add';
  static String editFarmerUrl() => '$baseUrl/farmers/edit';
  static String deleteFarmerUrl(String farmerId) => '$baseUrl/farmers/$farmerId';
}
