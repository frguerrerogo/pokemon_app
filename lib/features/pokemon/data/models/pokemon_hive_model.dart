import 'package:hive_flutter/hive_flutter.dart';

part 'pokemon_hive_model.g.dart';

@HiveType(typeId: 1)
class PokemonHiveModel {
  PokemonHiveModel({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });

  factory PokemonHiveModel.fromPokemonModel(Map<String, dynamic> pokemonData) {
    return PokemonHiveModel(
      id: pokemonData['id'] as int,
      name: pokemonData['name'] as String,
      height: pokemonData['height'] as double,
      weight: pokemonData['weight'] as double,
      imageUrl: pokemonData['imageUrl'] as String,
      hp: pokemonData['hp'] as int,
      attack: pokemonData['attack'] as int,
      defense: pokemonData['defense'] as int,
      specialAttack: pokemonData['specialAttack'] as int,
      specialDefense: pokemonData['specialDefense'] as int,
      speed: pokemonData['speed'] as int,
    );
  }

  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final double height;

  @HiveField(3)
  final double weight;

  @HiveField(4)
  final String imageUrl;

  @HiveField(5)
  final int hp;

  @HiveField(6)
  final int attack;

  @HiveField(7)
  final int defense;

  @HiveField(8)
  final int specialAttack;

  @HiveField(9)
  final int specialDefense;

  @HiveField(10)
  final int speed;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
    };
  }
}
