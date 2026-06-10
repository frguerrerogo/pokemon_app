import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart' show FirebaseService;
import 'package:pokemon_app/features/auth/data/data.dart'
    show
        AuthLocalDatasource,
        AuthLocalDatasourceImpl,
        AuthRemoteDatasource,
        AuthRemoteDatasourceImpl,
        AuthRepositoryImpl,
        UserHiveMapper,
        UserMapper;
import 'package:pokemon_app/features/auth/domain/domain.dart' show LogoutUseCase;
import 'package:pokemon_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:pokemon_app/features/auth/domain/usecases/get_session_usecase.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    _datasources();
    _mappers();
    _repositories();
    _useCases();
  }

  void _datasources() {
    Get
      ..lazyPut<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(
          firebaseAuth: Get.find<FirebaseService>().auth,
        ),
        fenix: true,
      )
      ..lazyPut<AuthLocalDatasource>(
        AuthLocalDatasourceImpl.new,
        fenix: true,
      );
  }

  void _mappers() {
    Get
      ..lazyPut<UserMapper>(
        UserMapper.new,
        fenix: true,
      )
      ..lazyPut<UserHiveMapper>(
        UserHiveMapper.new,
        fenix: true,
      );
  }

  void _repositories() {
    Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: Get.find(),
        authLocalDatasource: Get.find(),
        userMapper: Get.find(),
        userHiveMapper: Get.find(),
      ),
      fenix: true,
    );
  }

  void _useCases() {
    Get
      ..lazyPut<GetSessionUseCase>(
        () => GetSessionUseCase(
          authRepository: Get.find(),
        ),
        fenix: true,
      )
      ..lazyPut<LogoutUseCase>(
        () => LogoutUseCase(
          authRepository: Get.find(),
        ),
        fenix: true,
      );
  }
}
