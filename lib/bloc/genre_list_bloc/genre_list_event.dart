import 'package:equatable/equatable.dart';

abstract class GenreListEvent extends Equatable {
  const GenreListEvent();
  @override
  List<Object> get props => [];
}
class FetchGenreList extends GenreListEvent{}
class RefreshGenreList extends GenreListEvent{}