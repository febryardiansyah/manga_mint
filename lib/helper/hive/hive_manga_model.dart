import 'package:hive/hive.dart';

part 'hive_manga_model.g.dart';

@HiveType()
class HiveMangaModel{
  @HiveField(0)
  String manga_endpoint;
  @HiveField(1)
  String thumb;
  @HiveField(2)
  String type;
  @HiveField(3)
  String title;

  HiveMangaModel({this.manga_endpoint, this.thumb, this.type, this.title});

}