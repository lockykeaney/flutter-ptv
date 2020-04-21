import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ptv/models/route_model.dart';
import 'package:ptv/models/stop_model.dart';

import '../../blocs/blocs.dart';

import 'onboarding_routes.dart';

// TRYING WITH A STATEFUL WIDGET ======================================
class Onboarding extends StatefulWidget {
  const Onboarding({Key key}) : super(key: key);

  static const String routeName = '/Onboarding';

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool disabledButton = true;
  PageController _controller;
  int currentPage = 0;

  _incrementPage() {
    setState(() {
      currentPage++;
    });
  }

  _decrementPage() {
    setState(() {
      currentPage--;
    });
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              OnboardingStatusIndicator(),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              children: [
                OnboardingRouteSelect(),
                Container(child: Text('Stations')),
                Container(child: Text('Direction')),
                Container(child: Text('Confirm & 123')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingStatusIndicator extends StatelessWidget {
  const OnboardingStatusIndicator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<OnboardingBloc>(context).add(OnboardingStatus());
    return BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
      if (state is OnboardingNewJourney) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SelectionItem(placeholder: 'Train Line', item: 'fds'),
            // SelectionItem(
            //     placeholder: 'Station',
            //     item: state.selectedStop.stopName ?? null),
            // SelectionItem(
            //   placeholder: 'Direction',
            //   item: 'Direction',
            // ),
          ],
        );
      }
      return Container();
    });
  }
}

class SelectionItem extends StatelessWidget {
  const SelectionItem({
    dynamic key,
    @required String placeholder,
    @required String item,
  })  : _item = item,
        _placeholder = placeholder,
        super(key: key);

  final String _item;
  final String _placeholder;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: _item != null ? 1.0 : 0.5,
      child: Text(
        _item != null ? _item : _placeholder,
      ),
    );
  }
}
