// data/models/pokemon_model.dart
import 'package:hive_ce/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class PokemonModel {
  PokemonModel({
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

  factory PokemonModel.fromApi(Map<String, dynamic> json) {
    final stats = json['stats'] as List<dynamic>;

    int getStat(String name) =>
        stats.firstWhere((e) => e['stat']['name'] == name)['base_stat'] as int;

    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['sprites']['front_default'] as String,
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
      specialAttack: getStat('special-attack'),
      specialDefense: getStat('special-defense'),
      speed: getStat('speed'),
    );
  }

  // Factory para el listado — solo id, name, imageUrl
  factory PokemonModel.fromListResult(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return PokemonModel(
      id: id,
      name: json['name'] as String,
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png',
      height: 0,
      weight: 0,
      hp: 0,
      attack: 0,
      defense: 0,
      specialAttack: 0,
      specialDefense: 0,
      speed: 0,
    );
  }

  factory PokemonModel.fromJson(Map<String, dynamic> json) => _$PokemonModelFromJson(json);

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
  @JsonKey(name: 'specialAttack')
  final int specialAttack;

  @HiveField(9)
  @JsonKey(name: 'specialDefense')
  final int specialDefense;

  @HiveField(10)
  final int speed;

  // ── Generado por JsonSerializable ──
  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}
