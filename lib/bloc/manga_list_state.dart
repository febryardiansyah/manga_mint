import 'package:equatable/equatable.dart';
import 'package:mangamint/models/manga_list_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MangaListState extends Equatable {
  const MangaListState();

  List<Object> get props => [];
}

class InitialMangaListState extends MangaListState {}

class MangaListLoadingState extends MangaListState {}

class MangaListStateLoaded extends MangaListState {
  final List<MangaListModel> mangaList;
  final bool hasReachedMax;
  int page = 0;

  MangaListStateLoaded({this.mangaList,this.hasReachedMax,this.page});

  MangaListStateLoaded copyWith({List<MangaListModel>mangaList,bool hasReachedMax}){
    return MangaListStateLoaded(
      mangaList: mangaList ?? this.mangaList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [mangaList,hasReachedMax];
}

class MangaListStateFailure extends MangaListState {
  final String msg;

  MangaListStateFailure({this.msg});

  @override
  List<Object> get props => [msg];
}
