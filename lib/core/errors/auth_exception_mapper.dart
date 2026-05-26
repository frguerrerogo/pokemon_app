import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/core.dart' show AuthFailure;

class AuthExceptionMapper {
  AuthExceptionMapper._();

  static AuthFailure map(FirebaseAuthException e) {
    final message = switch (e.code) {
      'user-not-found' => 'No existe una cuenta con este correo.',
      'wrong-password' => 'Contraseña incorrecta.',
      'email-already-in-use' => 'Este correo ya está registrado.',
      'invalid-email' => 'El formato del correo no es válido.',
      'weak-password' => 'La contraseña debe tener mínimo 6 caracteres.',
      'too-many-requests' => 'Demasiados intentos. Intenta más tarde.',
      'user-disabled' => 'Este usuario ha sido deshabilitado.',
      'operation-not-allowed' => 'Operación no permitida.',
      'network-request-failed' => 'Error de red. Revisa tu conexión.',
      _ => e.message ?? 'Error de autenticación.',
    };
    return AuthFailure(message);
  }
}
