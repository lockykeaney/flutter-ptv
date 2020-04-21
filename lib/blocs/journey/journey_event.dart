part of 'journey_bloc.dart';

@immutable
abstract class JourneysEvent extends Equatable {
  const JourneysEvent();
}

class FetchJourneys extends JourneysEvent {
  List<Object> get props => [];
}

class FetchJourneyDepatures extends JourneysEvent {
  final int routeId;
  final int stopId;
  const FetchJourneyDepatures({@required this.routeId, @required this.stopId})
      : assert(routeId != null),
        assert(stopId != null);
  @override
  List<Object> get props => [routeId, stopId];
}

class AddJourney extends JourneysEvent {
  final JourneyModel journey;
  const AddJourney({@required this.journey}) : assert(journey != null);
  @override
  List<Object> get props => [journey];
}
