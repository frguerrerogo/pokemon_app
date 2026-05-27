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
    this.offset = 0,
    this.limit = 20,
    this.isLoadingMore = false,
  });

  final HomeStatus status;
  final List<PokemonEntity> pokemons;
  final String errorMessage;
  final bool isOffline;
  final int offset;
  final int limit;
  final bool isLoadingMore;

  HomeState copyWith({
    HomeStatus? status,
    List<PokemonEntity>? pokemons,
    String? errorMessage,
    bool? isOffline,
    int? offset,
    int? limit,
    bool? isLoadingMore,
  }) {
    return HomeState(
      status: status ?? this.status,
      pokemons: pokemons ?? this.pokemons,
      errorMessage: errorMessage ?? this.errorMessage,
      isOffline: isOffline ?? this.isOffline,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  bool get isLoading => status == HomeStatus.loading;
  bool get hasError => status == HomeStatus.error;
  bool get hasData => pokemons.isNotEmpty;
}
