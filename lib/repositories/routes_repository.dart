import 'dart:async';

import 'package:meta/meta.dart';

import 'package:ptv/repositories/routes_api_client.dart';
import 'package:ptv/models/models.dart';

class RoutesRepository {
  final RoutesApiClient routesApiClient;

  RoutesRepository({@required this.routesApiClient})
      : assert(routesApiClient != null);

  Future<List<SingleRoute>> getRoutes() async {
    return await routesApiClient.fetchAllRoutes();
  }

  Future<SingleRoute> fetchSingleRoute(int routeId) async {
    return await routesApiClient.fetchSingleRoute(routeId);
  }

  Future<List<Stop>> fetchStopsOnRoute(int routeId) async {
    return await routesApiClient.fetchStopsOnRoute(routeId);
  }
}
