import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/auth/data/data.dart' show UserHiveModel;
import 'package:pokemon_app/features/auth/domain/domain.dart' show UserEntity;

class UserHiveMapper extends Mapper<UserEntity, UserHiveModel> {
  @override
  UserHiveModel entityToModel(UserEntity entity) => UserHiveModel(
        id: entity.id,
        email: entity.email,
        displayName: entity.name,
        photoURL: entity.photoURL,
      );

  @override
  UserEntity modelToEntity(UserHiveModel model) => UserEntity(
        id: model.id,
        email: model.email,
        name: model.displayName,
        photoURL: model.photoURL,
      );
}
