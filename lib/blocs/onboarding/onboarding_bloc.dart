import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PtvRepository ptvRepository;

  OnboardingBloc({@required this.ptvRepository})
      : assert(ptvRepository != null);

  @override
  OnboardingState get initialState => OnboardingInitial();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    print(state);
    if (event is FetchRoutes) {
      yield OnboardingLoading();
      try {
        final List<Route> routes = await ptvRepository.fetchRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is FetchStops) {
      yield OnboardingLoading();
      try {
        print(event.routeId);
        final List<Stop> stops =
            await ptvRepository.fetchStopsOnRoute(event.routeId);
        yield StopsLoaded(stops: stops);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is FetchDepartures) {
      yield OnboardingLoading();
      try {
        final List<Departure> departures = await ptvRepository
            .fetchDeparaturesFromStop(event.routeId, event.stopId);
        print(departures);
        yield DeparturesLoaded(departures: departures);
      } catch (_) {
        yield OnboardingError();
      }
    }
  }
}
