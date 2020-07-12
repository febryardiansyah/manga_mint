import 'package:equatable/equatable.dart';

class MangaModel {
  List <MangaListModel> mangaList;

  MangaModel({this.mangaList});

  factory MangaModel.fromJson(Map<String,dynamic>json){
    return MangaModel(
        mangaList: List<MangaListModel>.from(json['manga_list'].map((item) => MangaListModel.fromMap(item)))
    );
  }
}

class MangaListModel extends Equatable{
  String title,thumb,type,endpoint;
  num score;

  MangaListModel({this.title, this.thumb, this.type, this.score, this.endpoint});

  @override
  List<Object> get props => [title,thumb,type,score,endpoint];

  factory MangaListModel.fromMap(Map<String,dynamic>json){
    return MangaListModel(
      title: json['title'],
      thumb: json['thumb'],
      type: json['type'],
      score: json['score'],
      endpoint: json['endpoint']
    );
  }
}