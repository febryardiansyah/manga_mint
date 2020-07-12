import 'package:equatable/equatable.dart';

class GeneListModel extends Equatable{
  String title,endpoint;

  GeneListModel({this.title, this.endpoint});

  factory GeneListModel.fromMap(Map<String,dynamic>json){
    return GeneListModel(
      endpoint: json['endpoint'],
      title: json['title']
    );
  }
  @override
  List<Object> get props => [];
}