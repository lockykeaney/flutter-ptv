import 'package:flutter/material.dart';
import './model/route.model.dart';
import './fetch_routes.dart';

import './pages/stop_select.dart';

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

class ListItem extends StatelessWidget {
  final String routeName;
  ListItem({this.routeName}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Center(
        child: Text(routeName),
      ),
    );
  }
}

class _OnBoarding extends State<OnBoarding> {
  List<SingleRoute> _routes = new List<SingleRoute>();
  SingleRoute _selectedRoute;

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

  _handleTap(routeId) async {
    getLine(routeId);
    var route = await getLine(routeId);
    setState(() {
      _selectedRoute = route;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StopSelect(route: route)),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('NAME')),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _routes.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                _handleTap(_routes[index].routeId);
              },
              child: ListItem(
                routeName: _routes[index].routeName,
              ),
            );
          },
        ),
      ),
    );
  }
}
