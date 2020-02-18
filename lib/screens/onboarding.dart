import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import '../blocs/blocs.dart';
import '../repositories/repositories.dart';

class OnBoarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PtvRepository ptvRepository = PtvRepository(
      ptvApiClient: PtvApiClient(
        httpClient: http.Client(),
      ),
    );

    return BlocProvider<OnboardingBloc>(
      create: (context) => OnboardingBloc(ptvRepository: ptvRepository),
      child: OnboardingInner(),
    );
  }
}

class OnboardingInner extends StatelessWidget {
  const OnboardingInner({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(OnboardingStepOne());
    return Scaffold(
      appBar: AppBar(
        title: Text("Train Routes"),
      ),
      body: Container(
        child: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            print('== LISTENER ==');
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
