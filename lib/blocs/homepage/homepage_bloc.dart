import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ptv/blocs/blocs.dart';
import 'package:ptv/models/journey_model.dart';
import 'package:ptv/models/models.dart';

import 'package:ptv/repositories/repositories.dart';

import 'dart:convert';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final PtvRepository ptvRepository;

  HomepageBloc({@required this.ptvRepository}) : assert(ptvRepository != null);

  @override
  HomepageState get initialState => HomepageInitial();

  @override
  Stream<HomepageState> mapEventToState(
    HomepageEvent event,
  ) async* {
    if (event is DefaultJourney) {
      final JourneyModel journey = JourneyModel(
          id: '1',
          defaultJourney: true,
          routeId: 8,
          routeName: 'Hurstbridge',
          stopId: 1053,
          stopName: 'Dennis',
          direction: 1,
          journeyName: 'To Work');
      final List<DepartureModel> departures = await ptvRepository
          .fetchDeparaturesFromStop(journey.routeId, journey.stopId);
      yield DefaultJourneyLoaded(journey: journey, departures: departures);
    }
    // if (event is FetchDepartures) {
    //   yield HomepageLoading();
    //   try {
    //     final List<DepartureModel> departures =
    //         await ptvRepository.fetchDeparaturesFromStop();
    //     print(departures);
    //     yield DeparturesLoaded(departures: departures);
    //   } catch (_) {
    //     yield HomepageError();
    //   }
    // }
  }
}
