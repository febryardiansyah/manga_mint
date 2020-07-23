import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SearchBlocEvent extends Equatable{
  @override
  List<Object> get props => [];
}
class FetchSearch extends SearchBlocEvent{
  String query;

  FetchSearch({this.query});
  @override
  List<Object> get props => [query];

}
