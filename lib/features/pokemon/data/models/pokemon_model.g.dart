// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonModelAdapter extends TypeAdapter<PokemonModel> {
  @override
  final typeId = 1;

  @override
  PokemonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonModel(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      height: (fields[2] as num).toDouble(),
      weight: (fields[3] as num).toDouble(),
      imageUrl: fields[4] as String,
      hp: (fields[5] as num).toInt(),
      attack: (fields[6] as num).toInt(),
      defense: (fields[7] as num).toInt(),
      specialAttack: (fields[8] as num).toInt(),
      specialDefense: (fields[9] as num).toInt(),
      speed: (fields[10] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, PokemonModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.height)
      ..writeByte(3)
      ..write(obj.weight)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.hp)
      ..writeByte(6)
      ..write(obj.attack)
      ..writeByte(7)
      ..write(obj.defense)
      ..writeByte(8)
      ..write(obj.specialAttack)
      ..writeByte(9)
      ..write(obj.specialDefense)
      ..writeByte(10)
      ..write(obj.speed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PokemonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonModel _$PokemonModelFromJson(Map<String, dynamic> json) => PokemonModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      height: (json['height'] as num).toDouble(),
      weight: (json['weight'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
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
      'height': instance.height,
      'weight': instance.weight,
      'imageUrl': instance.imageUrl,
      'hp': instance.hp,
      'attack': instance.attack,
      'defense': instance.defense,
      'specialAttack': instance.specialAttack,
      'specialDefense': instance.specialDefense,
      'speed': instance.speed,
    };
