import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show DetailController;

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailController>(
      () => DetailController(
        getPokemonDetailUseCase: Get.find(),
      ),
    );
  }
}
