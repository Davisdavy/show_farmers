
import 'package:vet_mkononi/features/authentication/domain/repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<String> call(String msisdn, String password) {
    return repository.login(msisdn, password);
  }
}