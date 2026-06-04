import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/presentation/controllers/password_recovery_controller.dart';

class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PasswordRecoveryController>();

    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenHorizontal,
            vertical: AppSpacing.screenVertical,
          ),
          child: Obx(
            () => controller.isSuccess
                ? _SuccessView(controller: controller)
                : _FormView(controller: controller),
          ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  const _FormView({required this.controller});

  final PasswordRecoveryController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          InkWell(
            onTap: controller.goBack,
            borderRadius: AppBorderRadius.brFull,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                shape: BoxShape.circle,
                border: Border.all(color: context.colorScheme.outline),
              ),
              child: Icon(
                Icons.arrow_back_rounded,
                color: context.colorScheme.onSurface,
                size: AppSpacing.iconMd,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl2),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: context.colorScheme.primary.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.lock_reset_rounded,
              size: AppSpacing.iconXl,
              color: context.colorScheme.primary,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            context.l10n.forgotPasswordTitle,
            style: context.typography.displaySmall?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            context.l10n.forgotPasswordSubtitle,
            style: context.typography.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: AppSpacing.xl3),
          Text(
            context.l10n.loginEmail,
            style: context.typography.labelLarge?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: controller.emailController,
            validator: controller.validateEmail,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => controller.sendResetEmail(),
            decoration: InputDecoration(
              hintText: context.l10n.loginEmailHint,
              hintStyle: TextStyle(color: context.colors.error),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: context.colorScheme.onSurfaceVariant,
                size: AppSpacing.iconMd,
              ),
              border: OutlineInputBorder(
                borderRadius: AppBorderRadius.input,
                borderSide: BorderSide(color: context.colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.input,
                borderSide: BorderSide(color: context.colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.input,
                borderSide: BorderSide(
                  color: context.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.input,
                borderSide: BorderSide(color: context.colors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: AppBorderRadius.input,
                borderSide: BorderSide(
                  color: context.colors.error,
                  width: 2,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              filled: true,
              fillColor: context.colorScheme.surface,
            ),
            style: context.typography.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: AppSpacing.xl2),
          Obx(
            () => controller.errorMessage.value.isNotEmpty
                ? Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: AppSpacing.md),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: context.colors.error.withAlpha(25),
                      borderRadius: AppBorderRadius.input,
                      border: Border.all(color: context.colors.error),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: context.colors.error,
                          size: AppSpacing.iconSm,
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            controller.errorMessage.value,
                            style: context.typography.bodySmall?.copyWith(
                              color: context.colors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),
          Obx(
            () => SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeightMd,
              child: ElevatedButton(
                onPressed: controller.isLoading ? null : controller.sendResetEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  disabledBackgroundColor: context.colors.error,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.button,
                  ),
                  elevation: 0,
                ),
                child: controller.isLoading
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
                        context.l10n.forgotPasswordButton,
                        style: context.typography.labelLarge?.copyWith(
                          color: context.colorScheme.onPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${context.l10n.forgotPasswordRemember} ',
                  style: context.typography.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
                InkWell(
                  onTap: controller.goBack,
                  borderRadius: AppBorderRadius.brSm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xs,
                      vertical: AppSpacing.xs2,
                    ),
                    child: Text(
                      context.l10n.forgotPasswordLogin,
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
    );
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView({required this.controller});

  final PasswordRecoveryController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: AppSpacing.xl3),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          curve: Curves.elasticOut,
          builder: (_, value, child) => Transform.scale(
            scale: value,
            child: child,
          ),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.xl),
            decoration: BoxDecoration(
              color: context.colors.success.withAlpha(20),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_rounded,
              size: 64,
              color: context.colors.success,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl2),
        Text(
          context.l10n.forgotPasswordSuccessTitle,
          style: context.typography.displaySmall?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.md),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: context.typography.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
            children: [
              TextSpan(
                text: '${context.l10n.forgotPasswordSuccessMessage} ',
              ),
              TextSpan(
                text: controller.emailController.text.trim(),
                style: TextStyle(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.l10n.forgotPasswordSuccessHint,
          style: context.typography.bodySmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xl3),
        SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeightMd,
          child: ElevatedButton(
            onPressed: controller.goBack,
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.button,
              ),
              elevation: 0,
            ),
            child: Text(
              context.l10n.forgotPasswordBackToLogin,
              style: context.typography.labelLarge?.copyWith(
                color: context.colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          height: AppSpacing.buttonHeightMd,
          child: OutlinedButton.icon(
            onPressed: controller.tryAgain,
            icon: Icon(
              Icons.refresh_rounded,
              color: context.colorScheme.primary,
              size: AppSpacing.iconSm,
            ),
            label: Text(context.l10n.forgotPasswordResend),
            style: OutlinedButton.styleFrom(
              foregroundColor: context.colorScheme.primary,
              side: BorderSide(color: context.colorScheme.primary),
              shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.button,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.screenVertical),
      ],
    );
  }
}
