import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/presentation/presentation.dart'
    show EmailFieldWidget, LoginController, PasswordFieldWidget;

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.screenVertical,
          ),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl3),

                //* ─── Header ───
                Text(
                  context.l10n.loginWelcome,
                  style: context.typography.displayMedium?.copyWith(
                    color: context.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  context.l10n.loginSubtitle,
                  style: context.typography.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl3),

                //* ─── Email ───
                EmailFieldWidget(
                  controller: controller.emailController,
                  validator: controller.validateEmail,
                  label: context.l10n.loginEmail,
                  hint: context.l10n.loginEmailHint,
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                //* ─── Password ───
                Obx(
                  () => PasswordFieldWidget(
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                    obscureText: controller.state.value.obscurePassword,
                    onToggleObscure: controller.toggleObscurePassword,
                    label: context.l10n.loginPassword,
                    hint: context.l10n.loginPasswordHint,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: controller.login,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),

                //* ─── Forgot password ───
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Forgot password — pendiente
                    },
                    child: Text(
                      context.l10n.loginForgotPassword,
                      style: context.typography.bodySmall?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.xl2),

                //* ─── Error global ───
                Obx(
                  () => controller.state.value.errorMessage.isNotEmpty
                      ? Container(
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: AppSpacing.md),
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: context.colors.error.withAlpha(25),
                            borderRadius: AppBorderRadius.input,
                            border: Border.all(color: context.colors.error),
                          ),
                          child: Text(
                            controller.state.value.errorMessage,
                            style: context.typography.bodySmall?.copyWith(
                              color: context.colors.error,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                //* ─── Botón login ───
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: AppSpacing.buttonHeightMd,
                    child: ElevatedButton(
                      onPressed: controller.state.value.isLoading ? null : controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        disabledBackgroundColor: context.colorScheme.outline,
                        shape: const RoundedRectangleBorder(
                          borderRadius: AppBorderRadius.button,
                        ),
                        elevation: 0,
                      ),
                      child: controller.state.value.isLoading
                          ? SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  context.colorScheme.onPrimary,
                                ),
                              ),
                            )
                          : Text(
                              context.l10n.loginButton,
                              style: context.typography.labelLarge?.copyWith(
                                color: context.colorScheme.onPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.sectionGap),

                //* ─── Ir a registro ───
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${context.l10n.loginNoAccount} ',
                        style: context.typography.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      InkWell(
                        onTap: controller.goToRegister,
                        borderRadius: AppBorderRadius.brSm,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.xs,
                            vertical: AppSpacing.xs2,
                          ),
                          child: Text(
                            context.l10n.loginSignUp,
                            style: context.typography.bodySmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.screenVertical),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
