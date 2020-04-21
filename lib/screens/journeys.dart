import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/models.dart';
import '../blocs/blocs.dart';
import 'onboarding/onboarding.dart';

class Journeys extends StatefulWidget {
  Journeys({Key key}) : super(key: key);

  static const String routeName = '/Journeys';

  @override
  _JourneysState createState() => _JourneysState();
}

class _JourneysState extends State<Journeys> with TickerProviderStateMixin {
  PageController _controller;
  int currentPage = 0;
  // bool lastPage = false;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: currentPage,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String directionOfJourney(direction) {
    switch (direction) {
      case 1:
        return 'Towards City';
      case 2:
        return 'Away From City';
    }
  }

  List<Color> colors = [Colors.blue, Colors.red, Colors.green];

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JourneyBloc>(context).add(FetchJourneys());
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  color: Colors.white,
                  iconSize: 50.0,
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.pushNamed(context, Onboarding.routeName);
                  },
                ),
                IconButton(
                  color: Colors.white,
                  iconSize: 50.0,
                  icon: Icon(Icons.warning),
                  onPressed: () {
                    print('TAP');
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<JourneyBloc, JourneyState>(
                builder: (context, state) {
                  if (state is JourneysLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ));
                  }
                  if (state is JourneysLoadedWithDepartures) {
                    if (state.completeRequests.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('No Journeys yet. Add Button'),
                            IconButton(
                              color: Colors.white,
                              iconSize: 100.0,
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, Onboarding.routeName);
                              },
                            ),
                          ],
                        ),
                      );
                    } else {
                      return PageView.builder(
                        itemCount: state.completeRequests.length,
                        itemBuilder: (context, index) {
                          final obj = state.completeRequests[index];
                          return Container(
                            color: colors[index],
                            padding: EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      obj.journey.journeyName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 32.0,
                                      ),
                                    ),
                                    Text(
                                      '${obj.journey.stopName}',
                                      style: TextStyle(
                                        fontSize: 28.0,
                                      ),
                                    ),
                                    Text(
                                      directionOfJourney(obj.journey.direction),
                                      style: TextStyle(
                                        fontSize: 28.0,
                                      ),
                                    ),
                                    DepartureTime(
                                      departures: obj.departures,
                                    ),
                                    Text(obj.status.description),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DepartureTime extends StatefulWidget {
  final List<DepartureModel> departures;

  const DepartureTime({Key key, @required this.departures}) : super(key: key);

  @override
  _DepartureTimeState createState() => _DepartureTimeState();
}

class _DepartureTimeState extends State<DepartureTime> {
  String nextTrain;
  List<String> trainsAfter;
  final thisInstant = new DateTime.now();

  @override
  @mustCallSuper
  void initState() {
    super.initState();
    final _upcoming = widget.departures
        .where((i) => DateTime.parse(i.scheduledDeparture).isAfter(thisInstant))
        .toList();
    setState(() {
      nextTrain = _upcoming[0].scheduledDeparture;
      trainsAfter = [
        _upcoming[1].scheduledDeparture,
        _upcoming[2].scheduledDeparture
      ];
    });
  }

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NextTrainDisplay(
          nextTrain: nextTrain,
          thisInstant: thisInstant,
        ),
        // TrainsAfterDisplay(
        //   trainsAfter: trainsAfter,
        //   thisInstant: thisInstant,
        // )
      ],
    );
  }
}

String timeUntilNextTrain(departure) {
  final thisInstant = new DateTime.now();
  Duration difference =
      DateTime.parse(departure).toLocal().difference(thisInstant);
  return difference.inMinutes.toString();
}

String parseToTime(date) {
  return DateFormat('h:mm').format(date);
}

class NextTrainDisplay extends StatelessWidget {
  const NextTrainDisplay(
      {Key key, @required this.nextTrain, @required this.thisInstant})
      : super(key: key);

  final String nextTrain;
  final DateTime thisInstant;

  final double _baseFontSize = 24.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${parseToTime(DateTime.parse(nextTrain).toLocal())}',
                style: TextStyle(
                  fontSize: _baseFontSize * 3,
                ),
              ),
              Text(
                '${timeUntilNextTrain(nextTrain)}',
                style: TextStyle(
                  fontSize: _baseFontSize * 10,
                  height: 0.9,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Minutes',
                style: TextStyle(
                  fontSize: _baseFontSize * 1.5,
                  height: 0.2,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class TrainsAfterDisplay extends StatelessWidget {
  const TrainsAfterDisplay(
      {Key key, @required this.trainsAfter, @required this.thisInstant})
      : super(key: key);

  final List<String> trainsAfter;
  final DateTime thisInstant;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: trainsAfter.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('+${timeUntilNextTrain(trainsAfter[index])}m'),
              Text(
                '${parseToTime(DateTime.parse(trainsAfter[index]).toLocal())}',
              )
            ],
          );
        },
      ),
    );
  }
}

// return AnimatedBuilder(
//   animation: _controller,
//   builder: (context, child) {
//     var page = journeys[index];
//     var delta;
//     var y = 1.0;

//     if (_controller.position.haveDimensions) {
//       delta = _controller.page - index;
//       y = 1 - delta.abs().clamp(0.0, 1.0);
//     }

//   },
// );
