import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptv/models/models.dart';
import 'package:intl/intl.dart';

import '../blocs/blocs.dart';

import 'screens.dart';

Color mainColor = Color(0xff008CCE);

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  String directionOfJourney(direction) {
    switch (direction) {
      case 1:
        return 'Towards City';
      case 2:
        return 'Away From City';
    }
  }

  // final journeyBloc =  BlocProvider.of<JourneysBloc>(context).add(AddJourney());

  @override
  Widget build(BuildContext context) {
    final JourneyModel journey = JourneyModel(
        routeId: 8,
        routeName: 'Hurstbridge',
        stopId: 1053,
        stopName: 'Dennis',
        direction: 1,
        journeyName: 'To Work');
    BlocProvider.of<HomepageBloc>(context).add(FetchAllJourneys());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<JourneyBloc>(context)
              .add(AddJourney(journey: journey));
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: mainColor,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 40.0,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnBoardingProvider(),
                      ),
                    );
                  },
                ),
                IconButton(
                  padding: EdgeInsets.all(5.0),
                  icon: Icon(
                    Icons.warning,
                    size: 40.0,
                  ),
                  onPressed: () {
                    print("warning alert");
                  },
                )
              ],
            ),
            Container(
              child: BlocListener<JourneyBloc, JourneyState>(
                listener: (context, state) {
                  if (state is NewJourneyAdded) {
                    print("New journey added");
                    print(state);
                  }
                },
                child: BlocBuilder<HomepageBloc, HomepageState>(
                  builder: (context, state) {
                    if (state is HomepageLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is AllJourneysLoaded) {
                      if (state.journeys.length == 0) {
                        return Text('There are no journeys saved');
                      } else {
                        return Text('List Journeys Here');
                      }
                    }
                    if (state is DefaultJourneyLoaded) {
                      return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  state.journey.journeyName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32.0,
                                  ),
                                ),
                                Text(
                                  '${state.journey.stopName}',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                                Text(
                                  directionOfJourney(state.journey.direction),
                                  style: TextStyle(
                                    fontSize: 28.0,
                                  ),
                                ),
                                DepartureTime(
                                  departures: state.departures,
                                ),
                                // Text(state.status.description),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
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
