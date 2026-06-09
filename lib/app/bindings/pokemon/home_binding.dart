import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show HomeController;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        getPokemonsUseCase: Get.find(),
        connectivityService: Get.find(),
      ),
    );
  }
}
