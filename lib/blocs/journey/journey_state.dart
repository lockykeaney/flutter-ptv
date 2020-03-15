part of 'journey_bloc.dart';

abstract class JourneyState extends Equatable {
  const JourneyState();

  @override
  List<Object> get props => [];
}

class JourneysLoaded extends JourneyState {
  final List<JourneyModel> journeys;

  const JourneysLoaded({@required this.journeys}) : assert(journeys != null);

  @override
  List<Object> get props => [journeys];
}

class NewJourneyAdded extends JourneyState {}

class JourneysInitial extends JourneyState {}

class JourneysLoading extends JourneyState {}

class JourneyError extends JourneyState {}
