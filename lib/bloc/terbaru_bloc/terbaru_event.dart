import 'package:equatable/equatable.dart';

abstract class TerbaruEvent extends Equatable {
  const TerbaruEvent();
  @override
  List<Object> get props => [];
}
class FetchTerbaru extends TerbaruEvent{}
class InitialTerbaruEvent extends TerbaruEvent{}
class RefreshTerbaru extends TerbaruEvent{}
