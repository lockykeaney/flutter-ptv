import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ptv/models/models.dart';

// Onboarding Parent State
abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}
class OnboardingLoading extends OnboardingState {}
class OnboardingError extends OnboardingState {}

// Routes State
class RoutesEmpty extends OnboardingState {}

class RoutesLoaded extends OnboardingState {
  final List<Route> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

// Stops State
class StopsEmpty extends OnboardingState {}

class StopsLoaded extends OnboardingState {
  final List<Stop> stops;

  const StopsLoaded({@required this.stops}) : assert(stops != null);

  @override
  List<Object> get props => [stops];
}


