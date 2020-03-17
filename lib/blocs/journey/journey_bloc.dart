import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptv/models/complete_request.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

part 'journey_event.dart';
part 'journey_state.dart';

class JourneyBloc extends Bloc<JourneysEvent, JourneyState> {
  final JourneyRepository journeyRepository;
  final PtvRepository ptvRepository;

  JourneyBloc({@required this.journeyRepository, @required this.ptvRepository})
      : assert(journeyRepository != null),
        assert(ptvRepository != null);

  @override
  JourneyState get initialState => JourneysInitial();

  @override
  Stream<JourneyState> mapEventToState(
    JourneysEvent event,
  ) async* {
    if (event is FetchJourneys) {
      yield JourneysLoading();
      try {
        final List<JourneyModel> journeys =
            await journeyRepository.fetchJourneys();

        List<CompleteRequest> _completeRequests = new List();
        for (var i = 0; i < journeys.length; i++) {
          final routeId = journeys[i].routeId;
          final stopId = journeys[i].stopId;
          final List<DepartureModel> departures =
              await ptvRepository.fetchDeparaturesFromStop(routeId, stopId);
          final RouteStatusModel status =
              await ptvRepository.fetchRouteStatus(routeId);
          _completeRequests.add(CompleteRequest(
              journey: journeys[i], departures: departures, status: status));
        }

        // Loop array of journeys and return a new object
        yield JourneysLoadedWithDepartures(completeRequests: _completeRequests);
      } catch (_) {
        yield JourneyError();
      }
    }

    if (event is FetchJourneyDepatures) {
      try {
        final List<DepartureModel> departures = await ptvRepository
            .fetchDeparaturesFromStop(event.routeId, event.stopId);
        final RouteStatusModel status =
            await ptvRepository.fetchRouteStatus(event.routeId);

        yield JourneyDepartues(departures: departures, status: status);
      } catch (_) {
        yield JourneyError();
      }
    }

    if (event is AddJourney) {
      print(event.journey);
      try {
        await journeyRepository.insertJourney(event.journey);
        // yield NewJourneyAdded();
        final List<JourneyModel> journeys =
            await journeyRepository.fetchJourneys();
        yield JourneysLoaded(journeys: journeys);
      } catch (_) {
        print(_);
        yield JourneyError();
      }
    }
  }
}
