import 'package:equatable/equatable.dart';
import 'package:mangamint/models/genre_list_model.dart';

abstract class MangaByGenreState extends Equatable {
  const MangaByGenreState();
  @override
  List<Object> get props => [];
}

class InitialMangaByGenreState extends MangaByGenreState {}
class MangaByGenreLoadingState extends MangaByGenreState{}
class MangaByGenreLoadedState extends MangaByGenreState{
  final List<MangaByGenreModel> list;
  final bool hasReachedMax;
  int page = 0;

  MangaByGenreLoadedState({this.list,this.page,this.hasReachedMax});
  MangaByGenreLoadedState copyWith({List<MangaByGenreModel> list,bool hasReachedMax}){
    return MangaByGenreLoadedState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      list: list ?? this.list
    );
  }
  @override
  List<Object> get props => [list];

}
class MangaByGenreFailureState extends MangaByGenreState{
  final String msg;

  MangaByGenreFailureState({this.msg});
  @override
  List<Object> get props => [msg];

}
