import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:ptv/repositories/repositories.dart';
import 'package:ptv/models/models.dart';
import 'package:ptv/blocs/blocs.dart';

class RoutesBloc extends Bloc<RoutesEvent, RoutesState> {
  final AllRoutesRepository allRoutesRepository;

  RoutesBloc({@required this.allRoutesRepository})
      : assert(allRoutesRepository != null);

  @override
  RoutesState get initialState => RoutesEmpty();

  @override
  Stream<RoutesState> mapEventToState(
    RoutesEvent event,
  ) async* {
    print('routes');
    if (event is FetchRoutes) {
      yield RoutesLoading();
      try {
        final List<SingleRoute> routes = await allRoutesRepository.getRoutes();

        yield RoutesLoaded(routes: routes);
      } catch (_) {
        yield RoutesError();
      }
    }
  }
}
