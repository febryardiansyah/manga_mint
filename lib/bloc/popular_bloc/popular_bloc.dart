import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/popular_model.dart';
import 'package:mangamint/repositories/popular_repo.dart';
import 'package:rxdart/rxdart.dart';
import './bloc.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  PopularRepo _popularRepo;

  PopularBloc(this._popularRepo) : super(InitialPopularState());

  @override
  Stream<Transition<PopularEvent, PopularState>> transformEvents(
      Stream<PopularEvent> events,
      TransitionFunction<PopularEvent, PopularState> transitionFn) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 500)),
      transitionFn
    );
  }

  bool _hasReachedMax(PopularState state) => state is PopularLoadedState && state.hasReachedMax;
  @override
  Stream<PopularState> mapEventToState(
    PopularEvent event,
  ) async* {
    final currentState = state;
    int page = 1;
    if(event is FetchPopular && !_hasReachedMax(currentState)){
      try{
        if(currentState is InitialPopularState){
          yield PopularLoadingState();
          List<PopularModel>list = await _popularRepo.getPopular(page: page);
          yield PopularLoadedState(popularList: list,hasReachedMax: false,page: page+=1);
        }
        if(currentState is PopularLoadedState){
          List<PopularModel>list = await _popularRepo.getPopular(page: currentState.page);
          yield list.isEmpty ? currentState.copyWith(hasReachedMax: true):
          PopularLoadedState(hasReachedMax: false,popularList: currentState.popularList+list,page: currentState.page+=1);
        }
      }catch(e){
        yield PopularFailureState(msg: e.toString());
      }
    }
  }
}
