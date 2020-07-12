import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/chapter_model.dart';
import 'package:mangamint/repositories/chapter_repo.dart';
import './bloc.dart';

class ChapterBlocBloc extends Bloc<ChapterBlocEvent, ChapterBlocState> {
  final ChapterRepo _chapterRepo;

  ChapterBlocBloc(this._chapterRepo) : super(InitialChapterBlocState());

  @override
  Stream<ChapterBlocState> mapEventToState(
    ChapterBlocEvent event,
  ) async* {
    if(event is FetchChapter){
      yield ChapterLoadingState();
      try{
        final ChapterModel data = await _chapterRepo.getChapter(event.endpoint);
        yield ChapterLoadedState(data: data);
      }catch(e){
        yield ChapterFailureState(msg: e.toString());
      }
    }
  }
}
