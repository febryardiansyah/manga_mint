import 'package:flutter/material.dart';
import 'package:mangamint/bloc/manga_detail_bloc/bloc.dart';
import 'package:mangamint/models/manga_detail_model.dart';
import 'package:mangamint/screens/chapter_screen/index_chapter.dart';

class MangaDetailScreen extends StatefulWidget {
  final MangaDetailModel data;

  const MangaDetailScreen({Key key, this.data}) : super(key: key);

  @override
  _MangaDetailScreenState createState() => _MangaDetailScreenState();
}

class _MangaDetailScreenState extends State<MangaDetailScreen> {

  MangaDetailModel get data => widget.data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.title),
      ),
      body: ListView.builder(
        itemCount: data.chapterList.length,
        itemBuilder: (context,i){
          return ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => IndexChapter(enpoint: data.chapterList[i].chapter_endpoint,)
              ));
            },
            title: Text(data.chapterList[i].chapter_title),
          );
        },
      ),
    );
  }
}
