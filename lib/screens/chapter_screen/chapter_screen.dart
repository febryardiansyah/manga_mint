import 'package:flutter/material.dart';
import 'package:mangamint/models/chapter_model.dart';

class ChapterScreen extends StatelessWidget {
  final ChapterModel data;

  const ChapterScreen({Key key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: ListView.builder(
        itemCount: data.chapterImage.length,
        itemBuilder: (context,i){
          return Image.network(data.chapterImage[i].chapter_image_link);
        },
      ),
    );
  }
}
