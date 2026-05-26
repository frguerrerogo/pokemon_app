import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/domain/entities/user_entity.dart';
import 'package:pokemon_app/features/auth/domain/repositories/auth_repository.dart';

class GetSessionUseCase {
  GetSessionUseCase({required AuthRepository authRepository}) : _authRepository = authRepository;

  final AuthRepository _authRepository;

  UserEntity? call(NoParams params) => _authRepository.getSessionFromLocal();
}
