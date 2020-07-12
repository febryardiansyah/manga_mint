import 'package:equatable/equatable.dart';
import 'package:mangamint/models/popular_model.dart';

abstract class PopularState extends Equatable {
  const PopularState();
  @override
  List<Object> get props => [];
}

class InitialPopularState extends PopularState {}
class PopularLoadingState extends PopularState{}
class PopularLoadedState extends PopularState{
  final List<PopularModel>popularList;
  final bool hasReachedMax;
  int page = 0;

  PopularLoadedState({this.popularList, this.hasReachedMax,this.page});
  PopularLoadedState copyWith({List<PopularModel>popularList,bool hasReachedMax}){
    return PopularLoadedState(
      popularList: popularList ?? this.popularList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  @override
  List<Object> get props => [popularList,page,hasReachedMax];
}
class PopularFailureState extends PopularState{
  final String msg;

  PopularFailureState({this.msg});
  @override
  List<Object> get props => [msg];

}
