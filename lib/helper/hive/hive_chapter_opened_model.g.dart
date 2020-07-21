// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_chapter_opened_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveChapterOpenedModelAdapter
    extends TypeAdapter<HiveChapterOpenedModel> {
  @override
  HiveChapterOpenedModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveChapterOpenedModel(
      lastChapter: fields[0] as int,
      manga_endpoint: fields[1] as String,
    )..chapter_endpoint = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, HiveChapterOpenedModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.lastChapter)
      ..writeByte(1)
      ..write(obj.manga_endpoint)
      ..writeByte(2)
      ..write(obj.chapter_endpoint);
  }
  @override
  int get typeId => 2;
}
