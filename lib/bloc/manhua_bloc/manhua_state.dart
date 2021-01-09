part of 'manhua_bloc.dart';

@immutable
abstract class ManhuaState extends Equatable{
  const ManhuaState();
  @override
  List<Object> get props => [];
}

class InitialManhuaState extends ManhuaState {}
class ManhuaLoadingState extends ManhuaState {}
class ManhuaLoadedState extends ManhuaState {
  final List<ManhuaManwaModel>list;
  final bool hasReachedMax;
  int page = 0;

  ManhuaLoadedState({this.list, this.hasReachedMax, this.page});
  ManhuaLoadedState copyWith({
    List<ManhuaManwaModel>list,bool hasReachedMax
  }){
    return ManhuaLoadedState(
        list: list ?? this.list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  @override
  List<Object> get props => [list,hasReachedMax,page];
}
class ManhuaFailure extends ManhuaState {
  final String msg;

  ManhuaFailure({this.msg});
  @override
  List<Object> get props => [msg];
}