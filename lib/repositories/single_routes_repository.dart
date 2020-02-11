import 'dart:async';

import 'package:meta/meta.dart';

import 'package:ptv/repositories/routes_api_client.dart';
import 'package:ptv/models/models.dart';

class SingleRoutesRepository {
  final RoutesApiClient routesApiClient;

  SingleRoutesRepository({@required this.routesApiClient})
      : assert(routesApiClient != null);

  Future<SingleRoute> fetchSingleRoute(int routeId) async {
    return await routesApiClient.fetchSingleRoute(routeId);
  }
}
