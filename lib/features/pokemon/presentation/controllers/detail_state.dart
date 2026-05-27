import 'package:pokemon_app/features/pokemon/domain/domain.dart';

enum DetailStatus {
  initial,
  loading,
  success,
  error,
}

class DetailState {
  const DetailState({
    this.status = DetailStatus.initial,
    this.pokemon,
    this.errorMessage = '',
  });

  final DetailStatus status;
  final PokemonEntity? pokemon;
  final String errorMessage;

  DetailState copyWith({
    DetailStatus? status,
    PokemonEntity? pokemon,
    String? errorMessage,
  }) {
    return DetailState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get isLoading => status == DetailStatus.loading;
  bool get hasError => status == DetailStatus.error;
  bool get hasData => pokemon != null;
}
