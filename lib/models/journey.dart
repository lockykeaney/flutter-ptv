import 'package:equatable/equatable.dart';

class Journey extends Equatable {
  final String id;
  final int routeId;
  final int stopId;
  final String direction;
  final bool defaultJourney;
  final String journeyName;
}
