import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pokemon_app/firebase_options.dart';

//* ─── Firebase Configuration ───

/// Central configuration for Firebase initialization.
class FirebaseConfig {
  /// Initializes Firebase with platform-specific options.
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Firebase Auth instance.
  static FirebaseAuth get auth => FirebaseAuth.instance;
}
