import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangamint/bloc/chapter_bloc/bloc.dart';
import 'package:mangamint/components/loading_dialog.dart';
import 'package:mangamint/screens/chapter_screen/chapter_screen.dart';

class IndexChapter extends StatefulWidget {
  final String enpoint;

  const IndexChapter({Key key, this.enpoint}) : super(key: key);
  @override
  _IndexChapterState createState() => _IndexChapterState();
}

class _IndexChapterState extends State<IndexChapter> {
  ChapterBlocBloc _chapterBlocBloc;
  String get endpoint => widget.enpoint;

  @override
  void initState() {
    super.initState();
    _chapterBlocBloc = BlocProvider.of<ChapterBlocBloc>(context);
    _chapterBlocBloc.add(FetchChapter(endpoint: endpoint));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChapterBlocBloc,ChapterBlocState>(
      builder: (context,state){
        if(state is ChapterLoadingState){
          return LoadingDialog();
        }else if(state is ChapterLoadedState){
          return ChapterScreen(data: state.data,);
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