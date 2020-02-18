part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  const HomepageEvent();
}

class FetchDepartures extends HomepageEvent {
  List<Object> get props => [];
}
