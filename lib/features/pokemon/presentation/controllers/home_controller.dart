import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController;
import 'package:pokemon_app/app/routes/app_routes.dart';
import 'package:pokemon_app/core/core.dart' show ConnectivityService;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonsUseCase, GetPokemonsUseCaseParams, PokemonEntity;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart'
    show HomeState, HomeStatus;

class HomeController extends GetxController {
  HomeController({
    required this.getPokemonsUseCase,
    required this.connectivityService,
  });

  final GetPokemonsUseCase getPokemonsUseCase;
  final ConnectivityService connectivityService;

  final Rx<HomeState> state = const HomeState().obs;

  @override
  void onInit() {
    super.onInit();
    loadPokemons();
    _listenConnectivity();
  }

  Future<void> loadPokemons() async {
    state.value = state.value.copyWith(
      status: HomeStatus.loading,
      errorMessage: '',
    );

    final online = await connectivityService.hasConnection;

    try {
      final result = await getPokemonsUseCase(
        const GetPokemonsUseCaseParams(),
      );

      state.value = state.value.copyWith(
        status: HomeStatus.success,
        pokemons: result,
        isOffline: !online,
      );
    } catch (e) {
      state.value = state.value.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
        isOffline: !online,
      );
    }
  }

  @override
  Future<void> refresh() async {
    await loadPokemons();
  }

  void goToDetail(PokemonEntity pokemon) {
    Get.toNamed<void>(AppRoutes.detail, arguments: pokemon);
  }

  void logout() {
    Get.find<AppController>().clearUser();
  }

  void _listenConnectivity() {
    connectivityService.onConnectivityChanged.listen((online) {
      state.value = state.value.copyWith(
        isOffline: !online,
      );

      if (online && state.value.hasData) {
        loadPokemons();
      }
    });
  }
}
