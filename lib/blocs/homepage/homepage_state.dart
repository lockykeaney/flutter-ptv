part of 'homepage_bloc.dart';

// Onboarding Parent State
abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class DeparturesLoaded extends HomepageState {
  final List<Departure> departures;

  const DeparturesLoaded({@required this.departures})
      : assert(departures != null);

  @override
  List<Object> get props => [departures];
}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageError extends HomepageState {}
