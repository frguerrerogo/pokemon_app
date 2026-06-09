import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AppController>(
      AppController(
        getSessionUseCase: Get.find(),
      ),
      permanent: true,
    );
  }
}
