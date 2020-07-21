import 'package:hive/hive.dart';

part 'hive_chapter_opened_model.g.dart';

@HiveType()
class HiveChapterOpenedModel{
  @HiveField(0)
  int lastChapter;
  @HiveField(1)
  String manga_endpoint;
  @HiveField(2)
  String chapter_endpoint;

  HiveChapterOpenedModel({this.lastChapter, this.manga_endpoint,this.chapter_endpoint});

}