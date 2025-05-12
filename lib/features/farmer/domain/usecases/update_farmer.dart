
import 'package:vet_mkononi/features/farmer/domain/repositories/farmer_repository.dart';

class UpdateFarmer {
  final FarmerRepository repository;

  UpdateFarmer(this.repository);

  Future<void> call(Map<String, dynamic> data) {
    return repository.updateFarmer(data);
  }
}