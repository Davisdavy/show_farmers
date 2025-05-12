import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vet_mkononi/core/constants/api_constants.dart' show ApiConstants;

class AuthenticationService {
  final http.Client client;

  AuthenticationService({http.Client? httpClient})
      : client = httpClient ?? http.Client();

  Future<String>  login({
    required String msisdn,
    required String password,
  }) async {
    final response = await client.post(
      Uri.parse(ApiConstants.loginUrl()),
      headers: ApiConstants.defaultHeaders,
      body: jsonEncode({'msisdn': msisdn, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> json = jsonDecode(response.body);
      final token = json['data']?['auth_token'];
      if (token != null) {
        return token;
      } else {
        throw Exception('Token not found in response.');
      }
    } else {
      final error = jsonDecode(response.body);
      throw Exception('Login failed: ${error['message'] ?? 'Unknown error'}');
    }
  }
}
