import 'package:equatable/equatable.dart';
import 'package:mangamint/models/manga_detail_model.dart';

abstract class MangaDetailState extends Equatable {
  const MangaDetailState();
  @override
  List<Object> get props => [];
}

class InitialMangaDetailState extends MangaDetailState {}

class MangaDetailLoadingState extends MangaDetailState{}

class MangaDetailLoadedState extends MangaDetailState{
  final MangaDetailModel data;

  MangaDetailLoadedState({this.data});

  @override
  List<Object> get props => [data];
}

class MangaDetailFailureState extends MangaDetailState{
  final String msg;

  MangaDetailFailureState({this.msg});

  @override
  List<Object> get props => [msg];
}