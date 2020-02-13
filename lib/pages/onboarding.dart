import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/onboarding/onboarding_bloc.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Routes"),
      ),
      body: Center(
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
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: Text(_trainRoutes[index].routeName),
                      // onTap: () => print(_trainRoutes[index].routeId)
                      onTap: () => BlocProvider.of<OnboardingBloc>(context)
                          .add(FetchStops(routeId: _trainRoutes[index].routeId)),
                      );
                },
              );
            }
            if (state is StopsLoaded) {
              // final _routeStops =
              //     state.st.where((i) => i.routeType == 0).toList();

              return ListView.separated(
                itemCount: state.stops.length,
                separatorBuilder: (BuildContext context, int index) =>
                    Divider(),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: Text(state.stops[index].stopName),
                      onTap: () => print(state.stops[index].stopId)
                      );
                },
              );
            }
            if (state is RoutesEmpty) {
              return Center(child: Text('No Routes'));
            }
            if (state is OnboardingError) {
              return Center(child: Text('Error'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
