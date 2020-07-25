import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class MangaListEvent extends Equatable{
  const MangaListEvent();
  @override
  List<Object> get props => [];
}

class FetchManga extends MangaListEvent{}
class InitialFetchMangaEvent extends MangaListEvent{}
class RefreshMangaEvent extends MangaListEvent{}