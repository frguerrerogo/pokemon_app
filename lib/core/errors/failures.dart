class AuthFailure implements Exception {
  AuthFailure(this.message);
  final String message;
}
