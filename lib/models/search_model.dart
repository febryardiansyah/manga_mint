import 'package:equatable/equatable.dart';

class SearchModel extends Equatable{
  String title,thumb,type,endpoint,updated_on;
  num score;

  SearchModel({this.title, this.thumb, this.type, this.endpoint, this.score,this.updated_on});

  factory SearchModel.fromJson(Map<String,dynamic>json){
    return SearchModel(
      title: json['title'],
      type: json['type'],
      thumb: json['thumb'],
      score: json['score'],
      endpoint: json['endpoint'],
      updated_on: json['updated_on']
    );
  }

  @override
  List<Object> get props => [title,thumb,endpoint,score,type];
}