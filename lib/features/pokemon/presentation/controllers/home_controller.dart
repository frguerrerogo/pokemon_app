import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController;
import 'package:pokemon_app/app/routes/app_routes.dart';
import 'package:pokemon_app/core/core.dart' show ConnectivityService;
import 'package:pokemon_app/features/auth/domain/domain.dart' show LogoutUseCase;
import 'package:pokemon_app/features/pokemon/domain/domain.dart'
    show GetPokemonsUseCase, GetPokemonsUseCaseParams, PokemonEntity;
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart'
    show HomeState, HomeStatus;

class HomeController extends GetxController {
  HomeController({
    required this.getPokemonsUseCase,
    required this.connectivityService,
    required this.logoutUseCase,
  });

  final GetPokemonsUseCase getPokemonsUseCase;
  final ConnectivityService connectivityService;
  final LogoutUseCase logoutUseCase;

  final Rx<HomeState> state = const HomeState().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadPokemons();
    _listenConnectivity();
  }

  Future<void> loadPokemons() async {
    state.value = state.value.copyWith(
      status: HomeStatus.loading,
      errorMessage: '',
      offset: 0,
      pokemons: const [],
    );

    final online = await connectivityService.hasConnection;

    try {
      final result = await getPokemonsUseCase(
        GetPokemonsUseCaseParams(
          limit: state.value.limit,
          offset: state.value.offset,
        ),
      );

      state.value = state.value.copyWith(
        status: HomeStatus.success,
        pokemons: result,
        isOffline: !online,
        offset: state.value.limit,
      );
    } on Exception catch (e) {
      state.value = state.value.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
        isOffline: !online,
      );
    }
  }

  Future<void> loadMorePokemons() async {
    if (state.value.isLoadingMore || state.value.status != HomeStatus.success) {
      return;
    }

    state.value = state.value.copyWith(isLoadingMore: true);

    try {
      final result = await getPokemonsUseCase(
        GetPokemonsUseCaseParams(
          limit: state.value.limit,
          offset: state.value.offset,
        ),
      );

      if (result.isEmpty) {
        state.value = state.value.copyWith(isLoadingMore: false);
        return;
      }

      final updatedPokemons = [...state.value.pokemons, ...result];
      state.value = state.value.copyWith(
        pokemons: updatedPokemons,
        isLoadingMore: false,
        offset: state.value.offset + state.value.limit,
      );
    } on Exception catch (e) {
      state.value = state.value.copyWith(
        isLoadingMore: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  Future<void> refresh() async {
    await loadPokemons();
  }

  Future<void> goToDetail(PokemonEntity pokemon) async {
    await Get.toNamed<void>(AppRoutes.detail, arguments: pokemon);
  }

  Future<void> logout() async {
    Get.find<AppController>().clearUser();
    await logoutUseCase();
  }

  void _listenConnectivity() {
    connectivityService.onConnectivityChanged.listen((online) async {
      state.value = state.value.copyWith(
        isOffline: !online,
      );

      if (online && state.value.hasData) {
        await loadPokemons();
      }
    });
  }
}
