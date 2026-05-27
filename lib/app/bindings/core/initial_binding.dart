import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController, FirebaseConfig;
import 'package:pokemon_app/core/core.dart' show ConnectivityService, DioClient;
import 'package:pokemon_app/features/auth/data/data.dart'
    show
        AuthLocalDatasource,
        AuthLocalDatasourceImpl,
        AuthRemoteDatasource,
        AuthRemoteDatasourceImpl,
        AuthRepositoryImpl,
        UserHiveMapper,
        UserMapper;
import 'package:pokemon_app/features/auth/domain/domain.dart'
    show AuthRepository, GetSessionUseCase;
import 'package:pokemon_app/features/pokemon/data/data.dart'
    show PokemonMapper, PokemonRemoteDatasource, PokemonRemoteDatasourceImpl, PokemonRepositoryImpl;
import 'package:pokemon_app/features/pokemon/domain/repositories/pokemon_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // CORE SERVICES
    Get
      ..lazyPut<DioClient>(DioClient.new, fenix: true)
      ..lazyPut<ConnectivityService>(ConnectivityService.new, fenix: true)

      // AUTH DATA SOURCES
      ..lazyPut<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(
          firebaseAuth: FirebaseConfig.auth,
        ),
        fenix: true,
      )
      ..lazyPut<AuthLocalDatasource>(
        AuthLocalDatasourceImpl.new,
        fenix: true,
      )

      // MAPPERS
      ..lazyPut<UserMapper>(UserMapper.new, fenix: true)
      ..lazyPut<UserHiveMapper>(UserHiveMapper.new, fenix: true)

      // REPOSITORY
      ..lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(
          authRemoteDataSource: Get.find(),
          authLocalDatasource: Get.find(),
          userMapper: Get.find(),
          userHiveMapper: Get.find(),
        ),
        fenix: true,
      )

      // USE CASES GLOBALES
      ..lazyPut(
        () => GetSessionUseCase(authRepository: Get.find()),
        fenix: true,
      )

      // APP CONTROLLER GLOBAL
      ..put(
        AppController(getSessionUseCase: Get.find()),
        permanent: true,
      )

      // POKEMON CORE
      ..lazyPut<PokemonMapper>(PokemonMapper.new, fenix: true)
      ..lazyPut<PokemonRemoteDatasource>(
        () => PokemonRemoteDatasourceImpl(Get.find()),
        fenix: true,
      )
      ..lazyPut<PokemonRepository>(
        () => PokemonRepositoryImpl(
          pokemonRemoteDataSource: Get.find(),
          pokemonMapper: Get.find(),
        ),
        fenix: true,
      );
  }
}
