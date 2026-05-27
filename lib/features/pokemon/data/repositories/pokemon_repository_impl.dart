import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonLocalDatasource, PokemonMapper, PokemonRemoteDatasource;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show PokemonEntity, PokemonRepository;

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required PokemonRemoteDatasource pokemonRemoteDataSource,
    required PokemonLocalDatasource pokemonLocalDataSource,
    required PokemonMapper pokemonMapper,
  })  : _pokemonRemoteDataSource = pokemonRemoteDataSource,
        _pokemonLocalDataSource = pokemonLocalDataSource,
        _pokemonMapper = pokemonMapper;

  final PokemonRemoteDatasource _pokemonRemoteDataSource;
  final PokemonLocalDatasource _pokemonLocalDataSource;
  final PokemonMapper _pokemonMapper;

  @override
  Future<List<PokemonEntity>> getPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    if (offset == 0 && _pokemonLocalDataSource.hasCachedPokemons()) {
      final models = await _pokemonLocalDataSource.getPokemonList(
        limit: limit,
        offset: offset,
      );
      return _pokemonMapper.modelsToEntities(models);
    }

    final models = await _pokemonRemoteDataSource.getPokemonList(
      limit: limit,
      offset: offset,
    );

    if (offset == 0) {
      await _pokemonLocalDataSource.savePokemonList(models);
    }

    return _pokemonMapper.modelsToEntities(models);
  }

  @override
  Future<PokemonEntity> getPokemonDetail(int id) async {
    final model = await _pokemonRemoteDataSource.getPokemonDetail(id);
    return _pokemonMapper.modelToEntity(model);
  }
}
