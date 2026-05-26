import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.photoURL,
  });

  final String id;
  final String email;
  final String? name;
  final String? photoURL;

  @override
  List<Object?> get props => [id, email, name, photoURL];
}
