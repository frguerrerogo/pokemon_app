import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';

@immutable
class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
  });

  factory UserModel.fromFirebase(firebase_auth.User user) {
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoURL: user.photoURL,
    );
  }

  final String id;
  final String email;
  final String? displayName;
  final String? photoURL;
}
