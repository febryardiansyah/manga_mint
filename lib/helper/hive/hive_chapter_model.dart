import 'package:hive/hive.dart';

part 'hive_chapter_model.g.dart';

@HiveType()
class HiveChapterModel{
  @HiveField(0)
  String endpoint;
  @HiveField(1)
  int index;

  HiveChapterModel({this.endpoint, this.index});

}
