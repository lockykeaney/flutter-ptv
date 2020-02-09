import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import './get_url.dart';

class SingleRoute {
  final int routeId;
  final int routeType;
  final String routeName;

  SingleRoute({this.routeId, this.routeType, this.routeName});

  factory SingleRoute.fromJson(Map<String, dynamic> json) {
    return SingleRoute(
      routeId: json['route_id'],
      routeType: json['route_type'],
      routeName: json['route_name'],
    );
  }
}

Future<List<SingleRoute>> getAllRoutes() async {
  print('Routes Object Method running...');
  final url = getUrl('routes');
  final data = await http.get(url);
  final result = json.decode(data.body);
  Iterable list = result["routes"];
  return list.map((route) => SingleRoute.fromJson(route)).toList();
}

class Line {
  final int routeId;
  final int routeType;
  final String routeName;

  Line({this.routeId, this.routeType, this.routeName});

  factory Line.fromJson(Map<String, dynamic> json) {
    return Line(
      routeId: json['route_id'],
      routeType: json['route_type'],
      routeName: json['route_name'],
    );
  }
}

Future<Line> getLine(int routeId) async {
  final url = getUrl('routes/$routeId');
  final data = await http.get(url);
  final result = json.decode(data.body);
  print(result);
}
