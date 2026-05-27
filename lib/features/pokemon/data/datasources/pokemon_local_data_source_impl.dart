import 'package:pokemon_app/core/core.dart' show HiveService;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonLocalDatasource, PokemonModel;
import 'package:pokemon_app/features/pokemon/data/models/pokemon_hive_model.dart';

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  Future<List<PokemonModel>> getPokemonList({int limit = 20, int offset = 0}) async {
    final cachedPokemons = HiveService.getPokemons();

    if (cachedPokemons.isEmpty) {
      return [];
    }

    // Apply pagination to cached data
    final start = offset;
    final end = (offset + limit).clamp(0, cachedPokemons.length);

    if (start >= cachedPokemons.length) {
      return [];
    }

    return cachedPokemons.sublist(start, end).map((hiveModel) {
      return PokemonModel(
        id: hiveModel.id,
        name: hiveModel.name,
        height: hiveModel.height,
        weight: hiveModel.weight,
        imageUrl: hiveModel.imageUrl,
        hp: hiveModel.hp,
        attack: hiveModel.attack,
        defense: hiveModel.defense,
        specialAttack: hiveModel.specialAttack,
        specialDefense: hiveModel.specialDefense,
        speed: hiveModel.speed,
      );
    }).toList();
  }

  @override
  Future<void> savePokemonList(List<PokemonModel> pokemons) async {
    final hiveModels = pokemons.map((pokemon) {
      return PokemonHiveModel(
        id: pokemon.id,
        name: pokemon.name,
        height: pokemon.height,
        weight: pokemon.weight,
        imageUrl: pokemon.imageUrl,
        hp: pokemon.hp,
        attack: pokemon.attack,
        defense: pokemon.defense,
        specialAttack: pokemon.specialAttack,
        specialDefense: pokemon.specialDefense,
        speed: pokemon.speed,
      );
    }).toList();

    await HiveService.savePokemons(hiveModels);
  }

  @override
  bool hasCachedPokemons() {
    return HiveService.hasPokemonsCached();
  }

  @override
  Future<void> clearPokemons() async {
    await HiveService.clearPokemons();
  }
}
