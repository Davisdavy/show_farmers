
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vet_mkononi/features/authentication/presentation/providers/auth_provider.dart';
import 'package:vet_mkononi/features/farmer/data/repositories/farmer_repository_impl.dart';
import 'package:vet_mkononi/features/farmer/data/service/farmer_service.dart';
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';
import 'package:vet_mkononi/features/farmer/domain/usecases/add_farmer.dart';
import 'package:vet_mkononi/features/farmer/domain/usecases/delete_farmer.dart';
import 'package:vet_mkononi/features/farmer/domain/usecases/fetch_farmers.dart';
import 'package:vet_mkononi/features/farmer/domain/usecases/update_farmer.dart';

final farmerServiceProvider = Provider((ref) => FarmerService());

final farmerRepositoryProvider = Provider((ref) {
  final token = ref.watch(tokenProvider);
  final service = ref.watch(farmerServiceProvider);
  return FarmerRepositoryImpl(service, token);
});

final fetchFarmersProvider = Provider((ref) {
  final repository = ref.watch(farmerRepositoryProvider);
  return FetchFarmers(repository);
});

final farmerListProvider = FutureProvider<List<Farmer>>((ref) async {
  final fetchFarmers = ref.watch(fetchFarmersProvider);
  return fetchFarmers();
});

final addFarmerProvider = Provider((ref) {
  return AddFarmer(ref.watch(farmerRepositoryProvider));
});

final updateFarmerProvider = Provider((ref) {
  return UpdateFarmer(ref.watch(farmerRepositoryProvider));
});

final deleteFarmerProvider = Provider((ref) {
  return DeleteFarmer(ref.watch(farmerRepositoryProvider));
});
