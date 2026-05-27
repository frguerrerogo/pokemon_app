import 'package:pokemon_app/features/pokemon/data/data.dart' show PokemonModel;

abstract class PokemonRemoteDatasource {
  Future<List<PokemonModel>> getPokemonList({int limit, int offset});
}
