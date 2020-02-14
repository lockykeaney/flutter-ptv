part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();
}

class OnboardingStepOne extends OnboardingEvent {
  List<Object> get props => [];
}

class OnboardingStepTwo extends OnboardingEvent {
  final Route route;

  const OnboardingStepTwo({@required this.route}) : assert(route != null);

  @override
  List<Object> get props => [route];
}

class OnboardingStepThree extends OnboardingEvent {
  final int direction;

  const OnboardingStepThree({@required this.direction})
      : assert(direction != null);

  @override
  List<Object> get props => [direction];
}
