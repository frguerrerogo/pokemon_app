// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PokemonHiveModelAdapter extends TypeAdapter<PokemonHiveModel> {
  @override
  final int typeId = 1;

  @override
  PokemonHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PokemonHiveModel(
      id: fields[0] as int,
      name: fields[1] as String,
      height: fields[2] as double,
      weight: fields[3] as double,
      imageUrl: fields[4] as String,
      hp: fields[5] as int,
      attack: fields[6] as int,
      defense: fields[7] as int,
      specialAttack: fields[8] as int,
      specialDefense: fields[9] as int,
      speed: fields[10] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PokemonHiveModel obj) {
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
      other is PokemonHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
