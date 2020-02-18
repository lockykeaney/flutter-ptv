import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

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
    print(state);

    if (event is FetchDepartures) {
      yield HomepageLoading();
      try {
        final List<Departure> departures =
            await ptvRepository.fetchDeparaturesFromStop();
        print(departures);
        yield DeparturesLoaded(departures: departures);
      } catch (_) {
        yield HomepageError();
      }
    }
  }
}
