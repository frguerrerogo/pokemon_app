import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart' show ConnectivityService, DioClient;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonMapper, PokemonRemoteDatasource, PokemonRemoteDatasourceImpl, PokemonRepositoryImpl;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonsUseCase, PokemonRepository;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show HomeController;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Dio con configuración base
    Get
      ..lazyPut<DioClient>(DioClient.new)
      ..lazyPut(PokemonMapper.new)
      ..lazyPut<ConnectivityService>(ConnectivityService.new)
      ..lazyPut<PokemonRemoteDatasource>(
        () => PokemonRemoteDatasourceImpl(Get.find()),
      )
      // ..lazyPut<PokemonLocalDatasource>(
      //   PokemonLocalDatasourceImpl,
      // )
      ..lazyPut<PokemonRepository>(
        () => PokemonRepositoryImpl(
          pokemonRemoteDataSource: Get.find(),
          pokemonMapper: Get.find(),
        ),
      )
      ..lazyPut(() => GetPokemonsUseCase(Get.find<PokemonRepository>()))
      ..lazyPut(
        () => HomeController(
          getPokemonsUseCase: Get.find(),
          connectivityService: Get.find(),
        ),
      );
  }
}
