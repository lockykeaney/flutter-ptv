import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

part 'journey_event.dart';
part 'journey_state.dart';

class JourneyBloc extends Bloc<JourneysEvent, JourneyState> {
  final JourneyRepository journeyRepository;

  JourneyBloc({@required this.journeyRepository})
      : assert(journeyRepository != null);

  @override
  JourneyState get initialState => JourneysInitial();

  @override
  Stream<JourneyState> mapEventToState(
    JourneysEvent event,
  ) async* {
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
