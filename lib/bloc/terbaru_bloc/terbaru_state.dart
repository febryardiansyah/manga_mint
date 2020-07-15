import 'package:equatable/equatable.dart';
import 'package:mangamint/models/popular_terbaru_model.dart';

abstract class TerbaruState extends Equatable {
  const TerbaruState();
  @override
  List<Object> get props => [];
}

class InitialTerbaruState extends TerbaruState {}
class TerbaruLoadingState extends TerbaruState{}
class TerbaruLoadedState extends TerbaruState{
  final List<PopularTerbaruModel>terbaruList;
  final bool hasReachedMax;
  int page = 0;

  TerbaruLoadedState({this.terbaruList, this.hasReachedMax, this.page});

  TerbaruLoadedState copyWith({List<PopularTerbaruModel>terbaruList,bool hasReachedMax}){
    return TerbaruLoadedState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        terbaruList: terbaruList ?? this.terbaruList
    );
  }
  @override
  List<Object> get props => [terbaruList,page,hasReachedMax];
}
class TerbaruFailureState extends TerbaruState{
  final String msg;

  TerbaruFailureState({this.msg});
  @override
  List<Object> get props => [msg];
}
