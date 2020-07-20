import 'package:equatable/equatable.dart';

class MangaDetailModel{
  String title,thumb,status,type,author,
  updated_on,posted_on,synopsis,manga_endpoint;
  num score,released;
  List<Genres>genreList;
  List<ChapterList>chapterList;


  MangaDetailModel({this.title, this.thumb, this.status, this.released,
      this.type, this.author, this.updated_on, this.posted_on, this.synopsis,
      this.score, this.genreList, this.chapterList,this.manga_endpoint});

  factory MangaDetailModel.fromJson(Map<String,dynamic>json){
    return MangaDetailModel(
      title: json['title'],
      thumb: json['thumb'],
      type: json['type'],
      author: json['author'],
      posted_on: json['posted_on'],
      released: json['released'],
      score: json['score'],
      status: json['status'],
      synopsis: json['synopsis'],
      updated_on: json['updated_on'],
      manga_endpoint: json['manga_endpoint'],
      genreList: List<Genres>.from(json['genre_list'].map((item) => Genres.fromMap(item))),
      chapterList: List<ChapterList>.from(json['chapter'].map((item)=>ChapterList.fromMap(item))),
    );
  }

}
class Genres extends Equatable {
  String genre_name;

  Genres({this.genre_name});

  factory Genres.fromMap(Map<String,dynamic>json){
    return Genres(
      genre_name: json['genre_name']
    );
  }

  @override
  List<Object> get props => [genre_name];


}
class ChapterList extends Equatable{
  String chapter_title,chapter_endpoint,chapter_uploaded;

  ChapterList({this.chapter_title, this.chapter_endpoint, this.chapter_uploaded});

  @override
  List<Object> get props => [chapter_endpoint,chapter_title,chapter_uploaded];

  factory ChapterList.fromMap(Map<String,dynamic>json){
    return ChapterList(
      chapter_endpoint: json['chapter_endpoint'],
      chapter_title: json['chapter_title'],
      chapter_uploaded: json['chapter_uploaded']
    );
  }

}