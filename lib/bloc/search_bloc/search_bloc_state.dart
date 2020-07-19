import 'package:equatable/equatable.dart';
import 'package:mangamint/models/search_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchBlocState extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialSearchBlocState extends SearchBlocState {}
class SearchLoadingState extends SearchBlocState{}
class SearchLoadedState extends SearchBlocState{
  final List<SearchModel>searchList;

  SearchLoadedState({this.searchList});
  @override
  List<Object> get props => [searchList];
}
class SearchFailureState extends SearchBlocState{
  final String msg;

  SearchFailureState({this.msg});
  @override
  List<Object> get props => [msg];

}
