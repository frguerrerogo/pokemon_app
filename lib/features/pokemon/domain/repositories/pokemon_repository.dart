import 'package:pokemon_app/features/pokemon/domain/domain.dart' show PokemonEntity;

abstract class PokemonRepository {
  Future<List<PokemonEntity>> getPokemonList({int limit = 20, int offset = 0});

  Future<PokemonEntity> getPokemonDetail(int id);
}
