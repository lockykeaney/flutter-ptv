part of 'journey_bloc.dart';

@immutable
abstract class JourneysEvent extends Equatable {
  const JourneysEvent();
}

class FetchJourneys extends JourneysEvent {
  List<Object> get props => [];
}

class AddJourney extends JourneysEvent {
  final JourneyModel journey;

  const AddJourney({@required this.journey}) : assert(journey != null);

  @override
  List<Object> get props => [journey];
}
