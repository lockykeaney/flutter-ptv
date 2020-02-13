import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Journey extends Equatable {
  final String id;
  final int routeId;
  final int stopId;
  final int
      direction; // 1 for towards city, 2 for away - based on the platform number
  final bool defaultJourney;
  final String journeyName;

  const Journey({
    @required this.id,
    @required this.routeId,
    @required this.stopId,
    @required this.direction,
    @required this.defaultJourney,
    @required this.journeyName,
  });

  @override
  List<Object> get props =>
      [id, routeId, stopId, direction, defaultJourney, journeyName];
}
