import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final RoutesRepository routesRepository;

  OnboardingBloc({@required this.routesRepository})
      : assert(routesRepository != null);

  @override
  OnboardingState get initialState => OnboardingInitial();

  @override
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is FetchRoutes) {
      yield OnboardingLoading();
      try {
        final List<Route> routes = await routesRepository.fetchRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is FetchStops) {
      yield OnboardingLoading();
      try {
        final List<Stop> stops = await routesRepository.fetchStopsOnRoute(event.routeId);
        yield StopsLoaded(stops: stops);
      } catch (_) {
        yield OnboardingError();
      }
    }
  }
}
