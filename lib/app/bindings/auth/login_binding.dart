import 'package:get/get.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart' show AuthRepository, LoginUseCase;
import 'package:pokemon_app/features/auth/presentation/presentation.dart' show LoginController;

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => LoginUseCase(authRepository: Get.find<AuthRepository>()))
      ..lazyPut(
        () => LoginController(
          loginUseCase: Get.find(),
        ),
      );
  }
}
