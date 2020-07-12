import 'package:equatable/equatable.dart';

class PopularModel extends Equatable{
  String title,chapter,type,thumb,endpoint,update;

  PopularModel({this.title, this.chapter, this.type, this.thumb, this.endpoint,
      this.update});

  factory PopularModel.fromJson(Map<String,dynamic>json){
   return PopularModel(
    title: json['title'],
    endpoint: json['endpoint'],
    thumb: json['thumb'],
    type: json['type'],
    chapter: json['chapter'],
    update: json['update']
   );
  }

  @override
  List<Object> get props => [];
}