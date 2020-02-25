import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ptv/models/route_model.dart';
import 'package:ptv/models/stop_model.dart';

import '../blocs/blocs.dart';
import '../repositories/repositories.dart';

class OnBoardingProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PtvRepository ptvRepository = PtvRepository(
      ptvApiClient: PtvApiClient(
        httpClient: http.Client(),
      ),
    );

    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(ptvRepository: ptvRepository),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Train Routes"),
        ),
        body: SafeArea(child: OnboardingScreenOne()),
      ),
    );
  }
}

// TRYING WITH A STATEFUL WIDGET ======================================
class OnboardingScreenOne extends StatefulWidget {
  const OnboardingScreenOne({Key key}) : super(key: key);

  @override
  _OnboardingScreenOneState createState() => _OnboardingScreenOneState();
}

class _OnboardingScreenOneState extends State<OnboardingScreenOne> {
  RouteModel _route;

  void selectRoutes(route) {
    setState(() {
      _route = route;
    });
    print(_route.routeId);
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
  }

  Widget build(BuildContext context) {
    return Center(
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
              separatorBuilder: (BuildContext context, int index) => Divider(),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Text(_trainRoutes[index].routeName),
                  onTap: () => selectRoutes(_trainRoutes[index]),
                );
              },
            );
          }

          if (state is OnboardingError) {
            return Center(child: Text('Error'));
          }
          return Container();
        },
      ),
    );
  }
}

// TRYING WITH A STATELESS WIDGET ======================================
class Onboarding extends StatelessWidget {
  const Onboarding({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Routes"),
      ),
      body: Container(
        child: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) {},
          child: BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state is OnboardingLoading) {
                return Center(child: CircularProgressIndicator());
              }

              if (state is RoutesLoaded) {
                final _trainRoutes =
                    state.routes.where((i) => i.routeType == 0).toList();
                return RoutesList(trainRoutes: _trainRoutes);
              }

              if (state is StopsLoaded) {
                final _routeStops = state.stops;
                return StopsList(routeStops: _routeStops);
              }

              if (state is DirectionSelect) {
                return Center(
                  child: Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text('Towards City'),
                      ),
                      RaisedButton(
                        child: Text('Away From City'),
                      ),
                    ],
                  ),
                );
              }

              if (state is OnboardingConfirmation) {
                return Center(
                  child: Text('Confirm'),
                );
              }

              if (state is OnboardingError) {
                return Center(child: Text('Error'));
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class StopsList extends StatelessWidget {
  const StopsList({
    Key key,
    @required List<StopModel> routeStops,
  })  : _routeStops = routeStops,
        super(key: key);

  final List<StopModel> _routeStops;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _routeStops.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            child: Text(_routeStops[index].stopName),
            onTap: () => BlocProvider.of<OnboardingBloc>(context)
                .add(OnboardingStepThree(stop: _routeStops[index])));
      },
    );
  }
}

class RoutesList extends StatelessWidget {
  const RoutesList({
    Key key,
    @required List<RouteModel> trainRoutes,
  })  : _trainRoutes = trainRoutes,
        super(key: key);

  final List<RouteModel> _trainRoutes;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _trainRoutes.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            child: Text(_trainRoutes[index].routeName),
            onTap: () => BlocProvider.of<OnboardingBloc>(context)
                .add(FetchStops(routeId: _trainRoutes[index].routeId)));
      },
    );
  }
}
