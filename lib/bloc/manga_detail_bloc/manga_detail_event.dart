import 'package:equatable/equatable.dart';

abstract class MangaDetailEvent extends Equatable {
  const MangaDetailEvent();
  @override
  List<Object> get props => [];
}

class FetchMangaDetail extends MangaDetailEvent{
  final String endpoint;
  FetchMangaDetail(this.endpoint);
}

