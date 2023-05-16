// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutAdapter extends TypeAdapter<Workout> {
  @override
  final int typeId = 0;

  @override
  Workout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Workout()
      ..wkoutName = fields[0] as String
      ..dt = fields[1] as DateTime
      ..dtwithTime = fields[2] as DateTime
      ..exList = (fields[3] as List).cast<Exercise>()
      ..emoji = fields[4] as String
      ..colorVal = fields[5] as int;
  }

  @override
  void write(BinaryWriter writer, Workout obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.wkoutName)
      ..writeByte(1)
      ..write(obj.dt)
      ..writeByte(2)
      ..write(obj.dtwithTime)
      ..writeByte(3)
      ..write(obj.exList)
      ..writeByte(4)
      ..write(obj.emoji)
      ..writeByte(5)
      ..write(obj.colorVal);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExerciseAdapter extends TypeAdapter<Exercise> {
  @override
  final int typeId = 1;

  @override
  Exercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Exercise()
      ..exName = fields[0] as String
      ..notes = fields[1] as String
      ..setList = (fields[2] as List).cast<Set>();
  }

  @override
  void write(BinaryWriter writer, Exercise obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.exName)
      ..writeByte(1)
      ..write(obj.notes)
      ..writeByte(2)
      ..write(obj.setList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SetAdapter extends TypeAdapter<Set> {
  @override
  final int typeId = 2;

  @override
  Set read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Set(fields[0] as int, fields[1] as int);
  }

  @override
  void write(BinaryWriter writer, Set obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.repCount)
      ..writeByte(1)
      ..write(obj.weight);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PRAdapter extends TypeAdapter<PR> {
  @override
  final int typeId = 3;

  @override
  PR read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PR(fields[0] as int, fields[1] as DateTime);
  }

  @override
  void write(BinaryWriter writer, PR obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.prWeight)
      ..writeByte(1)
      ..write(obj.prDatetime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PRAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
