import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

import 'screens.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var thisInstant = new DateTime.now();

    // BlocProvider.of<HomepageBloc>(context).add(FetchDepartures());
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
                final _upcoming = state.departures
                    .where((i) => DateTime.parse(i.scheduledDeparture)
                        .isAfter(thisInstant))
                    .toList();
                Duration difference =
                    DateTime.parse(_upcoming[0].scheduledDeparture)
                        .difference(thisInstant);
                print('differene in minutes: ');
                print(difference.inMinutes);
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
                      Text(state.departures[0].scheduledDeparture)
                    ],
                  );
                }

                if (state is DeparturesLoaded) {
                  // final _departures = state.departures.where((i) => i <= 5).toList();
                  return ListView.separated(
                    itemCount: state.departures.length,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(),
                    itemBuilder: (BuildContext context, int index) {
                      return Center(
                        child: Text(state.departures[index].scheduledDeparture),
                      );
                    },
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
