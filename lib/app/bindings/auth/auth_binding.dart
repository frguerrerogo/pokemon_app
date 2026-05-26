import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
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

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut<AuthRemoteDatasource>(
        () => AuthRemoteDatasourceImpl(
          firebaseAuth: FirebaseAuth.instance,
        ),
      )
      ..lazyPut<AuthLocalDatasource>(
        AuthLocalDatasourceImpl.new,
      )
      ..lazyPut(UserMapper.new)
      ..lazyPut(UserHiveMapper.new)
      ..lazyPut<AuthRepository>(
        () => AuthRepositoryImpl(
          authRemoteDataSource: Get.find(),
          authLocalDatasource: Get.find(),
          userMapper: Get.find(),
          userHiveMapper: Get.find(),
        ),
      );
  }
}
