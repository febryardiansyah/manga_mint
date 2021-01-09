part of 'manhua_bloc.dart';

@immutable
abstract class ManhuaEvent  extends Equatable{
  @override
  List<Object> get props => [];
}
class InitialFetchManhua extends ManhuaEvent{}
class FetchManhua extends ManhuaEvent{}
