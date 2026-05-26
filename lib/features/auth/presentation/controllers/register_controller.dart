import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppController, AppRoutes;
import 'package:pokemon_app/features/auth/domain/domain.dart'
    show RegisterUseCase, RegisterUseCaseParams;
import 'package:pokemon_app/features/auth/presentation/presentation.dart' show RegisterState;

class RegisterController extends GetxController {
  RegisterController({required this.registerUseCase});

  final RegisterUseCase registerUseCase;

  // ── STATE ─────────────────────────────────────────────
  final Rx<RegisterState> state = const RegisterState().obs;

  // ── FORM ──────────────────────────────────────────────
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void toggleObscurePassword() {
    state.value = state.value.copyWith(
      obscurePassword: !state.value.obscurePassword,
    );
  }

  void toggleObscureConfirmPassword() {
    state.value = state.value.copyWith(
      obscureConfirmPassword: !state.value.obscureConfirmPassword,
    );
  }

  // ── LIFECYCLE ─────────────────────────────────────────
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // ── ACTIONS ───────────────────────────────────────────

  Future<void> register() async {
    if (!_validateForm()) return;

    _setLoading(true);
    _clearError();

    try {
      final user = await registerUseCase(
        RegisterUseCaseParams(
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

  void goToLogin() {
    _clearError();
    Get.back<void>();
  }

  void togglePasswordVisibility() {
    state.value = state.value.copyWith(
      obscurePassword: !state.value.obscurePassword,
    );
  }

  void toggleConfirmPasswordVisibility() {
    state.value = state.value.copyWith(
      obscureConfirmPassword: !state.value.obscureConfirmPassword,
    );
  }

  // ── VALIDATORS ────────────────────────────────────────

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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirma tu contraseña.';
    }

    if (value != passwordController.text) {
      return 'Las contraseñas no coinciden.';
    }

    return null;
  }

  // ── PRIVATE ───────────────────────────────────────────

  bool _validateForm() {
    _clearError();
    return formKey.currentState?.validate() ?? false;
  }

  void _setLoading(bool value) {
    state.value = state.value.copyWith(
      isLoading: value,
    );
  }

  void _setError(String message) {
    state.value = state.value.copyWith(
      errorMessage: message,
    );
  }

  void _clearError() {
    state.value = state.value.copyWith(
      errorMessage: '',
    );
  }
}
