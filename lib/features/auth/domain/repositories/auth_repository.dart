import 'package:pokemon_app/features/auth/domain/domain.dart' show UserEntity;

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> logout();
  Future<UserEntity> register(String email, String password);
}
