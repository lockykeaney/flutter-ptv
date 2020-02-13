import 'package:equatable/equatable.dart';

class Departure extends Equatable {
  final int stopId;
  final int routeId;
  final int directionId;
  final String platformNumber;
  final String scheduledDeparture;
  final String estimatedDeparture;

  const Departure(
      {this.stopId,
      this.routeId,
      this.directionId,
      this.estimatedDeparture,
      this.scheduledDeparture,
      this.platformNumber});

  @override
  List<Object> get props => [];

  static Departure fromJson(dynamic json) {
    return Departure(
      stopId: json['stop_id'],
      routeId: json['route_id'],
      directionId: json['direction_id'],
      platformNumber: json['platform_number'],
      scheduledDeparture: json['scheduled_departure_utc'],
      estimatedDeparture: json['estimated_departure_utc'],
    );
  }
}
