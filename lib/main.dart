import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'simple_bloc_delegate.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final AllRoutesRepository allRoutesRepository = AllRoutesRepository(
    routesApiClient: RoutesApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(allRoutesRepository: allRoutesRepository));
}

class App extends StatelessWidget {
  final AllRoutesRepository allRoutesRepository;

  App({Key key, @required this.allRoutesRepository})
      : assert(allRoutesRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<RoutesBloc>(
        create: (context) =>
            RoutesBloc(allRoutesRepository: allRoutesRepository),
        child: OnBoarding(),
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
        child: BlocListener(
          bloc: BlocProvider.of<RoutesBloc>(context),
          listener: (context, state) {
            print("Inside Listener");
            if (state is RoutesLoaded) {
              print("Loaded: ${state.routes}");
            }
          },
          child: BlocBuilder<RoutesBloc, RoutesState>(
            builder: (context, state) {
              if (state is RoutesLoaded) {
                return Center(child: Text('Loaded'));
              }
              if (state is RoutesEmpty) {
                return Center(child: Text('No Routes'));
              }
              if (state is RoutesLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is RoutesError) {
                return Center(child: Text('Error'));
              }
              return Center();
            },
          ),
        ),
      ),
    );
  }
}
