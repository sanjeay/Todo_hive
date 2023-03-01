// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';


// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************



import 'package:hive/hive.dart';
import 'package:sqlite/Hive%20Login/Models/user_models.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      email: fields[0] as String,
      password: fields[1] as String,
    )..id = fields[2] as String?;
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is UserModelAdapter &&
              runtimeType == other.runtimeType &&
              typeId == other.typeId;
}