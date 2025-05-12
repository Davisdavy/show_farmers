

import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/domain/repositories/farmer_repository.dart';

class FetchFarmers {
  final FarmerRepository repository;

  FetchFarmers(this.repository);

  Future<List<Farmer>> call() => repository.fetchFarmers();
}
