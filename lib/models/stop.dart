import 'package:equatable/equatable.dart';

class Stop extends Equatable {
  final int stopId;
  final int routeType;
  final String stopName;
  final String stopSuburb;
  final List<int> disruptionIds;

  const Stop(
      {this.stopId,
      this.stopName,
      this.routeType,
      this.stopSuburb,
      this.disruptionIds});

  @override
  List<Object> get props =>
      [stopId, stopName, routeType, stopSuburb, disruptionIds];

  static Stop fromJson(dynamic json) {
    return Stop(
        stopId: json['stop_id'],
        routeType: json['route_type'],
        stopName: json['stop_name'],
        stopSuburb: json['stop_suburb'],
        disruptionIds: json['disruption_ids']);
  }
}
