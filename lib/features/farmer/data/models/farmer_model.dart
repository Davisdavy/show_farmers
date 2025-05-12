
import 'package:vet_mkononi/features/farmer/domain/entities/farmer.dart';

class FarmerModel extends Farmer {
  FarmerModel({
    required super.id,
    required super.firstName,
    required super.location,
    required super.msisdn,
    required super.farmName,
    super.balance
  });

  factory FarmerModel.fromJson(Map<String, dynamic> json) {
    return FarmerModel(
      id: json['id'],
      firstName: json['first_name'],
      location: json['location'],
      msisdn: json['msisdn'],
      farmName: json['farm_name'],
      balance: (json['balance'] ?? 0).toDouble()
    );
  }
}
