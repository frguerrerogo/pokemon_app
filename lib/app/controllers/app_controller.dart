import 'package:get/get.dart';
import 'package:pokemon_app/app/controllers/app_state.dart';
import 'package:pokemon_app/app/routes/app_routes.dart';
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart';

class AppController extends GetxController {
  AppController({
    required this.getSessionUseCase,
  });

  final GetSessionUseCase getSessionUseCase;

  final Rx<AppState> state = const AppState().obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await _checkSession();
  }

  UserEntity? get currentUser => state.value.currentUser;

  bool get isAuthenticated => currentUser != null;

  void setUser(UserEntity user) {
    state.value = state.value.copyWith(
      currentUser: user,
    );
  }

  void clearUser() {
    state.value = state.value.copyWith();
  }

  Future<void> _checkSession() async {
    _setCheckingSession(true);

    try {
      final session = getSessionUseCase(
        NoParams(),
      );

      if (session != null) {
        setUser(session);

        await Get.offAllNamed<void>(
          AppRoutes.home,
        );
      }
    } on Exception catch (_) {
      clearUser();
    } finally {
      _setCheckingSession(false);
    }
  }

  void _setCheckingSession(bool value) {
    state.value = state.value.copyWith(
      isCheckingSession: value,
    );
  }
}
