import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mangamint/bloc/chapter_bloc/bloc.dart';
import 'package:mangamint/components/build_error.dart';
import 'package:mangamint/components/loading_dialog.dart';
import 'package:mangamint/helper/hive/hive_chapter_model.dart';
import 'package:mangamint/helper/hive/hive_chapter_opened_model.dart';
import 'package:mangamint/screens/chapter_screen/chapter_screen.dart';

class IndexChapter extends StatefulWidget {
  final String endpoint;

  const IndexChapter({Key key, this.endpoint}) : super(key: key);
  @override
  _IndexChapterState createState() => _IndexChapterState();
}

class _IndexChapterState extends State<IndexChapter> {
  ChapterBlocBloc _chapterBlocBloc;
  String get endpoint => widget.endpoint;
  int currentIndex = 0;
  bool isExist = false;
  var chapterBox = Hive.box('chapter');
  var lastBox = Hive.box('lastOpenedChapter');
  HiveChapterOpenedModel lastModel;
  void _checkLastChapter(){
    int count = chapterBox.length;
    for(int i = 0;i<count;i++){
      HiveChapterModel chapterModel = chapterBox.getAt(i);
      if(chapterModel.endpoint == widget.endpoint){
        setState(() {
          isExist = true;
          currentIndex = chapterModel.index;
        });
      }
    }
    if(!isExist){
      setState(() {
        currentIndex = 0;
      });
    }
  }
  @override
  void initState() {
    super.initState();
    _chapterBlocBloc = BlocProvider.of<ChapterBlocBloc>(context)..add(FetchChapter(endpoint: widget.endpoint));
    _checkLastChapter();

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
          return BuildError();
        }
        return Container();
      },
    );
  }
}