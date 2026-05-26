import 'package:pokemon_app/features/auth/data/data.dart'
    show AuthLocalDatasource, AuthRemoteDatasource, UserHiveMapper, UserMapper;
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, UserEntity;

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required AuthRemoteDatasource authRemoteDataSource,
    required AuthLocalDatasource authLocalDatasource,
    required UserMapper userMapper,
    required UserHiveMapper userHiveMapper,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDatasource = authLocalDatasource,
        _userMapper = userMapper,
        _userHiveMapper = userHiveMapper;

  final AuthRemoteDatasource _authRemoteDataSource;
  final AuthLocalDatasource _authLocalDatasource;
  final UserMapper _userMapper;
  final UserHiveMapper _userHiveMapper;

  @override
  Future<UserEntity> login({required String email, required String password}) async {
    final userModel = await _authRemoteDataSource.login(email: email, password: password);
    final entity = _userMapper.modelToEntity(userModel);
    await _authLocalDatasource.saveSession(_userHiveMapper.entityToModel(entity));
    return _userMapper.modelToEntity(userModel);
  }

  @override
  Future<void> logout() async {
    await _authRemoteDataSource.logout();
    await _authLocalDatasource.clearSession();
  }

  @override
  Future<UserEntity> register({required String email, required String password}) async {
    final userModel = await _authRemoteDataSource.register(
      email: email,
      password: password,
    );
    final entity = _userMapper.modelToEntity(userModel);
    await _authLocalDatasource.saveSession(_userHiveMapper.entityToModel(entity));
    return entity;
  }

  @override
  UserEntity? getSessionFromLocal() {
    final model = _authLocalDatasource.getSession();
    return model != null ? _userHiveMapper.modelToEntity(model) : null;
  }
}
