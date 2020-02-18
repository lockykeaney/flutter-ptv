import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'core/simple_bloc_delegate.dart';
import 'pages/homepage.dart';

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
    return BlocProvider<HomepageBloc>(
      create: (context) => HomepageBloc(ptvRepository: ptvRepository),
      child: MaterialApp(home: HomePage()),
    );
  }
}
