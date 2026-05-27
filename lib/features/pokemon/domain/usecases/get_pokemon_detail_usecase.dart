import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show PokemonEntity, PokemonRepository;

class GetPokemonDetailUseCase implements UseCase<PokemonEntity, int> {
  GetPokemonDetailUseCase(this.repository);
  final PokemonRepository repository;

  @override
  Future<PokemonEntity> call(int params) {
    return repository.getPokemonDetail(params);
  }
}
