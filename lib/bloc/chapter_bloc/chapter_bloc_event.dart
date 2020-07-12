import 'package:equatable/equatable.dart';

abstract class ChapterBlocEvent extends Equatable {
  const ChapterBlocEvent();
  @override
  List<Object> get props => [];
}
class FetchChapter extends ChapterBlocEvent{
  final String endpoint;

  FetchChapter({this.endpoint});
  @override
  List<Object> get props => [endpoint];
}