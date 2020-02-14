import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Journey extends Equatable {
  final String id;
  final int routeId;
  final String routeName;
  final int stopId;
  final int direction;
  final bool defaultJourney;
  final String journeyName;

  const Journey({
    @required this.id,
    @required this.routeId,
    @required this.routeName,
    @required this.stopId,
    @required this.direction,
    @required this.defaultJourney,
    @required this.journeyName,
  });

  @override
  List<Object> get props =>
      [id, routeId, routeName, stopId, direction, defaultJourney, journeyName];
}
