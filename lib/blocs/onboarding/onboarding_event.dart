part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnboardingStatus extends OnboardingEvent {
  List<Object> get props => [];
}

// Routes
class FetchRoutes extends OnboardingEvent {
  List<Object> get props => [];
}

class SelectRoute extends OnboardingEvent {
  final RouteModel selectedRoute;
  const SelectRoute({@required this.selectedRoute})
      : assert(selectedRoute != null);
  @override
  List<Object> get props => [selectedRoute];
}

// Stops
class FetchStops extends OnboardingEvent {
  final int routeId;
  const FetchStops({@required this.routeId}) : assert(routeId != null);
  @override
  List<Object> get props => [routeId];
}

class SelectStop extends OnboardingEvent {
  final RouteModel selectedStop;
  const SelectStop({@required this.selectedStop})
      : assert(selectedStop != null);
  @override
  List<Object> get props => [selectedStop];
}
