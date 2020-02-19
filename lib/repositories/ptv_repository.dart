import 'dart:async';

import 'package:meta/meta.dart';

import 'package:ptv/repositories/ptv_api_client.dart';
import 'package:ptv/models/models.dart';

class PtvRepository {
  final PtvApiClient ptvApiClient;

  PtvRepository({@required this.ptvApiClient}) : assert(ptvApiClient != null);

  Future<List<RouteModel>> fetchRoutes() async {
    return await ptvApiClient.fetchAllRoutes();
  }

  Future<RouteModel> fetchRoute(int routeId) async {
    return await ptvApiClient.fetchRoute(routeId);
  }

  Future<List<StopModel>> fetchStopsOnRoute(int routeId) async {
    return await ptvApiClient.fetchStopsOnRoute(routeId);
  }

  Future<List<DepartureModel>> fetchDeparaturesFromStop(
      int routeId, int stopId) async {
    return await ptvApiClient.fetchDeparaturesFromStop(routeId, stopId);
  }
}
