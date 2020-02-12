import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

// EVENT
// abstract class StopsEvent extends Equatable {
//   @override
//   List<Object> get props => [];
// }

// class FetchStops extends StopsEvent {}
abstract class StopsEvent extends Equatable {
  const StopsEvent();
}

class FetchStops extends StopsEvent {
  final int routeId;

  const FetchStops({@required this.routeId}) : assert(routeId != null);

  @override
  List<Object> get props => [routeId];
}

// =====
// STATE
abstract class StopsState extends Equatable {
  const StopsState();

  @override
  List<Object> get props => [];
}

class StopsEmpty extends StopsState {}

class StopsLoading extends StopsState {}

class StopsLoaded extends StopsState {
  final List<Stop> stops;

  const StopsLoaded({@required this.stops}) : assert(stops != null);

  @override
  List<Object> get props => [stops];
}

class StopsError extends StopsState {}

// =====
// BLOC

class StopsBloc extends Bloc<StopsEvent, StopsState> {
  final RoutesRepository routesRepository;

  StopsBloc({@required this.routesRepository})
      : assert(routesRepository != null);

  @override
  StopsState get initialState => StopsEmpty();

  @override
  Stream<StopsState> mapEventToState(
    StopsEvent event,
  ) async* {
    print(event);
    if (event is FetchStops) {
      yield StopsLoading();
      try {
        final List<Stop> stops =
            await routesRepository.fetchStopsOnRoute(event.routeId);
        yield StopsLoaded(stops: stops);
      } catch (_) {
        yield StopsError();
      }
    }
  }
}
