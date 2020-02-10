import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:ptv/model/single_route.dart';
import 'package:ptv/service.dart';

class RoutesApiClient {
  final http.Client httpClient;

  RoutesApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  //fetch all routes

  Future<List<SingleRoute>> _fetchAllRoutes() async {
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
  Future<SingleRoute> _fetchSingleRoute(int routeId) async {
    final url = service('routes/$routeId');
    final response = await this.httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }
    final result = json.decode(response.body);
    return SingleRoute.fromJson(result);
  }
}
