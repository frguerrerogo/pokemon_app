import 'package:hive_ce/hive.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show AuthLocalDatasource, UserHiveModel;

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  static const _boxName = 'session_box';
  static const _sessionKey = 'current_user';

  Box<UserHiveModel> get _box => Hive.box<UserHiveModel>(_boxName);

  @override
  Future<void> saveSession(UserHiveModel user) async {
    await _box.put(_sessionKey, user);
  }

  @override
  UserHiveModel? getSession() {
    return _box.get(_sessionKey);
  }

  @override
  Future<void> clearSession() async {
    await _box.delete(_sessionKey);
  }
}
