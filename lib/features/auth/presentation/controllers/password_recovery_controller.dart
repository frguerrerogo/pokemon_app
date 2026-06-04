import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart';

enum PasswordRecoveryStatus { initial, loading, success, error }

class PasswordRecoveryController extends GetxController {
  PasswordRecoveryController({required this.forgotPasswordUseCase});
  final ForgotPasswordUseCase forgotPasswordUseCase;

  final Rx<PasswordRecoveryStatus> status = PasswordRecoveryStatus.initial.obs;
  final RxString errorMessage = ''.obs;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetEmail() async {
    if (!_validateForm()) return;

    status.value = PasswordRecoveryStatus.loading;
    errorMessage.value = '';

    try {
      await forgotPasswordUseCase(
        ForgotPasswordParams(email: emailController.text.trim()),
      );
      status.value = PasswordRecoveryStatus.success;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst('Exception: ', '');
      status.value = PasswordRecoveryStatus.error;
    }
  }

  void goBack() => Get.back<void>();

  void tryAgain() {
    emailController.clear();
    errorMessage.value = '';
    status.value = PasswordRecoveryStatus.initial;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'El correo es requerido.';
    if (!GetUtils.isEmail(value.trim())) return 'Ingresa un correo válido.';
    return null;
  }

  bool get isLoading => status.value == PasswordRecoveryStatus.loading;
  bool get isSuccess => status.value == PasswordRecoveryStatus.success;

  bool _validateForm() {
    errorMessage.value = '';
    return formKey.currentState?.validate() ?? false;
  }
}
