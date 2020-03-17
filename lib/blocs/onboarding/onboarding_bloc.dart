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
  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is FetchRoutes) {
      yield OnboardingLoading();
      try {
        print("fetch routes event");
        final List<RouteModel> routes = await ptvRepository.fetchRoutes();
        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is AddRouteInformation) {
      // Update the Main state of Journey
      print(event.route.routeName);
      yield Journey(route: event.route);
    }
    if (event is FetchStops) {
      try {
        final List<StopModel> stops =
            await ptvRepository.fetchStopsOnRoute(event.routeId);
        yield StopsLoaded(stops: stops);
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is OnboardingStepThree) {
      try {
        yield DirectionSelect();
      } catch (_) {
        yield OnboardingError();
      }
    }
    if (event is OnboardingConfirmation) {
      try {
        yield DirectionSelect();
      } catch (_) {
        yield OnboardingError();
      }
    }
  }
}
