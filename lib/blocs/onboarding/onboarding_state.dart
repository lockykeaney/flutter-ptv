import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ptv/models/models.dart';

abstract class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

class OnboardingInitial extends OnboardingState {}

class RoutesEmpty extends OnboardingState {}

class RoutesLoading extends OnboardingState {}

class RoutesLoaded extends OnboardingState {
  final List<SingleRoute> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

class RoutesError extends OnboardingState {}
