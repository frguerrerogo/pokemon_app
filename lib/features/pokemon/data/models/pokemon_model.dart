class PokemonModel {
  PokemonModel({
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

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final stats = json['stats'] as List<dynamic>;

    int getStat(String name) {
      return stats.firstWhere(
        (e) => e['stat']['name'] == name,
      )['base_stat'] as int;
    }

    return PokemonModel(
      id: json['id'] as int,
      name: json['name'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      genderRate: (json['gender_rate'] as num).toDouble(),
      hp: getStat('hp'),
      attack: getStat('attack'),
      defense: getStat('defense'),
      specialAttack: getStat('special-attack'),
      specialDefense: getStat('special-defense'),
      speed: getStat('speed'),
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'height': height,
      'weight': weight,
      'imageUrl': imageUrl,
      'gender_rate': genderRate,
      'hp': hp,
      'attack': attack,
      'defense': defense,
      'specialAttack': specialAttack,
      'specialDefense': specialDefense,
      'speed': speed,
    };
  }
}
