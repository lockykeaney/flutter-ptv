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
  final RouteModel route;

  const Journey({@required this.route}) : assert(route != null);

  @override
  List<Object> get props => [route];
}

// Routes State
class RoutesLoaded extends OnboardingState {
  final List<RouteModel> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

// Stops State
class StopsLoaded extends OnboardingState {
  final List<StopModel> stops;

  const StopsLoaded({@required this.stops}) : assert(stops != null);

  @override
  List<Object> get props => [stops];
}

class DirectionSelect extends OnboardingState {
  @override
  List<Object> get props => [];
}
