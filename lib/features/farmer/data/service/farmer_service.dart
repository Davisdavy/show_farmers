import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vet_mkononi/core/constants/api_constants.dart';

class FarmerService {
  final http.Client client;

  FarmerService({http.Client? httpClient})
      : client = httpClient ?? http.Client();

  Future<List<Map<String, dynamic>>> fetchFarmers(String token) async {
    final response = await client.get(
      Uri.parse(ApiConstants.farmerListUrl()),
      headers: {
        ...ApiConstants.defaultHeaders,
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final farmerList = json['data']['farmers'] as List;
      return farmerList.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to fetch farmers');
    }
  }

  Future<void> addFarmer(String token, Map<String, dynamic> data) async {
    final response = await client.post(
      Uri.parse(ApiConstants.addFarmerUrl()),
      headers: {
        ...ApiConstants.defaultHeaders,
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add farmer');
    }
  }

  Future<void> updateFarmer(String token, Map<String, dynamic> data) async {
    final response = await client.patch(
      Uri.parse(ApiConstants.editFarmerUrl()),
      headers: {
        ...ApiConstants.defaultHeaders,
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode != 200) {
      final error = jsonDecode(response.body);
      throw Exception('Update failed: ${error['message'] ?? 'Unknown error'}');
    }
  }

  Future<void> deleteFarmer(String token, String id) async {
    final response = await client.delete(
      Uri.parse(ApiConstants.deleteFarmerUrl(id)),
      headers: {
        ...ApiConstants.defaultHeaders,
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete farmer');
    }
  }

}
