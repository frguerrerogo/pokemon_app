import 'package:pokemon_app/core/core.dart' show UseCase;
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, UserEntity;

class RegisterUseCaseParams {
  const RegisterUseCaseParams({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

class RegisterUseCase implements UseCase<UserEntity, RegisterUseCaseParams> {
  const RegisterUseCase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<UserEntity> call(RegisterUseCaseParams params) {
    return _authRepository.register(params.email, params.password);
  }
}
