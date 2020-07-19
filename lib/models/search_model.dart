import 'package:equatable/equatable.dart';

class SearchModel extends Equatable{
  String title,thumb,type,endpoint;
  num score;

  SearchModel({this.title, this.thumb, this.type, this.endpoint, this.score});

  factory SearchModel.fromJson(Map<String,dynamic>json){
    return SearchModel(
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