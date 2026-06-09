import 'package:get/get.dart';
import 'package:pokemon_app/app/bindings/binding.dart'
    show AppBinding, AuthBinding, CoreBinding, PokemonBinding;

class InitializeBinding extends Bindings {
  @override
  void dependencies() {
    CoreBinding().dependencies();
    AuthBinding().dependencies();
    AppBinding().dependencies();
    PokemonBinding().dependencies();
  }
}
