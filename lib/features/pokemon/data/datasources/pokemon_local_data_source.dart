import 'package:pokemon_app/features/pokemon/data/data.dart' show PokemonModel;

abstract class PokemonLocalDatasource {
  Future<List<PokemonModel>> getPokemonList({int limit, int offset});

  Future<void> savePokemonList(List<PokemonModel> pokemons);

  bool hasCachedPokemons();

  Future<void> clearPokemons();
}
