import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show
        PokemonLocalDatasource,
        PokemonLocalDatasourceImpl,
        PokemonMapper,
        PokemonRemoteDatasource,
        PokemonRemoteDatasourceImpl,
        PokemonRepositoryImpl;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonDetailUseCase, GetPokemonsUseCase, PokemonRepository;

class PokemonBinding extends Bindings {
  @override
  void dependencies() {
    _datasources();
    _mappers();
    _repositories();
    _useCases();
  }

  void _datasources() {
    Get
      ..lazyPut<PokemonRemoteDatasource>(
        () => PokemonRemoteDatasourceImpl(
          dioClient: Get.find(),
        ),
        fenix: true,
      )
      ..lazyPut<PokemonLocalDatasource>(
        PokemonLocalDatasourceImpl.new,
        fenix: true,
      );
  }

  void _mappers() {
    Get.lazyPut<PokemonMapper>(
      PokemonMapper.new,
      fenix: true,
    );
  }

  void _repositories() {
    Get.lazyPut<PokemonRepository>(
      () => PokemonRepositoryImpl(
        pokemonRemoteDataSource: Get.find(),
        pokemonLocalDataSource: Get.find(),
        pokemonMapper: Get.find(),
      ),
      fenix: true,
    );
  }

  void _useCases() {
    Get
      ..lazyPut<GetPokemonsUseCase>(
        () => GetPokemonsUseCase(
          Get.find<PokemonRepository>(),
        ),
        fenix: true,
      )
      ..lazyPut<GetPokemonDetailUseCase>(
        () => GetPokemonDetailUseCase(
          Get.find<PokemonRepository>(),
        ),
        fenix: true,
      );
  }
}
