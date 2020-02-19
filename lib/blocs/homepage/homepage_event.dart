part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  const HomepageEvent();
}

class DefaultJourney extends HomepageEvent {
  List<Object> get props => [];
}

class FetchDepartures extends HomepageEvent {
  List<Object> get props => [];
}
