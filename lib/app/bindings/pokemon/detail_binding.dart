import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonDetailUseCase, PokemonRepository;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show DetailController;

class DetailBinding extends Bindings {
  @override
  void dependencies() {
    Get
      ..lazyPut(() => GetPokemonDetailUseCase(Get.find<PokemonRepository>()))
      ..lazyPut(
        () => DetailController(
          getPokemonDetailUseCase: Get.find<GetPokemonDetailUseCase>(),
        ),
      );
  }
}
