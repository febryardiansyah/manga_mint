import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangamint/models/manhua_manhwa_model.dart';
import 'package:mangamint/repositories/manhua_manhwa_repo.dart';
import 'package:meta/meta.dart';

part 'manhua_event.dart';

part 'manhua_state.dart';

class ManhuaBloc extends Bloc<ManhuaEvent, ManhuaState> {
  ManhuaManhwaRepo _manhuaManhwaRepo;

  ManhuaBloc(this._manhuaManhwaRepo) : super(InitialManhuaState());

  bool _hasReachedMax(ManhuaLoadedState state) =>
      state is ManhuaLoadedState && state.hasReachedMax;

  @override
  Stream<ManhuaState> mapEventToState(ManhuaEvent event) async* {
    final currentState = state;
    int page = 1;
    if(event is InitialFetchManhua){}
    if (event is FetchManhua && !_hasReachedMax(currentState)) {
      if (currentState is InitialManhuaState) {
        yield ManhuaLoadingState();
        try {
          List<ManhuaManwaModel> manhuaList = await _manhuaManhwaRepo
              .getManhuaManhwa(page: page, type: 'manhua');
          yield ManhuaLoadedState(
              list: manhuaList, page: page += 1, hasReachedMax: false);
        } catch (e) {
          yield ManhuaFailure(msg: e.toString());
        }
      }

      if (currentState is ManhuaLoadedState) {
        try{
          List<ManhuaManwaModel> list = await _manhuaManhwaRepo.getManhuaManhwa(
            type: 'manhua',
            page: currentState.page,
          );
          yield list.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ManhuaLoadedState(
              list: currentState.list + list,
              page: currentState.page += 1,
              hasReachedMax: false);
        }catch(e){
          yield ManhuaFailure(msg: e.toString());
        }
      }
    }
  }
}
