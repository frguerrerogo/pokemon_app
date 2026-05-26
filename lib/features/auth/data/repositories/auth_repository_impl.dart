import 'package:pokemon_app/features/auth/data/data.dart' show AuthRemoteDataSource, UserMapper;
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, UserEntity;

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required UserMapper userMapper,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _userMapper = userMapper;

  final AuthRemoteDataSource _authRemoteDataSource;

  final UserMapper _userMapper;

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await _authRemoteDataSource.login(email, password);

    return _userMapper.modelToEntity(userModel);
  }

  @override
  Future<void> logout() async {
    await _authRemoteDataSource.logout();
  }

  @override
  Future<UserEntity> register(String email, String password) async {
    final userModel = await _authRemoteDataSource.register(
      email,
      password,
    );

    return _userMapper.modelToEntity(userModel);
  }
}
