import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonMapper, PokemonRemoteDatasource;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show PokemonEntity, PokemonRepository;

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required PokemonRemoteDatasource pokemonRemoteDataSource,
    required PokemonMapper pokemonMapper,
  })  : _pokemonRemoteDataSource = pokemonRemoteDataSource,
        _pokemonMapper = pokemonMapper;
  final PokemonRemoteDatasource _pokemonRemoteDataSource;
  final PokemonMapper _pokemonMapper;

  @override
  Future<List<PokemonEntity>> getPokemonList({
    int limit = 20,
    int offset = 0,
  }) async {
    final models = await _pokemonRemoteDataSource.getPokemonList(
      limit: limit,
      offset: offset,
    );
    return _pokemonMapper.modelsToEntities(models);
  }

  @override
  Future<PokemonEntity> getPokemonDetail(int id) async {
    final model = await _pokemonRemoteDataSource.getPokemonDetail(id);
    return _pokemonMapper.modelToEntity(model);
  }
}
