part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class FetchRoutes extends OnboardingEvent {
  List<Object> get props => [];
}

class FetchStops extends OnboardingEvent {
  final int routeId;

  const FetchStops({@required this.routeId}) : assert(routeId != null);

  @override
  List<Object> get props => [routeId];
}
