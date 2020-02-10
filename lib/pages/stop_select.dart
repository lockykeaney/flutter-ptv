import 'package:flutter/material.dart';
import 'package:ptv/model/route.model.dart';

class StopSelect extends StatelessWidget {
  final SingleRoute route;
  StopSelect({Key key, @required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(route);
    return Scaffold(
      body: Center(
        child: Text('Stop Select'),
      ),
    );
  }
}
