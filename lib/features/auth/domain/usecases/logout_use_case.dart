import 'package:pokemon_app/core/core.dart' show NoParams, UseCase;
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository;

class LogoutUseCase implements UseCase<void, NoParams> {
  const LogoutUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  @override
  Future<void> call([void params]) {
    return _authRepository.logout();
  }
}
