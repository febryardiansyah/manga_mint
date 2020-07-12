import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/manga_detail_model.dart';
import 'package:mangamint/repositories/manga_detail_repo.dart';
import './bloc.dart';

class MangaDetailBloc extends Bloc<MangaDetailEvent, MangaDetailState> {
 final MangaDetailRepo _detailRepo;

  MangaDetailBloc(this._detailRepo) : super(InitialMangaDetailState());

  @override
  Stream<MangaDetailState> mapEventToState(
    MangaDetailEvent event,
  ) async* {
    if(event is FetchMangaDetail){
      yield MangaDetailLoadingState();
      try{
        final MangaDetailModel data = await _detailRepo.getMangaDetail(event.endpoint);
        yield MangaDetailLoadedState(data: data);
      }catch(e){
        yield MangaDetailFailureState(msg: e.toString());
      }
    }
  }
}
