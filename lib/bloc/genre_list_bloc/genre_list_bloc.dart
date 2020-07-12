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
    if(event is FetchGenreList){
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
