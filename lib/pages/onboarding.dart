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
      body: Container(
        child: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            print('== LISTENER ==');
            if (state is StopsLoaded) {
              print('== STOPS LOADED ==');
            }
          },
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
                        onTap: () => BlocProvider.of<OnboardingBloc>(context)
                            .add(OnboardingStepTwo(route: _trainRoutes[index]))
                        // .add(SaveRouteId(routeId: _trainRoutes[index].routeId))
                        );
                  },
                );
              }

              if (state is StopsLoaded) {
                return ListView.separated(
                  itemCount: state.stops.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Text(state.stops[index].stopName),
                        onTap: () => BlocProvider.of<OnboardingBloc>(context)
                            .add(OnboardingStepThree(direction: 1)));
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
      ),
    );
  }
}

class OnboardingList extends StatelessWidget {
  const OnboardingList({Key key, this.list, this.listKey}) : super(key: key);

  final List<Object> list;
  final String listKey;
  // final onTap;

  @override
  Widget build(BuildContext context) {
    print(listKey);
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child: Text(list[index]),
          // onTap: () => BlocProvider.of<OnboardingBloc>(context)
          //     .add(FetchStops(routeId: _trainRoutes[index].routeId)),
        );
      },
    );
  }
}
