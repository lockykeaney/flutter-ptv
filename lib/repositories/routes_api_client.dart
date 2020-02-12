import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:ptv/models/models.dart';
import 'package:ptv/service.dart';

class RoutesApiClient {
  final http.Client httpClient;

  RoutesApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //fetch all routes
  Future<List<SingleRoute>> fetchAllRoutes() async {
    print('Fetching all routes...');
    final url = service('routes');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    Iterable list = result["routes"];
    return list.map((route) => SingleRoute.fromJson(route)).toList();
  }

  // fetch single route
  Future<SingleRoute> fetchSingleRoute(int routeId) async {
    final url = service('routes/$routeId');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    return SingleRoute.fromJson(result);
  }

  Future<List<Stop>> fetchStopsOnRoute(int routeId) async {
    print('Fetching all routes...');
    final url = service('stops/route/$routeId/route_type/0');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    Iterable list = result["stops"];
    return list.map((route) => Stop.fromJson(route)).toList();
  }
}
