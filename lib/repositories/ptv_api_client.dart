import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:ptv/models/models.dart';
import 'package:ptv/core/service.dart';

class PtvApiClient {
  final http.Client httpClient;

  PtvApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //fetch all routes
  Future<List<Route>> fetchAllRoutes() async {
    print('Fetching all routes...');
    final url = service('routes');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    Iterable list = result["routes"];
    return list.map((route) => Route.fromJson(route)).toList();
  }

  // fetch single route
  Future<Route> fetchRoute(int routeId) async {
    final url = service('routes/$routeId');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    return Route.fromJson(result);
  }

  Future<List<Stop>> fetchStopsOnRoute(int routeId) async {
    print('Fetching all stops on a route...');
    final url = service('stops/route/$routeId/route_type/0');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    Iterable list = result["stops"];
    return list.map((route) => Stop.fromJson(route)).toList();
  }

  Future<List<Departure>> fetchDeparaturesFromStop(
      int routeId, int stopId) async {
    final url = service('departures/route_type/0/stop/$stopId/route/$routeId');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    Iterable list = result["departures"];
    print(list);
    return list.map((route) => Departure.fromJson(route)).toList();
  }
}
