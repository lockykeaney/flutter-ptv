import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ptv/models/route_model.dart';

import '../../blocs/blocs.dart';

class OnboardingRouteSelect extends StatefulWidget {
  OnboardingRouteSelect({Key key}) : super(key: key);

  @override
  _OnboardingRouteSelectState createState() => _OnboardingRouteSelectState();
}

class _OnboardingRouteSelectState extends State<OnboardingRouteSelect> {
  RouteModel _route;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is RoutesLoaded) {
          List<RouteModel> _filtered =
              state.routes.where((item) => item.routeType == 0).toList();
          return Column(children: [
            Expanded(
              child: ListView.builder(
                itemCount: _filtered.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => {
                        setState(() {
                          _route = _filtered[index];
                        })
                      },
                      child: Text(
                        _filtered[index].routeName,
                        style: TextStyle(
                          color: _route == _filtered[index]
                              ? Colors.red
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    child: Text('Next'),
                    onPressed: () => _route != null
                        ? BlocProvider.of<OnboardingBloc>(context).add(
                            SelectRoute(selectedRoute: _route),
                          )
                        : null,
                    // onPressed: disabledButton ? _nextPage : null,
                    disabledColor: Colors.red,
                  ),
                ],
              ),
            )
          ]);
        }

        if (state is OnboardingError) {
          return Center(child: Text('Error'));
        }
        return Container();
      },
    );
  }
}
