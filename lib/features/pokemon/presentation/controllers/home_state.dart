import 'package:pokemon_app/features/pokemon/domain/domain.dart';

enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

class HomeState {
  const HomeState({
    this.status = HomeStatus.initial,
    this.pokemons = const [],
    this.errorMessage = '',
    this.isOffline = false,
  });

  final HomeStatus status;
  final List<PokemonEntity> pokemons;
  final String errorMessage;
  final bool isOffline;

  HomeState copyWith({
    HomeStatus? status,
    List<PokemonEntity>? pokemons,
    String? errorMessage,
    bool? isOffline,
  }) {
    return HomeState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      errorMessage: errorMessage ?? this.errorMessage,
      isOffline: isOffline ?? this.isOffline,
    );
  }

  bool get isLoading => status == HomeStatus.loading;
  bool get hasError => status == HomeStatus.error;
  bool get hasData => pokemons.isNotEmpty;
}
