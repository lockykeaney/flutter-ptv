import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';

part 'journeys_event.dart';
part 'journeys_state.dart';

class JourneysBloc extends Bloc<JourneysEvent, JourneysState> {
  final PtvRepository ptvRepository;

  JourneysBloc({@required this.ptvRepository}) : assert(ptvRepository != null);

  @override
  JourneysState get initialState => JourneysInitial();

  @override
  Stream<JourneysState> mapEventToState(
    JourneysEvent event,
  ) async* {
    if (event is AddJourney) {
      print(event.journey);
    }
  }
}
