import 'package:equatable/equatable.dart';

class ChapterModel{
  String title,chapter_endpoint;
  List<ChapterImage>chapterImage;

  ChapterModel({this.title, this.chapterImage,this.chapter_endpoint});

  factory ChapterModel.fromJson(Map<String,dynamic>json){
    return ChapterModel(
      title: json['title'],
      chapter_endpoint: json['chapter_endpoint'],
      chapterImage: List<ChapterImage>.from(json['chapter_image'].map((json) => ChapterImage.fromMap(json)))
    );
  }

  @override
  List<Object> get props => [title,chapterImage];

}
class ChapterImage extends Equatable{
  String chapter_image_link;
  int number;

  ChapterImage({this.number, this.chapter_image_link});

  factory ChapterImage.fromMap(Map<String,dynamic>json){
    return ChapterImage(
      number: json['image_number'],
      chapter_image_link: json['chapter_image_link']
    );
  }

  @override
  List<Object> get props => [number,chapter_image_link];
}