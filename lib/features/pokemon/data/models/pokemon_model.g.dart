// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      abilities: (json['abilities'] as List<dynamic>)
          .map((e) => PokemonAbilityModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      types: (json['types'] as List<dynamic>)
          .map((e) => TypeSlotModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      genderRate: (json['gender_rate'] as num?)?.toInt(),
      hp: (json['hp'] as num).toInt(),
      attack: (json['attack'] as num).toInt(),
      defense: (json['defense'] as num).toInt(),
      specialAttack: (json['specialAttack'] as num).toInt(),
      specialDefense: (json['specialDefense'] as num).toInt(),
      speed: (json['speed'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonModelToJson(PokemonModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'abilities': instance.abilities,
      'height': instance.height,
      'weight': instance.weight,
      'imageUrl': instance.imageUrl,
      'types': instance.types,
      'gender_rate': instance.genderRate,
      'hp': instance.hp,
      'attack': instance.attack,
      'defense': instance.defense,
      'specialAttack': instance.specialAttack,
      'specialDefense': instance.specialDefense,
      'speed': instance.speed,
    };

PokemonAbilityModel _$PokemonAbilityModelFromJson(Map<String, dynamic> json) =>
    PokemonAbilityModel(
      ability: json['ability'] as String,
      isHidden: json['is_hidden'] as bool,
      slot: (json['slot'] as num).toInt(),
    );

Map<String, dynamic> _$PokemonAbilityModelToJson(
        PokemonAbilityModel instance) =>
    <String, dynamic>{
      'ability': instance.ability,
      'is_hidden': instance.isHidden,
      'slot': instance.slot,
    };

TypeSlotModel _$TypeSlotModelFromJson(Map<String, dynamic> json) =>
    TypeSlotModel(
      name: json['name'] as String,
    );

Map<String, dynamic> _$TypeSlotModelToJson(TypeSlotModel instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
