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

  runApp(App(journeyRepository: journeyRepository));
}

class App extends StatelessWidget {
  final JourneyRepository journeyRepository;

  App({Key key, @required this.journeyRepository})
      : assert(journeyRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomepageBloc>(
          create: (context) =>
              HomepageBloc(journeyRepository: journeyRepository),
        ),
        BlocProvider<JourneyBloc>(
          create: (context) =>
              JourneyBloc(journeyRepository: journeyRepository),
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
          home: HomePage()),
    );
  }
}
