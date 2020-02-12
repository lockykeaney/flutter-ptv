import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

// EVENT
abstract class RoutesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRoutes extends RoutesEvent {}

// =====
// STATE
abstract class RoutesState extends Equatable {
  const RoutesState();

  @override
  List<Object> get props => [];
}

class RoutesEmpty extends RoutesState {}

class RoutesLoading extends RoutesState {}

class RoutesLoaded extends RoutesState {
  final List<Route> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

class RoutesError extends RoutesState {}

// =====
// BLOC

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final RoutesRepository routesRepository;

  RoutesBloc({@required this.routesRepository})
      : assert(routesRepository != null);

  @override
  RoutesState get initialState => RoutesEmpty();

  @override
  Stream<RoutesState> mapEventToState(
    RoutesEvent event,
  ) async* {
    if (event is FetchRoutes) {
      yield RoutesLoading();
      try {
        final List<Route> routes = await routesRepository.getRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield RoutesError();
      }
    }
  }
}
