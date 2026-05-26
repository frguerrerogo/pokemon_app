import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show UserModel;
import 'package:pokemon_app/features/auth/domain/domain.dart' show UserEntity;

class UserMapper extends Mapper<UserEntity, UserModel> {
  @override
  UserModel entityToModel(UserEntity entity) => UserModel(
        id: entity.id,
        email: entity.email,
        displayName: entity.name,
        photoURL: entity.photoURL,
      );

  @override
  UserEntity modelToEntity(UserModel model) => UserEntity(
        id: model.id,
        email: model.email,
        name: model.displayName,
        photoURL: model.photoURL,
      );
}
