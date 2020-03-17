part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class FetchRoutes extends OnboardingEvent {
  List<Object> get props => [];
}

class AddRouteInformation extends OnboardingEvent {
  final RouteModel route;

  const AddRouteInformation({@required this.route}) : assert(route != null);

  @override
  List<Object> get props => [route];
}

class FetchStops extends OnboardingEvent {
  final int routeId;

  const FetchStops({@required this.routeId}) : assert(routeId != null);

  @override
  List<Object> get props => [routeId];
}

class OnboardingStepThree extends OnboardingEvent {
  final StopModel stop;

  const OnboardingStepThree({@required this.stop}) : assert(stop != null);

  @override
  List<Object> get props => [stop];
}

class OnboardingConfirmation extends OnboardingEvent {
  @override
  List<Object> get props => [];
}
