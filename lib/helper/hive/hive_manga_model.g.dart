// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_manga_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMangaModelAdapter extends TypeAdapter<HiveMangaModel> {
  @override
  HiveMangaModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMangaModel(
      manga_endpoint: fields[0] as String,
      thumb: fields[1] as String,
      type: fields[2] as String,
      title: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HiveMangaModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.manga_endpoint)
      ..writeByte(1)
      ..write(obj.thumb)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get typeId => 0;
}
