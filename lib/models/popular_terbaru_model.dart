import 'package:equatable/equatable.dart';

class PopularTerbaruModel extends Equatable{
  String title,chapter,type,thumb,endpoint,update;

  PopularTerbaruModel({this.title, this.chapter, this.type, this.thumb, this.endpoint,
      this.update});

  factory PopularTerbaruModel.fromJson(Map<String,dynamic>json){
   return PopularTerbaruModel(
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
