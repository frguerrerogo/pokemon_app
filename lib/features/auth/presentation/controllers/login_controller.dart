import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController, AppRoutes;
import 'package:pokemon_app/features/auth/domain/domain.dart' show LoginUseCase, LoginUseCaseParams;
import 'package:pokemon_app/features/auth/presentation/presentation.dart' show LoginState;

class LoginController extends GetxController {
  LoginController({required this.loginUseCase});

  final LoginUseCase loginUseCase;

  // ── STATE ─────────────────────────────────────────────
  final Rx<LoginState> state = const LoginState().obs;

  // ── FORM ──────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void toggleObscurePassword() {
    state.value = state.value.copyWith(
      obscurePassword: !state.value.obscurePassword,
    );
  }

  // ── LIFECYCLE ─────────────────────────────────────────
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // ── ACTIONS ───────────────────────────────────────────

  Future<void> login() async {
    if (!_validateForm()) return;

    _setLoading(true);
    _clearError();

    try {
      final user = await loginUseCase(
        LoginUseCaseParams(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
      );

      Get.find<AppController>().setUser(user);
      await Get.offAllNamed<void>(AppRoutes.home);
    } on Exception catch (e) {
      _setError(e.toString().replaceFirst('Exception: ', ''));
    } finally {
      _setLoading(false);
    }
  }

  Future<void> goToRegister() async {
    _clearError();
    await Get.toNamed<void>(AppRoutes.register);
  }

  void togglePasswordVisibility() {
    state.update((val) {
      state.value = state.value.copyWith(
        obscurePassword: !state.value.obscurePassword,
      );
    });
  }

  // ── VALIDATION ────────────────────────────────────────

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'El correo es requerido.';
    }
    if (!GetUtils.isEmail(value.trim())) {
      return 'Ingresa un correo válido.';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es requerida.';
    }
    if (value.length < 6) {
      return 'Mínimo 6 caracteres.';
    }
    return null;
  }

  // ── PRIVATE HELPERS ───────────────────────────────────

  bool _validateForm() {
    _clearError();
    return formKey.currentState?.validate() ?? false;
  }

  void _setLoading(bool value) {
    state.update((val) {
      state.value = state.value.copyWith(isLoading: value);
    });
  }

  void _setError(String message) {
    state.update((val) {
      state.value = state.value.copyWith(errorMessage: message);
    });
  }

  void _clearError() {
    state.update((val) {
      state.value = state.value.copyWith(errorMessage: '');
    });
  }
}
