import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show UserHiveModel, UserHiveModelAdapter;
import 'package:pokemon_app/features/pokemon/data/data.dart' show PokemonModel, PokemonModelAdapter;

class HiveService {
  static const _sessionBox = 'session_box';
  static const _pokemonBox = 'pokemon_box';

  static Future<void> init() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(UserHiveModelAdapter())
      ..registerAdapter(PokemonModelAdapter());

    await Hive.openBox<UserHiveModel>(_sessionBox);
    await Hive.openBox<PokemonModel>(_pokemonBox);
  }

  static bool hasActiveSession() {
    if (!Hive.isBoxOpen(_sessionBox)) return false;
    final box = Hive.box<UserHiveModel>(_sessionBox);
    return box.get('current_user') != null;
  }

  // Pokemon methods
  static Future<void> savePokemons(List<PokemonModel> pokemons) async {
    final box = Hive.box<PokemonModel>(_pokemonBox);
    await box.clear();
    for (final pokemon in pokemons) {
      await box.put(pokemon.id, pokemon);
    }
  }

  static List<PokemonModel> getPokemons() {
    if (!Hive.isBoxOpen(_pokemonBox)) return [];
    final box = Hive.box<PokemonModel>(_pokemonBox);
    return box.values.toList();
  }

  static bool hasPokemonsCached() {
    if (!Hive.isBoxOpen(_pokemonBox)) return false;
    final box = Hive.box<PokemonModel>(_pokemonBox);
    return box.isNotEmpty;
  }

  static Future<void> clearPokemons() async {
    if (Hive.isBoxOpen(_pokemonBox)) {
      final box = Hive.box<PokemonModel>(_pokemonBox);
      await box.clear();
    }
  }
}
