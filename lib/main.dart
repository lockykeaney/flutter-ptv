import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'core/simple_bloc_delegate.dart';
import 'pages/onboarding.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final PtvRepository ptvRepository = PtvRepository(
    ptvApiClient: PtvApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(ptvRepository: ptvRepository));
}

class App extends StatelessWidget {
  final PtvRepository ptvRepository;

  App({Key key, @required this.ptvRepository})
      : assert(ptvRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(ptvRepository: ptvRepository),
      child: MaterialApp(home: HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // Button to nav to onboarding
        child: RaisedButton(
          onPressed: () async {
            BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnBoarding(),
              ),
            );
          },
          child: Text('Add Route'),
        ),
      ),
    );
  }
}


