import 'package:hive_flutter/hive_flutter.dart';
import 'package:pokemon_app/features/auth/data/models/user_hive_model.dart';

class HiveService {
  static const _sessionBox = 'session_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserHiveModelAdapter());

    await Hive.openBox<UserHiveModel>(_sessionBox);
  }

  static bool hasActiveSession() {
    if (!Hive.isBoxOpen(_sessionBox)) return false;

    final box = Hive.box<UserHiveModel>(_sessionBox);
    return box.get('current_user') != null;
  }
}
