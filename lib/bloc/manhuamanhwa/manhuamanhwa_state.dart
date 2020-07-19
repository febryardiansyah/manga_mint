import 'package:equatable/equatable.dart';
import 'package:mangamint/models/manhua_manhwa_model.dart';

abstract class ManhuamanhwaState extends Equatable {
  const ManhuamanhwaState();
  @override
  List<Object> get props => [];
}

class InitialManhuamanhwaState extends ManhuamanhwaState {}
class ManhuaManhwaLoadingState extends ManhuamanhwaState{}
class ManhuaLoadedState extends ManhuamanhwaState{
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
class ManhwaLoadedState extends ManhuamanhwaState{
  final List<ManhuaManwaModel>list;
  final bool hasReachedMax;
  int page = 0;

  ManhwaLoadedState({this.list, this.hasReachedMax, this.page});
  ManhwaLoadedState copyWith({
    List<ManhuaManwaModel>list,bool hasReachedMax
  }){
    return ManhwaLoadedState(
        list: list ?? this.list,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  @override
  List<Object> get props => [list,hasReachedMax,page];
}
class ManhuaManhwaFailureState extends ManhuamanhwaState{
  final String msg;

  ManhuaManhwaFailureState({this.msg});
  @override
  List<Object> get props => [msg];
}
