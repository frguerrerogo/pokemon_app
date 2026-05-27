import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonsUseCase, PokemonRepository;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show HomeController;

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => GetPokemonsUseCase(Get.find<PokemonRepository>()))
      ..lazyPut(
        () => HomeController(
          getPokemonsUseCase: Get.find(),
          connectivityService: Get.find(),
        ),
      );
  }
}
