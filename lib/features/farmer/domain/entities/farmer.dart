
class Farmer {
  final String id;
  final String firstName;
  final String location;
  final String msisdn;
  final String farmName;
  final double? balance;

  Farmer({
    required this.id,
    required this.firstName,
    required this.location,
    required this.msisdn,
    required this.farmName,
     this.balance,
  });
}
