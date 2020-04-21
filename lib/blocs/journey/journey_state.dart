part of 'journey_bloc.dart';

abstract class JourneyState extends Equatable {
  const JourneyState();
  @override
  List<Object> get props => [];
}

class JourneysLoaded extends JourneyState {
  final List<JourneyModel> journeys;
  final List<DepartureModel> departures;
  final RouteStatusModel status;
  const JourneysLoaded(
      {@required this.journeys,
      @required this.departures,
      @required this.status})
      : assert(journeys != null),
        assert(departures != null),
        assert(status != null);
  @override
  List<Object> get props => [journeys, departures, status];
}

class JourneysLoadedWithDepartures extends JourneyState {
  final List<CompleteRequest> completeRequests;
  const JourneysLoadedWithDepartures({@required this.completeRequests})
      : assert(completeRequests != null);
  @override
  List<Object> get props => [completeRequests];
}

class JourneyDepartues extends JourneyState {
  final List<DepartureModel> departures;
  final RouteStatusModel status;
  const JourneyDepartues({@required this.departures, this.status})
      : assert(departures != null),
        assert(status != null);
  @override
  List<Object> get props => [departures, status];
}

class NewJourneyAdded extends JourneyState {}

class JourneysInitial extends JourneyState {}

class JourneysLoading extends JourneyState {}

class JourneyError extends JourneyState {}
