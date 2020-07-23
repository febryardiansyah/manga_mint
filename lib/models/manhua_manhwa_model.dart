import 'package:equatable/equatable.dart';

class ManhuaManwaModel extends Equatable{
  String title,type,thumb,endpoint,updated_on,chapter;
  num score;

  ManhuaManwaModel({this.title, this.type, this.thumb, this.endpoint,
      this.score,this.updated_on,this.chapter});
  factory ManhuaManwaModel.fromJson(Map<String,dynamic>json){
    return ManhuaManwaModel(
      title: json['title'],
      type: json['type'],
      thumb: json['thumb'],
      score: json['score'],
      endpoint: json['endpoint'],
      updated_on: json['updated_on'],
      chapter: json['chapter']
    );
  }

  @override
  List<Object> get props => [title,type,thumb,endpoint,updated_on];
}