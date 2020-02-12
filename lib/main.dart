import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'core/simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final PtvRepository ptvRepository = PtvRepository(
    routesApiClient: RoutesApiClient(
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

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transport App"),
      ),
      body: Center(
        child: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is RoutesLoaded) {
              final _trainRoutes =
                  state.routes.where((i) => i.routeType == 0).toList();

              return ListView.separated(
                itemCount: _trainRoutes.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: Text(_trainRoutes[index].routeName),
                      // onTap: () => print(_trainRoutes[index].routeId)
                      onTap: () => BlocProvider.of<OnboardingBloc>(context)
                          .add(fetchStopsOnRoute(_trainRoutes[index].routeId)),
                      );
                },
              );
            }
            if (state is RoutesEmpty) {
              return Center(child: Text('No Routes'));
            }
            if (state is OnboardingError) {
              return Center(child: Text('Error'));
            }
          },
        ),
      ),
    );
  }
}
