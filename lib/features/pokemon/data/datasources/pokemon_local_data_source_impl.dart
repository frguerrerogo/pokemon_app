import 'package:pokemon_app/core/core.dart' show HiveService;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonLocalDatasource, PokemonModel;

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  @override
  Future<List<PokemonModel>> getPokemonList({int limit = 20, int offset = 0}) async {
    final cachedPokemons = HiveService.getPokemons();

    if (cachedPokemons.isEmpty) {
      return [];
    }

    final start = offset;
    final end = (offset + limit).clamp(0, cachedPokemons.length);

    if (start >= cachedPokemons.length) {
      return [];
    }

    return cachedPokemons.sublist(start, end);
  }

  @override
  Future<void> savePokemonList(List<PokemonModel> pokemons) async {
    await HiveService.savePokemons(pokemons);
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
