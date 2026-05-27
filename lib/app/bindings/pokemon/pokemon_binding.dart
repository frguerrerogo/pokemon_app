import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart' show ConnectivityService, DioClient;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonMapper, PokemonRemoteDatasource, PokemonRemoteDatasourceImpl, PokemonRepositoryImpl;
import 'package:pokemon_app/features/pokemon/domain/domain.dart' show PokemonRepository;

class PokemonBinding extends Bindings {
  @override
  void dependencies() {
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
      );
  }
}
