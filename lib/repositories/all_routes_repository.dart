import 'dart:async';

import 'package:meta/meta.dart';

import 'package:ptv/repositories/routes_api_client.dart';
import 'package:ptv/models/models.dart';

class AllRoutesRepository {
  final RoutesApiClient routesApiClient;

  AllRoutesRepository({@required this.routesApiClient})
      : assert(routesApiClient != null);

  Future<List<SingleRoute>> getRoutes() async {
    return await routesApiClient.fetchAllRoutes();
  }
}
