
import 'package:vet_mkononi/features/farmer/domain/repositories/farmer_repository.dart';

class AddFarmer {
  final FarmerRepository repository;

  AddFarmer(this.repository);

  Future<void> call(Map<String, dynamic> data) {
    return repository.addFarmer(data);
  }
}