// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_chapter_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveChapterModelAdapter extends TypeAdapter<HiveChapterModel> {
  @override
  HiveChapterModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveChapterModel(
      endpoint: fields[0] as String,
      index: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, HiveChapterModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.endpoint)
      ..writeByte(1)
      ..write(obj.index);
  }
  @override
  int get typeId => 1;
}
