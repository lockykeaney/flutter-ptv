import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:ptv/blocs/journey/journey_bloc.dart';
import 'package:ptv/models/journey_model.dart';
import 'package:ptv/models/models.dart';

import 'package:ptv/repositories/repositories.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final JourneyRepository journeyRepository;

  HomepageBloc({@required this.journeyRepository})
      : assert(journeyRepository != null);

  @override
  HomepageState get initialState => HomepageInitial();

  @override
  Stream<HomepageState> mapEventToState(
    HomepageEvent event,
  ) async* {
    if (event is FetchAllJourneys) {
      yield HomepageLoading();
      try {
        final List<JourneyModel> journeys =
            await journeyRepository.fetchJourneys();
        print(journeys);
        yield AllJourneysLoaded(journeys: journeys);
      } catch (_) {
        yield HomepageError();
      }
    }

    // if (event is DefaultJourney) {
    //   yield HomepageLoading();
    //   try {
    //     final JourneyModel journey = JourneyModel(
    //         id: '1',
    //         routeId: 8,
    //         routeName: 'Hurstbridge',
    //         stopId: 1053,
    //         stopName: 'Dennis',
    //         direction: 1,
    //         journeyName: 'To Work');
    //     final List<DepartureModel> departures = await ptvRepository
    //         .fetchDeparaturesFromStop(journey.routeId, journey.stopId);
    //     final RouteStatusModel status =
    //         await ptvRepository.fetchRouteStatus(journey.routeId);
    //     print(status);
    //     yield DefaultJourneyLoaded(
    //         journey: journey, departures: departures, status: status);
    //   } catch (_) {
    //     yield HomepageError();
    //   }
    // }
  }
}
