import 'package:get/get.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart'
    show AuthRepository, ForgotPasswordUseCase;
import 'package:pokemon_app/features/auth/presentation/presentation.dart'
    show PasswordRecoveryController;

class PasswordRecoveryBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => ForgotPasswordUseCase(Get.find<AuthRepository>()))
      ..lazyPut(
        () => PasswordRecoveryController(
          forgotPasswordUseCase: Get.find(),
        ),
      );
  }
}
