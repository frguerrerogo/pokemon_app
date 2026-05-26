import 'package:equatable/equatable.dart';

class PokemonEntity extends Equatable {
  const PokemonEntity({
    required this.id,
    required this.name,
    required this.height,
    required this.weight,
    required this.imageUrl,
    required this.genderRate,
    required this.hp,
    required this.attack,
    required this.defense,
    required this.specialAttack,
    required this.specialDefense,
    required this.speed,
  });
  final int id;
  final String name;
  final double height;
  final double weight;
  final String imageUrl;
  final double genderRate;
  final int hp;
  final int attack;
  final int defense;
  final int specialAttack;
  final int specialDefense;
  final int speed;

  @override
  List<Object?> get props => [
        id,
        name,
        height,
        weight,
        imageUrl,
        genderRate,
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed,
      ];
}
