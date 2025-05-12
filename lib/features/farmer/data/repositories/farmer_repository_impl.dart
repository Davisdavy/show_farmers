

import 'package:vet_mkononi/features/farmer/data/models/farmer_model.dart';
import 'package:vet_mkononi/features/farmer/data/service/farmer_service.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/domain/repositories/farmer_repository.dart';

class FarmerRepositoryImpl implements FarmerRepository {
  final FarmerService service;
  final String token;

  FarmerRepositoryImpl(this.service, this.token);

  @override
  Future<List<Farmer>> fetchFarmers() async {
    final data = await service.fetchFarmers(token);
    return data.map((json) => FarmerModel.fromJson(json)).toList();
  }

  @override
  Future<void> addFarmer(Map<String, dynamic> data) {
    return service.addFarmer(token, data);
  }

  @override
  Future<void> updateFarmer(Map<String, dynamic> data) {
    return service.updateFarmer(token, data);
  }

  @override
  Future<void> deleteFarmer(String id) {
    return service.deleteFarmer(token, id);
  }
}
