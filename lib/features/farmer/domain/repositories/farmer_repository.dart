
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';

abstract class FarmerRepository {
  Future<List<Farmer>> fetchFarmers();
  Future<void> addFarmer(Map<String, dynamic> data);
  Future<void> updateFarmer(Map<String, dynamic> data);
  Future<void> deleteFarmer(String id);
}