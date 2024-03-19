// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apod_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class APODEntityAdapter extends TypeAdapter<APODEntity> {
  @override
  final int typeId = 0;

  @override
  APODEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return APODEntity(
      title: fields[0] as String,
      explanation: fields[1] as String,
      date: fields[2] as String,
      url: fields[3] as String,
      hdurl: fields[4] as String,
      mediaType: fields[5] as String,
      serviceVersion: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, APODEntity obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.explanation)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.hdurl)
      ..writeByte(5)
      ..write(obj.mediaType)
      ..writeByte(6)
      ..write(obj.serviceVersion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is APODEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
