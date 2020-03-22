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
  String _searchValue = "";
  bool disabledButton = true;

  final onboardingTextController = TextEditingController();

  void _nextPage() async {
    if (_route != null) {
      BlocProvider.of<OnboardingBloc>(context)
          .add(FetchStops(routeId: _route.routeId));
      onboardingTextController.clear();
    }
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

  _setSearchValue() {
    setState(() {
      _searchValue = onboardingTextController.text;
    });
  }

  _displayJourneyInformation() {
    if (_route != null) {
      return _route.routeName;
    }
    if (_route != null && _stop != null) {
      return '${_stop.stopName} on the ${_route.routeName} line';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    onboardingTextController.addListener(_setSearchValue);
    BlocProvider.of<OnboardingBloc>(context).add(FetchRoutes());
  }

  @override
  void dispose() {
    onboardingTextController.dispose();
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
          Text(_displayJourneyInformation()),
          Expanded(
            child: BlocBuilder<OnboardingBloc, OnboardingState>(
              builder: (context, state) {
                if (state is OnboardingLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is RoutesLoaded) {
                  List<RouteModel> _filtered = state.routes
                      .where((item) =>
                          item.routeType == 0 &&
                          _searchValue != '' &&
                          item.routeName.toLowerCase().startsWith(_searchValue))
                      .toList();
                  return OnboardingSelect(
                    onboardingTextController: onboardingTextController,
                    list: _filtered,
                    selectFunc: _selectRoute,
                    nextPage: _nextPage,
                    mode: 'routes',
                  );
                }

                if (state is StopsLoaded) {
                  List<StopModel> _filtered = state.stops
                      .where((item) =>
                          item.routeType == 0 &&
                          _searchValue != '' &&
                          item.stopName.toLowerCase().contains(_searchValue))
                      .toList();
                  return OnboardingSelect(
                    onboardingTextController: onboardingTextController,
                    list: _filtered,
                    selectFunc: _selectStop,
                    nextPage: _nextPage,
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

class OnboardingSelect extends StatelessWidget {
  const OnboardingSelect({
    Key key,
    @required this.onboardingTextController,
    @required List list,
    @required Function selectFunc,
    @required Function nextPage,
    @required String mode,
  })  : _list = list,
        _selectFunc = selectFunc,
        _nextPage = nextPage,
        _mode = mode,
        super(key: key);

  final TextEditingController onboardingTextController;
  final List _list;
  final Function _selectFunc;
  final Function _nextPage;
  final String _mode;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              TextField(
                controller: onboardingTextController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: InputBorder.none,
                  hintText: 'Enter a search term',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _list.length > 0
                      ? _mode == 'routes'
                          ? _list[0].routeName
                          : _list[0].stopName
                      : '',
                ),
              ),
            ],
          ),
          Flexible(
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
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
