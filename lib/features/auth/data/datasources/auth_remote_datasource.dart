import 'package:pokemon_app/features/auth/data/data.dart' show UserModel;

abstract class AuthRemoteDatasource {
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
  Future<UserModel> register({required String email, required String password});
}
