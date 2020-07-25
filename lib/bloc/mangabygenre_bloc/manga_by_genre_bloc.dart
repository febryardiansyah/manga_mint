import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/genre_list_model.dart';
import 'package:mangamint/repositories/genre_list_repo.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class MangaByGenreBloc extends Bloc<MangaByGenreEvent, MangaByGenreState> {
  MangaByGenreRepo _mangaByGenreRepo;
  MangaByGenreBloc(this._mangaByGenreRepo) : super(InitialMangaByGenreState());

  bool _hasReachedMax(MangaByGenreState state) => state is MangaByGenreLoadedState && state.hasReachedMax;
  @override
  Stream<Transition<MangaByGenreEvent, MangaByGenreState>> transformEvents(Stream<MangaByGenreEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(
      Duration(milliseconds: 500)
    ), transitionFn);
  }
  @override
  Stream<MangaByGenreState> mapEventToState(
    MangaByGenreEvent event,
  ) async* {
    final currentState = state;
    int page = 1;
    if(event is FetchMangByGenre && !_hasReachedMax(currentState)){
      try{
        if(currentState is InitialMangaByGenreState){
          yield MangaByGenreLoadingState();
          List<MangaByGenreModel> list = await _mangaByGenreRepo.getManga(genre: event.endpoint,page: page+=1);
          yield MangaByGenreLoadedState(list: list,page: page+=1,hasReachedMax: false);
          return;
        }
        if(currentState is MangaByGenreLoadedState){
          List<MangaByGenreModel> list = await _mangaByGenreRepo.getManga(genre: event.endpoint,page: currentState.page);
          yield list.isEmpty ? currentState.copyWith(hasReachedMax: true,list: currentState.list):
          MangaByGenreLoadedState(list: currentState.list+list,hasReachedMax: false,page:
          currentState.page+=1);
        }
      }catch(e){
        yield MangaByGenreFailureState(msg: e.toString());
      }
    }
    if(event is InitialMangaByGenreEvent){
      yield MangaByGenreLoadingState();
      try{
        List<MangaByGenreModel> list = await _mangaByGenreRepo.getManga(genre: event.endpoint,page: page);
        yield MangaByGenreLoadedState(list: list,page: page+=1,hasReachedMax: false);
      }catch(e){
        yield MangaByGenreFailureState(msg: e.toString());
      }
    }
  }
}
