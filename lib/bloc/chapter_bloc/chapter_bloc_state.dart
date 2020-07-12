import 'package:equatable/equatable.dart';
import 'package:mangamint/models/chapter_model.dart';

abstract class ChapterBlocState extends Equatable {
  const ChapterBlocState();
  @override
  List<Object> get props => [];
}

class InitialChapterBlocState extends ChapterBlocState {}

class ChapterLoadingState extends ChapterBlocState{}

class ChapterLoadedState extends ChapterBlocState{
  final ChapterModel data;

  ChapterLoadedState({this.data});
  @override
  List<Object> get props => [data];
}

class ChapterFailureState extends ChapterBlocState{
  final String msg;

  ChapterFailureState({this.msg});
  @override
  List<Object> get props => [msg];

}
