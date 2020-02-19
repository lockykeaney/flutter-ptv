import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptv/models/models.dart';
import 'package:intl/intl.dart';

import '../blocs/blocs.dart';

import 'screens.dart';

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

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomepageBloc>(context).add(DefaultJourney());
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OnBoardingProvider(),
                ),
              );
            },
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: BlocListener<HomepageBloc, HomepageState>(
            listener: (context, state) {
              if (state is DefaultJourneyLoaded) {
                print(state.journey);
              }
            },
            child: BlocBuilder<HomepageBloc, HomepageState>(
              builder: (context, state) {
                if (state is HomepageLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (state is DefaultJourneyLoaded) {
                  return Column(
                    children: <Widget>[
                      Text(state.journey.journeyName),
                      DepartureTime(
                        departures: state.departures,
                      ),
                      Text('${state.journey.stopName}'),
                      Text(directionOfJourney(state.journey.direction))
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
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

  String timeUntilNextTrain(departure) {
    Duration difference =
        DateTime.parse(departure).toLocal().difference(thisInstant);
    return difference.inMinutes.toString();
  }

  String parseToTime(date) {
    return DateFormat('h:mm').format(date);
  }

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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Text('${timeUntilNextTrain(nextTrain)} minutes'),
          Text('${parseToTime(DateTime.parse(nextTrain).toLocal())}'),
          Row(
            children: <Widget>[
              Text('+${timeUntilNextTrain(trainsAfter[0])} mins'),
              Text('+${timeUntilNextTrain(trainsAfter[1])} mins'),
            ],
          )
        ],
      ),
    );
  }
}
