import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import './service.dart';
import './model/route.model.dart';

Future<List<SingleRoute>> getAllRoutes() async {
  print('Routes Object Method running...');
  final url = service('routes');
  final data = await http.get(url);
  final result = json.decode(data.body);
  Iterable list = result["routes"];
  return list.map((route) => SingleRoute.fromJson(route)).toList();
}

Future<SingleRoute> getLine(int routeId) async {
  final url = service('routes/$routeId');
  final data = await http.get(url);
  final result = json.decode(data.body);
  return SingleRoute.fromJson(result);
}
