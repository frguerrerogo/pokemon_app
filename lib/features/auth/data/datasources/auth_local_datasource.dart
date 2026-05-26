import 'package:pokemon_app/features/auth/data/data.dart' show UserHiveModel;

abstract class AuthLocalDatasource {
  Future<void> saveSession(UserHiveModel user);
  UserHiveModel? getSession();
  Future<void> clearSession();
}
