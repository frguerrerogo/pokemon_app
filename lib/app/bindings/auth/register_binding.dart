import 'package:get/get.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, RegisterUseCase;
import 'package:pokemon_app/features/auth/presentation/presentation.dart' show RegisterController;

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(
        () => RegisterUseCase(authRepository: Get.find<AuthRepository>()),
      )
      ..lazyPut(
        () => RegisterController(
          registerUseCase: Get.find(),
        ),
      );
  }
}
