import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/popular_terbaru_model.dart';
import 'package:mangamint/repositories/terbaru_repo.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class TerbaruBloc extends Bloc<TerbaruEvent, TerbaruState> {
  TerbaruRepo _terbaruRepo;
  TerbaruBloc(this._terbaruRepo) : super(InitialTerbaruState());

  @override
  Stream<Transition<TerbaruEvent, TerbaruState>> transformEvents(
      Stream<TerbaruEvent> events,
      TransitionFunction<TerbaruEvent, TerbaruState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 500)),
      transitionFn
    );
  }

  bool _hasReachedMax(TerbaruState state) => state is TerbaruLoadedState && state.hasReachedMax;

  @override
  Stream<TerbaruState> mapEventToState(
    TerbaruEvent event,
  ) async* {
    int page = 1;
    final currentState = state;
    if(event is FetchTerbaru && !_hasReachedMax(currentState)){
     yield* _fethTerbaruEventToState(currentState, page);
    }
    if(event is InitialTerbaruEvent){
      yield* _initialTerbaruEventToState(currentState, page);
    }
    if(event is RefreshTerbaru){
      yield* _refreshEventToState(currentState, page);
    }
  }

  Stream<TerbaruState> _fethTerbaruEventToState(TerbaruState currentState,int page)async*{
    try{
      if(currentState is InitialTerbaruState){
        yield TerbaruLoadingState();
        final List<PopularTerbaruModel> list = await _terbaruRepo.getTerbaru(page: page);
        yield TerbaruLoadedState(terbaruList: list,hasReachedMax: false,page: page+=1);
      }
      if(currentState is TerbaruLoadedState){
        final List<PopularTerbaruModel> list = await _terbaruRepo.getTerbaru(page: page+=1);
        yield list.isEmpty ? currentState.copyWith(hasReachedMax: true):
        TerbaruLoadedState(terbaruList: currentState.terbaruList+list,hasReachedMax: false,page:
        currentState.page+=1);
      }
    }catch(e){
      yield TerbaruFailureState(msg: e.toString());
    }
  }
  Stream<TerbaruState> _initialTerbaruEventToState(TerbaruState currentState,int page)async*{
    try{
      if(currentState is InitialTerbaruState){
        yield TerbaruLoadingState();
        final List<PopularTerbaruModel> list = await _terbaruRepo.getTerbaru(page: page);
        yield TerbaruLoadedState(terbaruList: list,hasReachedMax: false,page: page+=1);
      }
      if(currentState is TerbaruLoadedState){
        yield TerbaruLoadedState(terbaruList: currentState.terbaruList,hasReachedMax: false,page: page);
      }
    }catch(e){
      yield TerbaruFailureState(msg: e.toString());
    }
  }
  Stream<TerbaruState> _refreshEventToState(TerbaruState currentState, int page)async*{
    yield TerbaruLoadingState();
    try{
      final List<PopularTerbaruModel> list = await _terbaruRepo.getTerbaru(page: page);
      yield TerbaruLoadedState(terbaruList: list,hasReachedMax: false,page: page+=1);
    }catch(e){
      yield TerbaruFailureState(msg: e.toString());
  }
  }
}
