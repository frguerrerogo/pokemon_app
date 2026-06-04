// features/auth/domain/usecases/forgot_password_usecase.dart
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/domain/repositories/auth_repository.dart';

class ForgotPasswordParams {
  ForgotPasswordParams({required this.email});
  final String email;
}

class ForgotPasswordUseCase implements UseCase<void, ForgotPasswordParams> {
  ForgotPasswordUseCase(this.repository);
  final AuthRepository repository;

  @override
  Future<void> call(ForgotPasswordParams params) async {}
  // Future<void> call(ForgotPasswordParams params) {
  //   return repository.sendPasswordReset(email: params.email);
  // }
}
