import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mangamint/models/search_model.dart';
import 'package:mangamint/repositories/search_repo.dart';
import './bloc.dart';

class SearchBlocBloc extends Bloc<SearchBlocEvent, SearchBlocState> {
  final SearchRepo _searchRepo;

  SearchBlocBloc(this._searchRepo) : super(InitialSearchBlocState());

  @override
  Stream<SearchBlocState> mapEventToState(
    SearchBlocEvent event,
  ) async* {
    if(event is FetchSearch){
      yield SearchLoadingState();
      try{
        final List<SearchModel>list = await _searchRepo.searchManga(query: event.query);
        yield SearchLoadedState(searchList: list);
      }catch(e){
        yield SearchFailureState(msg: e.toString());
      }
    }
  }
}
