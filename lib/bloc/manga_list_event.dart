import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MangaListEvent extends Equatable{
  const MangaListEvent();
}

class FetchManga extends MangaListEvent{

  @override
  List<Object> get props => [];
}