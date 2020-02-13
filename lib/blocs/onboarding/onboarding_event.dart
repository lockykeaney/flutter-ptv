part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class FetchRoutes extends OnboardingEvent {
  List<Object> get props => [];
}

// class SaveRouteId extends OnboardingEvent {
//   final int routeId;

//   const SaveRouteId({@required this.routeId}) : assert(routeId != null);

//   @override
//   print(routeId);
// }

class FetchStops extends OnboardingEvent {
  final int routeId;

  const FetchStops({@required this.routeId}) : assert(routeId != null);

  @override
  List<Object> get props => [routeId];
}

class FetchDepartures extends OnboardingEvent {
  final int routeId;
  final int stopId;

  const FetchDepartures({@required this.routeId, @required this.stopId})
      : assert(routeId != null, stopId != null);

  @override
  List<Object> get props => [routeId, stopId];
}
