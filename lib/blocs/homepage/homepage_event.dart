part of 'homepage_bloc.dart';

@immutable
abstract class HomepageEvent extends Equatable {
  const HomepageEvent();
}

class FetchAllJourneys extends HomepageEvent {
  List<Object> get props => [];
}

class DefaultJourney extends HomepageEvent {
  List<Object> get props => [];
}

class FetchDepartures extends HomepageEvent {
  List<Object> get props => [];
}

// class AddTestJourney extends HomepageEvent {
//   final StopModel journey;

//   const AddTestJourney({@required this.journey}) : assert(journey != null);

//   @override
//   List<Object> get props => [journey];
// }
