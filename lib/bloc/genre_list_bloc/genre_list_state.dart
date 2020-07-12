import 'package:equatable/equatable.dart';
import 'package:mangamint/models/genre_list_model.dart';

abstract class GenreListState extends Equatable {
  const GenreListState();
  @override
  List<Object> get props => [];
}

class InitialGenreListState extends GenreListState {}

class GenreListLoadingState extends GenreListState{}

class GenreListLoadedState extends GenreListState{
  final List<GeneListModel>genreList;

  GenreListLoadedState({this.genreList});
  @override
  List<Object> get props => [genreList];

}

class GenreListFailureState extends GenreListState{
  final String msg;

  GenreListFailureState({this.msg});
  @override
  List<Object> get props => [msg];
}
