import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/genre_list_model.dart';
import 'package:mangamint/repositories/genre_list_repo.dart';
import './bloc.dart';

class GenreListBloc extends Bloc<GenreListEvent, GenreListState> {
  GenreListRepo _genreListRepo;

  GenreListBloc(this._genreListRepo) : super(InitialGenreListState());

  @override
  Stream<GenreListState> mapEventToState(
    GenreListEvent event,
  ) async* {
    final currentState = state;
    if(event is FetchGenreList){
      try{
        if(currentState is InitialGenreListState){
          yield GenreListLoadingState();
          List<GeneListModel>list = await _genreListRepo.getGenreList();
          yield GenreListLoadedState(genreList: list);
        }
        if(currentState is GenreListLoadedState){
          yield GenreListLoadedState(genreList: currentState.genreList);
        }
      }catch(e){
        yield GenreListFailureState(msg: e.toString());
      }
    }
    if(event is RefreshGenreList){
      yield GenreListLoadingState();
      try{
        List<GeneListModel>list = await _genreListRepo.getGenreList();
        yield GenreListLoadedState(genreList: list);
      }catch(e){
        yield GenreListFailureState(msg: e.toString());
      }
    }
  }
}
