part of 'homepage_bloc.dart';

// Onboarding Parent State
abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class DefaultJourneyLoaded extends HomepageState {
  final JourneyModel journey;
  final List<DepartureModel> departures;

  const DefaultJourneyLoaded(
      {@required this.journey, @required this.departures})
      : assert(journey != null),
        assert(departures != null);

  @override
  List<Object> get props => [journey, departures];
}

class DeparturesLoaded extends HomepageState {
  final List<DepartureModel> departures;

  const DeparturesLoaded({@required this.departures})
      : assert(departures != null);

  @override
  List<Object> get props => [departures];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageError extends HomepageState {}
