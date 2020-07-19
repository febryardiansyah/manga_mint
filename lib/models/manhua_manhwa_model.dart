import 'package:equatable/equatable.dart';

class ManhuaManwaModel extends Equatable{
  String title,type,thumb,endpoint;
  num score;

  ManhuaManwaModel({this.title, this.type, this.thumb, this.endpoint,
      this.score});
  factory ManhuaManwaModel.fromJson(Map<String,dynamic>json){
    return ManhuaManwaModel(
      title: json['title'],
      type: json['type'],
      thumb: json['thumb'],
      score: json['score'],
      endpoint: json['endpoint']
    );
  }

  @override
  List<Object> get props => [];
}