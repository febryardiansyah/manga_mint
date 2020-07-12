import 'package:equatable/equatable.dart';
import 'package:mangamint/models/recomended_model.dart';

abstract class RecomendedState extends Equatable {
  const RecomendedState();
  @override
  List<Object> get props => [];
}

class InitialRecomendedState extends RecomendedState {}

class RecommendedLoadingState extends RecomendedState{}

class RecommendedLoadedState extends RecomendedState{
  final List<RecommendedList> recommendedList;

  RecommendedLoadedState({this.recommendedList});
  @override
  List<Object> get props => [recommendedList];
}

class RecomendedFailureState extends RecomendedState{
  final String msg;

  RecomendedFailureState({this.msg});
  @override
  List<Object> get props => [msg];
}
