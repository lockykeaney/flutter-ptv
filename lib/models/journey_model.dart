import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class JourneyModel extends Equatable {
  final String id;
  final int routeId;
  final String routeName;
  final int stopId;
  final String stopName;
  final int direction;
  final bool defaultJourney;
  final String journeyName;

  const JourneyModel({
    @required this.id,
    @required this.routeId,
    @required this.routeName,
    @required this.stopId,
    @required this.stopName,
    @required this.direction,
    @required this.defaultJourney,
    @required this.journeyName,
  });

  @override
  List<Object> get props => [
        id,
        routeId,
        routeName,
        stopId,
        stopName,
        direction,
        defaultJourney,
        journeyName
      ];
}
