import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/chapter_bloc/bloc.dart';
import 'package:mangamint/components/loading_dialog.dart';
import 'package:mangamint/helper/sqflite/chapter_local_model.dart';
import 'package:mangamint/helper/sqflite/database_access.dart';
import 'package:mangamint/models/chapter_model.dart';
import 'package:mangamint/screens/chapter_screen/chapter_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexChapter extends StatefulWidget {
  final String enpoint;

  const IndexChapter({Key key, this.enpoint}) : super(key: key);
  @override
  _IndexChapterState createState() => _IndexChapterState();
}

class _IndexChapterState extends State<IndexChapter> {
  ChapterBlocBloc _chapterBlocBloc;
  String get endpoint => widget.enpoint;
  int currentIndex = 0;
  DatabaseAccess _databaseAccess = DatabaseAccess();
  Future<List<ChapterLocalModel>>future;

  void getDatabase()async{
    setState(() {
      future = _databaseAccess.getChapterIndex();
    });
    await future.then((value){
      value.forEach((element) {
        if(element.endpoint == widget.enpoint){
          setState(() {
            currentIndex = element.index;
          });
        }
        setState(() {
          currentIndex = 0;
        });
      });
    });
  }
  @override
  void initState() {
    super.initState();
    _chapterBlocBloc = BlocProvider.of<ChapterBlocBloc>(context)..add(FetchChapter(endpoint: widget.enpoint));
    getDatabase();

  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterBlocBloc,ChapterBlocState>(
      builder: (context,state){
        if(state is ChapterLoadingState){
          return LoadingDialog();
        }else if(state is ChapterLoadedState){
          return ChapterScreen(data: state.data,currentIndex: currentIndex,);
        }else if(state is ChapterFailureState){
          return Scaffold(
            body: Center(child: Text(state.msg)),
          );
        }
        return Container();
      },
    );
  }
}