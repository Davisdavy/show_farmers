
import 'package:vet_mkononi/features/farmer/domain/repositories/farmer_repository.dart';

class DeleteFarmer {
  final FarmerRepository repository;

  DeleteFarmer(this.repository);

  Future<void> call(String id) {
    return repository.deleteFarmer(id);
  }
}