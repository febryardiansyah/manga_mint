import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/recomended_model.dart';
import 'package:mangamint/repositories/recommended_repo.dart';
import './bloc.dart';

class RecomendedBloc extends Bloc<RecomendedEvent, RecomendedState> {
  RecommendedRepo _recommendedRepo;

  RecomendedBloc(this._recommendedRepo) : super(InitialRecomendedState());

  @override
  Stream<RecomendedState> mapEventToState(
    RecomendedEvent event,
  ) async* {
    if(event is RecomendedEvent){
      yield RecommendedLoadingState();
      try{
        List<RecommendedList> list = await _recommendedRepo.getRecomended();
        yield RecommendedLoadedState(recommendedList: list);
      }catch(e){
        yield RecomendedFailureState(msg: e.toString());
      }
    }
  }
}
