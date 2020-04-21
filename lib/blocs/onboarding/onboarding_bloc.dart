import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final PtvRepository ptvRepository;
  final JourneyRepository journeyRepository;

  OnboardingBloc({@required this.ptvRepository, this.journeyRepository})
      : assert(ptvRepository != null);

  @override
  OnboardingState get initialState => OnboardingInitial();

  @override
  Stream<OnboardingState> mapEventToState(OnboardingEvent event) async* {
    // get methods (API)
    if (event is OnboardingStatus) {
      yield OnboardingLoading();
      try {
        yield OnboardingNewJourney();
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is FetchRoutes) {
      yield OnboardingLoading();
      try {
        final List<RouteModel> routes = await ptvRepository.fetchRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is FetchStops) {
      yield OnboardingLoading();
      try {
        final List<StopModel> stops =
            await ptvRepository.fetchStopsOnRoute(event.routeId);
        yield StopsLoaded(stops: stops);
      } catch (_) {
        yield OnboardingError();
      }
    }

    // set methods (state)
    if (event is SelectRoute) {
      try {
        // print(event.selectedRoute.routeName);
        OnboardingNewJourney(selectedRoute: event.selectedRoute);
        final List<RouteModel> routes = await ptvRepository.fetchRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield OnboardingError();
      }
    }
  }
}
