import 'package:pokemon_app/features/auth/domain/domain.dart';

class AppState {
  const AppState({
    this.currentUser,
    this.isCheckingSession = false,
  });
  final UserEntity? currentUser;
  final bool isCheckingSession;

  AppState copyWith({
    UserEntity? currentUser,
    bool? isCheckingSession,
  }) {
    return AppState(
      currentUser: currentUser ?? this.currentUser,
      isCheckingSession: isCheckingSession ?? this.isCheckingSession,
    );
  }
}
