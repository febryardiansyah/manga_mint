import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/bloc/bloc.dart';
import 'package:mangamint/models/manhua_manhwa_model.dart';
import 'package:mangamint/repositories/manhua_manhwa_repo.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class ManhuamanhwaBloc extends Bloc<ManhuamanhwaEvent, ManhuamanhwaState> {
  ManhuaManhwaRepo _manhuaManhwaRepo;

  ManhuamanhwaBloc(this._manhuaManhwaRepo) : super(InitialManhuamanhwaState());
  bool _hasReachedMax(ManhuamanhwaState state) => state is ManhuaLoadedState && state.hasReachedMax;
  @override
  Stream<Transition<ManhuamanhwaEvent, ManhuamanhwaState>> transformEvents(Stream<ManhuamanhwaEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(
      Duration(milliseconds: 500)
    ), transitionFn);
  }

  @override
  Stream<ManhuamanhwaState> mapEventToState(
    ManhuamanhwaEvent event,
  ) async* {
    final currentState = state;
    int page = 1;
    if(event is FetchManhua && !_hasReachedMax(currentState)){
      yield* _fetchManhuaToState(page, currentState,);
    }
    if(event is FetchManhwa && !_hasReachedMax(currentState)){
      yield* _fetchManhwaToState(page, currentState);
    }
  }

  Stream<ManhuamanhwaState> _fetchManhuaToState(int page,ManhuamanhwaState currentState)async*{
    try{
      if(currentState is InitialManhuamanhwaState || currentState is ManhwaLoadedState){
        yield ManhuaManhwaLoadingState();
        List<ManhuaManwaModel> manhuaList = await _manhuaManhwaRepo.getManhuaManhwa(
          type:'manhua',page: page
        );
        yield ManhuaLoadedState(list: manhuaList,page: page+=1,hasReachedMax: false);
      }
      if(currentState is ManhuaLoadedState){
        List<ManhuaManwaModel> list = await _manhuaManhwaRepo.getManhuaManhwa(
          type: 'manhua',page: currentState.page,
        );
        yield list.isEmpty ? currentState.copyWith(hasReachedMax: true):
            ManhuaLoadedState(list: currentState.list+list,
            page: currentState.page+=1,hasReachedMax: false);
      }
    }catch(e){
      yield ManhuaManhwaFailureState(msg: e.toString());
    }
  }

  Stream<ManhuamanhwaState> _fetchManhwaToState(int page, ManhuamanhwaState currentState)async*{
    try{
      if(currentState is InitialManhuamanhwaState || currentState is ManhuaLoadedState){
        yield ManhuaManhwaLoadingState();
        List<ManhuaManwaModel> manhwaList = await _manhuaManhwaRepo.getManhuaManhwa(
            type:'manhwa',page: page
        );
        yield ManhwaLoadedState(list: manhwaList,page: page+=1,hasReachedMax: false);
      }
      if(currentState is ManhwaLoadedState){
        List<ManhuaManwaModel> list = await _manhuaManhwaRepo.getManhuaManhwa(
          type: 'manhwa',page: currentState.page,
        );
        yield list.isEmpty ? currentState.copyWith(hasReachedMax: true):
        ManhwaLoadedState(list: currentState.list+list,
            page: currentState.page+=1,hasReachedMax: false);
      }
    }catch(e){
      yield ManhuaManhwaFailureState(msg: e.toString());
    }
  }
}
