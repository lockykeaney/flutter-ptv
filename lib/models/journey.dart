import 'package:equatable/equatable.dart';

class Journey extends Equatable {
  final String id;
  final int routeId;
  final int stopId;
  final int direction; // 1 for towards city, 2 for away - based on the platform number
  final bool defaultJourney;
  final String journeyName;
}
