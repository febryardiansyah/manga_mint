import 'package:equatable/equatable.dart';

abstract class RecomendedEvent extends Equatable {
  const RecomendedEvent();
  @override
  List<Object> get props => [];
}
class FetchRecommended extends RecomendedEvent{}
class RefreshRecommended extends RecomendedEvent{}
