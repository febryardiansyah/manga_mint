import 'package:equatable/equatable.dart';

class RecommendedModel extends Equatable{
  List<RecommendedList>recommendedList;

  RecommendedModel({this.recommendedList});

  factory RecommendedModel.fromJson(Map<String,dynamic>json){
    return RecommendedModel(
      recommendedList:List<RecommendedList>.from(json['manga_list'].map((json) => RecommendedList.fromMap(json)))
    );
  }

  @override
  List<Object> get props => [];
}

class RecommendedList extends Equatable{
  String title,endpoint,thumb,type;
  String update;

  RecommendedList({this.title, this.endpoint, this.thumb, this.type,
      this.update});


  factory RecommendedList.fromMap(Map<String,dynamic>json){
    return RecommendedList(
      title: json['title'],
      endpoint: json['endpoint'],
      thumb: json['thumb'],
      type: json['type'],
      update: json['update']
    );
  }

  @override
  List<Object> get props => [title,endpoint,thumb,type,update];
}