import 'package:flutter/material.dart';
import 'package:pokemon_app/core/core.dart';

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget({
    required this.controller,
    required this.label,
    required this.hint,
    super.key,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
  });
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String label;
  final String hint;
  final TextInputAction textInputAction;
  final VoidCallback? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.typography.labelLarge?.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.emailAddress,
          textInputAction: textInputAction,
          onFieldSubmitted: (_) => onFieldSubmitted?.call(),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: context.colorScheme.onSurfaceVariant,
            ),
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
            errorStyle: context.typography.bodyMedium?.copyWith(
              color: context.colors.error,
            ),
          ),
          style: context.typography.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
