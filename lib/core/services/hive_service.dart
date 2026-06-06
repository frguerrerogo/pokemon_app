import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show UserHiveModel, UserHiveModelAdapter;
import 'package:pokemon_app/features/pokemon/data/data.dart' show PokemonModel, PokemonModelAdapter;

class HiveBoxNames {
  static const String session = 'session_box';
  static const String pokemon = 'pokemon_box';
}

class HiveService {
  static Future<void> initialize() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(UserHiveModelAdapter())
      ..registerAdapter(PokemonModelAdapter());

    await Hive.openBox<UserHiveModel>(HiveBoxNames.session);
    await Hive.openBox<PokemonModel>(HiveBoxNames.pokemon);
  }

  static bool hasActiveSession() {
    if (!Hive.isBoxOpen(HiveBoxNames.session)) return false;
    final box = Hive.box<UserHiveModel>(HiveBoxNames.session);
    return box.get('current_user') != null;
  }

  // Pokemon methods
  static Future<void> savePokemons(List<PokemonModel> pokemons) async {
    final box = Hive.box<PokemonModel>(HiveBoxNames.pokemon);
    await box.clear();
    for (final pokemon in pokemons) {
      await box.put(pokemon.id, pokemon);
    }
  }

  static List<PokemonModel> getPokemons() {
    if (!Hive.isBoxOpen(HiveBoxNames.pokemon)) return [];
    final box = Hive.box<PokemonModel>(HiveBoxNames.pokemon);
    return box.values.toList();
  }

  static bool hasPokemonsCached() {
    if (!Hive.isBoxOpen(HiveBoxNames.pokemon)) return false;
    final box = Hive.box<PokemonModel>(HiveBoxNames.pokemon);
    return box.isNotEmpty;
  }

  static Future<void> clearPokemons() async {
    if (Hive.isBoxOpen(HiveBoxNames.pokemon)) {
      final box = Hive.box<PokemonModel>(HiveBoxNames.pokemon);
      await box.clear();
    }
  }
}
