import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptv/models/route_model.dart';
import 'package:ptv/models/stop_model.dart';

import '../blocs/blocs.dart';

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
  int _direction;
  bool disabledButton = true;

  void _nextPage() async {
    if (_route != null) {
      BlocProvider.of<OnboardingBloc>(context)
          .add(FetchStops(routeId: _route.routeId));
    }
    if (_route != null && _stop != null) {}
  }

  _selectRoute(route) {
    setState(() {
      _route = route;
    });
  }

  _selectStop(stop) {
    setState(() {
      _stop = stop;
    });
  }

  String directionOfJourney(direction) {
    switch (direction) {
      case 1:
        return 'Towards City';
      case 2:
        return 'Away From City';
    }
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  SelectionItem(
                      placeholder: 'Train Line',
                      item: _route != null ? _route.routeName : null),
                  SelectionItem(
                      placeholder: 'Station',
                      item: _stop != null ? _stop.stopName : null),
                  SelectionItem(
                    placeholder: 'Direction',
                    item: _direction != null
                        ? directionOfJourney(_direction)
                        : null,
                  ),
                ],
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
                  List<RouteModel> _filtered = state.routes
                      .where((item) => item.routeType == 0)
                      .toList();
                  return OnboardingSelect(
                    list: _filtered,
                    selectFunc: _selectRoute,
                    selection: _route,
                    mode: 'routes',
                  );
                }

                if (state is StopsLoaded) {
                  return OnboardingSelect(
                    list: state.stops,
                    selectFunc: _selectStop,
                    selection: _stop,
                    mode: 'stops',
                  );
                }

                if (state is OnboardingError) {
                  return Center(child: Text('Error'));
                }
                return Container();
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
                  onPressed: disabledButton ? _nextPage : null,
                  disabledColor: Colors.red,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    dynamic key,
    @required String placeholder,
    @required String item,
  })  : _item = item,
        _placeholder = placeholder,
        super(key: key);

  final String _item;
  final String _placeholder;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _item != null ? 1.0 : 0.5,
      child: Text(
        _item != null ? _item : _placeholder,
      ),
    );
  }
}

class OnboardingSelect extends StatelessWidget {
  const OnboardingSelect(
      {Key key,
      @required List list,
      @required Function selectFunc,
      @required String mode,
      @required dynamic selection})
      : _list = list,
        _selectFunc = selectFunc,
        _mode = mode,
        _selection = selection,
        super(key: key);

  final List _list;
  final Function _selectFunc;
  final String _mode;
  final dynamic _selection;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _selectFunc(_list[index]),
              child: Text(
                _mode == 'routes'
                    ? _list[index].routeName
                    : _list[index].stopName,
                style: TextStyle(
                  color: _selection == _list[index] ? Colors.red : Colors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
