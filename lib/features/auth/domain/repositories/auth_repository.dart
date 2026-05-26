import 'package:pokemon_app/features/auth/domain/domain.dart' show UserEntity;

abstract class AuthRepository {
  Future<UserEntity> login({required String email, required String password});
  Future<void> logout();
  Future<UserEntity> register({required String email, required String password});
  UserEntity? getSessionFromLocal();
}
