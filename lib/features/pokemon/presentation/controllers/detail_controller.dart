import 'package:get/get.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonDetailUseCase, PokemonEntity;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart'
    show DetailState, DetailStatus;

class DetailController extends GetxController {
  DetailController({
    required this.getPokemonDetailUseCase,
  });

  final GetPokemonDetailUseCase getPokemonDetailUseCase;

  late PokemonEntity initialPokemon;
  final Rx<DetailState> state = const DetailState().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initialPokemon = Get.arguments as PokemonEntity;
    state.value = state.value.copyWith(pokemon: initialPokemon);
    await loadPokemonDetail();
  }

  Future<void> loadPokemonDetail() async {
    state.value = state.value.copyWith(
      status: DetailStatus.loading,
      errorMessage: '',
    );

    try {
      final result = await getPokemonDetailUseCase(initialPokemon.id);

      state.value = state.value.copyWith(
        status: DetailStatus.success,
        pokemon: result,
      );
    } on Exception catch (e) {
      state.value = state.value.copyWith(
        status: DetailStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
