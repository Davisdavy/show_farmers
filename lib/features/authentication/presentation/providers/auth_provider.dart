

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vet_mkononi/features/authentication/data/service/authentication_service.dart';
import 'package:vet_mkononi/features/authentication/data/repository/user_repository_impl.dart';
import 'package:vet_mkononi/features/authentication/domain/repositories/user_repository.dart';
import 'package:vet_mkononi/features/authentication/domain/usecases/login_user.dart';

class AuthProvider extends StateNotifier<AsyncValue<String?>> {
  final LoginUser loginUser;

  AuthProvider(this.loginUser) : super(const AsyncValue.data(null));

  Future<void> login(String msisdn, String password) async {
    state = const AsyncValue.loading();
    try {
      final token = await loginUser(msisdn, password);
      state = AsyncValue.data(token);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
/*
 Providers
 */
final authServiceProvider = Provider((ref) => AuthenticationService());

final userRepositoryProvider = Provider<UserRepository>(
      (ref) => UserRepositoryImpl(ref.read(authServiceProvider)),
);

final loginUserProvider = Provider((ref) => LoginUser(ref.read(userRepositoryProvider)));

final authProvider =
StateNotifierProvider<AuthProvider, AsyncValue<String?>>(
      (ref) => AuthProvider(ref.read(loginUserProvider)),
);

final tokenProvider = Provider<String>((ref) {
  final authState = ref.watch(authProvider);
  return authState.when(
    data: (token) => token ?? '',
    loading: () => '',
    error: (_, __) => '',
  );
});