import 'package:equatable/equatable.dart';

abstract class MangaByGenreEvent extends Equatable {
  const MangaByGenreEvent();
  @override
  List<Object> get props => [];
}
class FetchMangByGenre extends MangaByGenreEvent{
  final String endpoint;

  FetchMangByGenre({this.endpoint});
  @override
  List<Object> get props => [endpoint];

}
class InitialMangaByGenreEvent extends MangaByGenreEvent{
  final String endpoint;

  InitialMangaByGenreEvent({this.endpoint});
  @override
  List<Object> get props => [endpoint];
}