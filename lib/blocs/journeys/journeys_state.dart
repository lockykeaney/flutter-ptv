part of 'journeys_bloc.dart';

abstract class JourneysState extends Equatable {
  const JourneysState();

  @override
  List<Object> get props => [];
}

class JourneysLoaded extends JourneysState {
  final List<JourneyModel> journeys;

  const JourneysLoaded({@required this.journeys}) : assert(journeys != null);

  @override
  List<Object> get props => [journeys];
}

class JourneysInitial extends JourneysState {}

class JourneysLoading extends JourneysState {}

class JourneysError extends JourneysState {}
