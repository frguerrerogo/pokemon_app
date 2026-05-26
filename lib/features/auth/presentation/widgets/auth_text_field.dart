import 'package:flutter/material.dart';
import 'package:pokemon_app/core/theme/theme.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData prefixIcon;
  final String? Function(String?)? validator;

  final ValueChanged<String>? onChanged;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = !widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: context.typography.labelLarge?.copyWith(
            color: context.colors.error,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword && !_isPasswordVisible,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: context.colors.error,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: context.colors.error,
              size: AppSpacing.iconMd,
            ),
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    child: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: context.colors.error,
                      size: AppSpacing.iconMd,
                    ),
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: AppBorderRadius.input,
              borderSide: BorderSide(
                color: context.colors.error,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.input,
              borderSide: BorderSide(
                color: context.colors.error,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.input,
              borderSide: BorderSide(
                color: context.colors.error,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: AppBorderRadius.input,
              borderSide: BorderSide(
                color: context.colors.error,
              ),
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
            fillColor: context.colors.error,
            errorStyle: context.typography.bodyMedium?.copyWith(
              color: context.colors.error,
            ),
          ),
          style: context.typography.bodyMedium?.copyWith(
            color: context.colors.error,
          ),
        ),
      ],
    );
  }
}
