import 'package:hive_ce/hive.dart';
import 'package:pokemon_app/features/auth/domain/domain.dart' show UserEntity;

part 'user_hive_model.g.dart';

@HiveType(typeId: 0)
class UserHiveModel extends HiveObject {
  UserHiveModel({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
  });

  factory UserHiveModel.fromEntity(UserEntity entity) {
    return UserHiveModel(
      id: entity.id,
      email: entity.email,
      displayName: entity.name,
      photoURL: entity.photoURL,
    );
  }
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String? displayName;

  @HiveField(3)
  final String? photoURL;

  UserEntity toEntity() => UserEntity(
        id: id,
        email: email,
        name: displayName,
        photoURL: photoURL,
      );
}
