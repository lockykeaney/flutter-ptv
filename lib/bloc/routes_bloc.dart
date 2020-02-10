import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'routes_event.dart';
part 'routes_state.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  @override
  RoutesState get initialState => RoutesInitial();

  @override
  Stream<RoutesState> mapEventToState(
    RoutesEvent event,
  ) async* {
    // TODO: Add Logic
  }
}
