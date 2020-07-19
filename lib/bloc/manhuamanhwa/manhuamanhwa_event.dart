import 'package:equatable/equatable.dart';

abstract class ManhuamanhwaEvent extends Equatable {
  const ManhuamanhwaEvent();
  @override
  List<Object> get props => [];
}
class FetchManhua extends ManhuamanhwaEvent{
  final String endpoint;

  FetchManhua({this.endpoint});
  @override
  List<Object> get props => [endpoint];
}
class FetchManhwa extends ManhuamanhwaEvent{
  final String endpoint;

  FetchManhwa({this.endpoint});
  @override
  List<Object> get props => [endpoint];
}

