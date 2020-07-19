import 'package:equatable/equatable.dart';

class GeneListModel extends Equatable{
  String title,endpoint;

  GeneListModel({this.title, this.endpoint});

  factory GeneListModel.fromMap(Map<String,dynamic>json){
    return GeneListModel(
      endpoint: json['endpoint'],
      title: json['title']
    );
  }
  @override
  List<Object> get props => [];
}
class MangaByGenreModel extends Equatable{
  String title,thumb,type,endpoint;
  num score;

  MangaByGenreModel({this.title, this.thumb, this.type, this.endpoint, this.score});

  factory MangaByGenreModel.fromJson(Map<String,dynamic>json){
    return MangaByGenreModel(
        title: json['title'],
        type: json['type'],
        thumb: json['thumb'],
        score: json['score'],
        endpoint: json['endpoint']
    );
  }

  @override
  List<Object> get props => [title,thumb,endpoint,score,type];
}