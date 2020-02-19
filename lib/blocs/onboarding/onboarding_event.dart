part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnboardingStepOne extends OnboardingEvent {
  List<Object> get props => [];
}

class OnboardingStepTwo extends OnboardingEvent {
  final RouteModel route;

  const OnboardingStepTwo({@required this.route}) : assert(route != null);

  @override
  List<Object> get props => [route];
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
