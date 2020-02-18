import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

import 'onboarding.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomepageBloc>(context).add(FetchDepartures());
    return Container(
      child: Center(
        child: BlocListener<HomepageBloc, HomepageState>(
          listener: (context, state) {
            print('== LISTENER ==');
            if (state is FetchDepartures) {
              print('== STOPS LOADED ==');
            }
          },
          child: BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is HomepageLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is DeparturesLoaded) {
                // final _departures = state.departures.where((i) => i <= 5).toList();
                return ListView.separated(
                  itemCount: state.departures.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Text(state.departures[index].scheduledDeparture),
                        onTap: () =>
                            print(state.departures[index].scheduledDeparture));
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
      //             child: RaisedButton(
      // onPressed: () async {
      //   // BlocProvider.of<OnboardingBloc>(context).add(OnboardingStepOne());
      //   await Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => OnBoarding(),
      //     ),
      //   );
      // },
      // child: Text('Add Route'),
    );
  }
}

// Button to nav to onboarding
// child: RaisedButton(
//   onPressed: () async {
//     // BlocProvider.of<OnboardingBloc>(context).add(OnboardingStepOne());
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => OnBoarding(),
//       ),
//     );
//   },
//   child: Text('Add Route'),
