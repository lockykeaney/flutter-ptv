import 'package:flutter/material.dart';
import './fetch_routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OnBoarding(),
    );
  }
}

class OnBoarding extends StatefulWidget {
  OnBoarding({Key key}) : super(key: key);

  @override
  _OnBoarding createState() => _OnBoarding();
}

class _OnBoarding extends State<OnBoarding> {
  List<SingleRoute> _routes = new List<SingleRoute>();
  var _selectedRoute;

  @override
  void initState() {
    getAllRoutes().then((value) {
      print('Initing State...');
      setState(() {
        _routes = value;
      });
    });
    super.initState();
  }

  _handleTap(routeId) {
    getLine(routeId);
    // setState(() {
    //   _selectedRoute = getLine(routeId);
    // });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('None')),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _routes.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _handleTap(_routes[index].routeId);
              },
              child: new Container(
                height: 50,
                child: Center(
                  child: Text(
                    _routes[index].routeName,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
