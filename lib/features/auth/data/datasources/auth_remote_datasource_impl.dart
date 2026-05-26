import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokemon_app/core/core.dart' show AuthExceptionMapper;
import 'package:pokemon_app/features/auth/data/data.dart' show AuthRemoteDatasource, UserModel;

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  AuthRemoteDatasourceImpl({required this.firebaseAuth});
  final FirebaseAuth firebaseAuth;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionMapper.map(e);
    }
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserModel.fromFirebase(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw AuthExceptionMapper.map(e);
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
