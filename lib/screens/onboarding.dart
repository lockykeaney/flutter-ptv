import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:ptv/models/route_model.dart';
import 'package:ptv/models/stop_model.dart';

import '../blocs/blocs.dart';
import '../repositories/repositories.dart';

// class OnBoardingProvider extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final PtvRepository ptvRepository = PtvRepository(
//       ptvApiClient: PtvApiClient(
//         httpClient: http.Client(),
//       ),
//     );

//     return BlocProvider<OnboardingBloc>(
//       create: (context) => OnboardingBloc(ptvRepository: ptvRepository),
//       child: Onboarding(),
//     );
//   }
// }

// TRYING WITH A STATEFUL WIDGET ======================================
class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  static const String routeName = '/Onboarding';

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  RouteModel _route;
  StopModel _stop;
  List<RouteModel> _filteredRoutes = new List();

  final routesTextController = TextEditingController();

  void _nextPage() async {
    BlocProvider.of<OnboardingBloc>(context)
        .add(FetchStops(routeId: _route.routeId));
  }

  void selectRoute(route) {
    setState(() {
      _route = route;
    });
  }

  void selectStop(stop) {
    setState(() {
      _stop = stop;
    });
  }

  void setInitialRoutes(routes) {
    setState(() {
      _filteredRoutes = routes;
    });
  }

  _filterRoutes() {
    print(
      _filteredRoutes
          .where((i) => i.routeName.contains(routesTextController.text))
          .toList(),
    );
    setState(() {
      _filteredRoutes = _filteredRoutes
          .where((i) => i.routeName.contains(routesTextController.text))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    routesTextController.addListener(_filterRoutes);
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
  }

  @override
  void dispose() {
    routesTextController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Increment',
        child: Icon(Icons.arrow_forward),
      ),
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                color: Colors.black,
                iconSize: 50.0,
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is RoutesLoaded) {
                  final _trainRoutes =
                      state.routes.where((i) => i.routeType == 0).toList();
                  setInitialRoutes(_trainRoutes);
                  return Column(
                    children: <Widget>[
                      TextField(
                        controller: routesTextController,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: InputBorder.none,
                            hintText: 'Enter a search term'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _filteredRoutes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(
                              _filteredRoutes[index].routeName,
                              style: TextStyle(color: Colors.red),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }

                if (state is StopsLoaded) {
                  final _routeStops = state.stops;
                  return ListView.separated(
                    itemCount: _routeStops.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      if (_stop != null) {
                        if (_stop.stopId == _routeStops[index].stopId) {
                          return GestureDetector(
                            child: Text(
                              _routeStops[index].stopName,
                              style: TextStyle(color: Colors.red),
                            ),
                            onTap: () => selectStop(_routeStops[index]),
                          );
                        }
                      }
                      return GestureDetector(
                        child: Text(
                          _routeStops[index].stopName,
                          style: TextStyle(color: Colors.black),
                        ),
                        onTap: () => selectStop(_routeStops[index]),
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
          ),
        ],
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

// class RoutesList extends StatelessWidget {
//   const RoutesList({
//     Key key,
//     @required List<RouteModel> trainRoutes,
//   })  : _trainRoutes = trainRoutes,
//         super(key: key);

//   final List<RouteModel> _trainRoutes;

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//       itemCount: _trainRoutes.length,
//       separatorBuilder: (BuildContext context, int index) => Divider(),
//       itemBuilder: (BuildContext context, int index) {
//         return GestureDetector(
//             child: Text(_trainRoutes[index].routeName),
//             onTap: () => BlocProvider.of<OnboardingBloc>(context)
//                 .add(FetchStops(routeId: _trainRoutes[index].routeId)));
//       },
//     );
//   }
// }
