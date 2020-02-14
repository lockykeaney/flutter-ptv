import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/blocs.dart';

import 'onboarding.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        // Button to nav to onboarding
        child: RaisedButton(
          onPressed: () async {
            BlocProvider.of<OnboardingBloc>(context).add(OnboardingStepOne());
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnBoarding(),
              ),
            );
          },
          child: Text('Add Route'),
        ),
      ),
    );
  }
}
