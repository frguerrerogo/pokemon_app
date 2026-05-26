// features/pokemon/domain/usecases/get_pokemons_usecase.dart
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show PokemonEntity, PokemonRepository;

class GetPokemonsUseCaseParams {
  const GetPokemonsUseCaseParams({this.limit = 20, this.offset = 0});
  final int limit;
  final int offset;
}

class GetPokemonsUseCase implements UseCase<List<PokemonEntity>, GetPokemonsUseCaseParams> {
  GetPokemonsUseCase(this.repository);
  final PokemonRepository repository;

  @override
  Future<List<PokemonEntity>> call(GetPokemonsUseCaseParams params) {
    return repository.getPokemonList(
      limit: params.limit,
      offset: params.offset,
    );
  }
}
