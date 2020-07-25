import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/manga_list_model.dart';
import 'package:mangamint/repositories/manga_list_repo.dart';
import './bloc.dart';
import 'package:rxdart/rxdart.dart';

class MangaListBloc extends Bloc<MangaListEvent, MangaListState> {
  final MangaListRepo _mangaListRepo;

  MangaListBloc(this._mangaListRepo) : super(InitialMangaListState());


  @override
  Stream<Transition<MangaListEvent, MangaListState>> transformEvents(
      Stream<MangaListEvent> events,
      TransitionFunction<MangaListEvent, MangaListState> transitionFn) {
      return super.transformEvents(
        events.debounceTime(Duration(milliseconds: 500)),
        transitionFn
      );
  }

  bool _hasReachedMax(MangaListState state) => state is MangaListStateLoaded && state.hasReachedMax;

  @override
  Stream<MangaListState> mapEventToState(
    MangaListEvent event,
  ) async* {
    final currentState = state;
    int page = 1;
    if(event is FetchManga && !_hasReachedMax(currentState)){
    yield* _fetchMangaToState(currentState, page);
    }
    if(event is InitialFetchMangaEvent){
      yield* _initialEventToState(currentState, page);
    }
    if(event is RefreshMangaEvent){
      yield MangaListLoadingState();
      try{
        final list = await _mangaListRepo.getMangaList(page: page);
        yield MangaListStateLoaded(hasReachedMax: false,mangaList: list,page: page);
      }catch(e){
        yield MangaListStateFailure(msg: e.toString());
      }
    }
  }
  Stream<MangaListState> _fetchMangaToState(MangaListState currentState,int page)async*{
    try{
      if(currentState is InitialMangaListState){
        yield MangaListLoadingState();
        final List<MangaListModel>list = await _mangaListRepo.getMangaList(page: 2);
        yield MangaListStateLoaded(mangaList: list,hasReachedMax: false,page: page+=1);
      }
      if(currentState is MangaListStateLoaded){
        final List<MangaListModel>list = await _mangaListRepo.getMangaList(
            page: currentState.page
        );
        yield list.isEmpty ? currentState.copyWith(hasReachedMax: true):
        MangaListStateLoaded(mangaList: currentState.mangaList + list,hasReachedMax: false,page: currentState.page+=1);
      }
    }catch(e){
      yield MangaListStateFailure(msg: e.toString());
    }
  }
  Stream<MangaListState> _initialEventToState(MangaListState currentState,int page)async*{
    try{
      if(currentState is InitialMangaListState){
        yield MangaListLoadingState();
        final List<MangaListModel>list = await _mangaListRepo.getMangaList(page: page);
        yield MangaListStateLoaded(mangaList: list,hasReachedMax: false,page: page+=1);
      }
      if(currentState is MangaListStateLoaded){
        yield MangaListStateLoaded(mangaList: currentState.mangaList,page: page,hasReachedMax: false);
      }
    }catch(e){
      yield MangaListStateFailure(msg: e.toString());

    }
  }
}
