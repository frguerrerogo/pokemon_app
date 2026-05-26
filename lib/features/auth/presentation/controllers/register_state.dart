class RegisterState {
  const RegisterState({
    this.isLoading = false,
    this.errorMessage = '',
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
  });
  final bool isLoading;
  final String errorMessage;
  final bool obscurePassword;
  final bool obscureConfirmPassword;

  RegisterState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
    );
  }
}
