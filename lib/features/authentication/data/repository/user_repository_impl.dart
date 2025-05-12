
import 'package:vet_mkononi/features/authentication/data/service/authentication_service.dart';
import 'package:vet_mkononi/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final AuthenticationService authService;

  UserRepositoryImpl(this.authService);

  @override
  Future<String> login(String msisdn, String password) {
    return authService.login(msisdn: msisdn, password: password);
  }
}