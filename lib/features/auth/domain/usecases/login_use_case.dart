import 'package:pokemon_app/core/core.dart' show UseCase;
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, UserEntity;

class LoginUseCaseParams {
  const LoginUseCaseParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class LoginUseCase implements UseCase<UserEntity, LoginUseCaseParams> {
  const LoginUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<UserEntity> call(LoginUseCaseParams params) {
    return _authRepository.login(params.email, params.password);
  }
}
