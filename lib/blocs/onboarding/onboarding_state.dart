part of 'onboarding_bloc.dart';

// Onboarding Parent State
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class OnboardingLoading extends OnboardingState {}

class OnboardingError extends OnboardingState {}

// Main Class
class Journey extends OnboardingState {
  final int routeId;
  final String routeName;

  const Journey({this.routeId, this.routeName})
      : assert(routeId != null, routeName != null);

  @override
  List<Object> get props => [routeId, routeName];
}

// Routes State
class RoutesLoaded extends OnboardingState {
  final List<Route> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

// Stops State
class StopsLoaded extends OnboardingState {
  final List<Stop> stops;

  const StopsLoaded({@required this.stops}) : assert(stops != null);

  @override
  List<Object> get props => [stops];
}

// Departures State

class DirectionSelect extends OnboardingState {
  final int direction;

  const DirectionSelect({@required this.direction}) : assert(direction != null);

  @override
  List<Object> get props => [direction];
}
