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
      ..put<AuthRemoteDatasource>(
        AuthRemoteDatasourceImpl(
          firebaseAuth: Get.find<FirebaseService>().auth,
        ),
        permanent: true,
      )
      ..put<AuthLocalDatasource>(
        AuthLocalDatasourceImpl(),
        permanent: true,
      );
  }

  void _mappers() {
    Get
      ..put<UserMapper>(
        UserMapper(),
        permanent: true,
      )
      ..put<UserHiveMapper>(
        UserHiveMapper(),
        permanent: true,
      );
  }

  void _repositories() {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        authRemoteDataSource: Get.find(),
        authLocalDatasource: Get.find(),
        userMapper: Get.find(),
        userHiveMapper: Get.find(),
      ),
      permanent: true,
    );
  }

  void _useCases() {
    Get.put<GetSessionUseCase>(
      GetSessionUseCase(
        authRepository: Get.find(),
      ),
      permanent: true,
    );
  }
}
