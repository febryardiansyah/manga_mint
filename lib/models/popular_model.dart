import 'package:equatable/equatable.dart';

class PopularModel extends Equatable{
  String title,chapter,type,thumb,endpoint,upload_on;

  PopularModel({this.title, this.chapter, this.type, this.thumb, this.endpoint,
      this.upload_on});

  factory PopularModel.fromJson(Map<String,dynamic>json){
   return PopularModel(
    title: json['title'],
    endpoint: json['endpoint'],
    thumb: json['thumb'],
    type: json['type'],
    chapter: json['chapter'],
    upload_on: json['upload_on']
   );
  }

  @override
  List<Object> get props => [];
}
