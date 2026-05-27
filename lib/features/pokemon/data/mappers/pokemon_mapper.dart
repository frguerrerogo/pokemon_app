import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/data/data.dart' show PokemonModel;
import 'package:pokemon_app/features/pokemon/domain/domain.dart' show PokemonEntity;

class PokemonMapper extends Mapper<PokemonEntity, PokemonModel> {
  @override
  PokemonModel entityToModel(PokemonEntity entity) => PokemonModel(
        id: entity.id,
        name: entity.name,
        height: entity.height,
        weight: entity.weight,
        imageUrl: entity.imageUrl,
        hp: entity.hp,
        attack: entity.attack,
        defense: entity.defense,
        specialAttack: entity.specialAttack,
        specialDefense: entity.specialDefense,
        speed: entity.speed,
      );

  @override
  PokemonEntity modelToEntity(PokemonModel model) => PokemonEntity(
        id: model.id,
        name: model.name,
        height: model.height,
        weight: model.weight,
        imageUrl: model.imageUrl,
        hp: model.hp,
        attack: model.attack,
        defense: model.defense,
        specialAttack: model.specialAttack,
        specialDefense: model.specialDefense,
        speed: model.speed,
      );
}
