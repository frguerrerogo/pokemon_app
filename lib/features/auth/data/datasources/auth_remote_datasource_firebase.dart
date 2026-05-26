import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show UserModel;

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel> register(String email, String password);
  Future<UserModel?> currentUser();
}

class AuthRemoteDataSourceFirebase implements AuthRemoteDataSource {
  const AuthRemoteDataSourceFirebase({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserModel> login(String email, String password) async {
    final credentials = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = credentials.user;
    if (user == null) throw Exception('User is null after authentication');
    return UserModel.fromFirebase(user);
  }

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> register(
    String email,
    String password,
  ) async {
    final credentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credentials.user;
    if (user == null) throw Exception('User is null after authentication');
    return UserModel.fromFirebase(user);
  }

  @override
  Future<UserModel?> currentUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return UserModel.fromFirebase(user);
  }
}
