import 'package:equatable/equatable.dart';

class StopModel extends Equatable {
  final int stopId;
  final int routeId;
  final int routeType;
  final String stopName;
  final String stopSuburb;
  final List<int> disruptionIds;

  const StopModel(
      {this.stopId,
      this.routeId,
      this.stopName,
      this.routeType,
      this.stopSuburb,
      this.disruptionIds});

  @override
  List<Object> get props =>
      [stopId, routeId, stopName, routeType, stopSuburb, disruptionIds];

  static StopModel fromJson(dynamic json) {
    return StopModel(
        stopId: json['stop_id'],
        routeId: json['route_id'],
        routeType: json['route_type'],
        stopName: json['stop_name'],
        stopSuburb: json['stop_suburb']);
  }
}
