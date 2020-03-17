import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'core/simple_bloc_delegate.dart';
import 'screens/screens.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final JourneyRepository journeyRepository = JourneyRepository();

  final PtvRepository ptvRepository = PtvRepository(
    ptvApiClient: PtvApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(
    App(
      journeyRepository: journeyRepository,
      ptvRepository: ptvRepository,
    ),
  );
}

class App extends StatelessWidget {
  final JourneyRepository journeyRepository;
  final PtvRepository ptvRepository;

  App({Key key, @required this.journeyRepository, @required this.ptvRepository})
      : assert(journeyRepository != null),
        assert(ptvRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<JourneyBloc>(
          create: (context) => JourneyBloc(
              journeyRepository: journeyRepository,
              ptvRepository: ptvRepository),
        )
      ],
      child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: Colors.white,
                  displayColor: Colors.white,
                ),
          ),
          home: Journeys()),
    );
  }
}
