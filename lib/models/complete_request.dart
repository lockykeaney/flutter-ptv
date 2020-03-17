import 'package:equatable/equatable.dart';

import './models.dart';

class CompleteRequest extends Equatable {
  final JourneyModel journey;
  final List<DepartureModel> departures;
  final RouteStatusModel status;

  const CompleteRequest({this.journey, this.departures, this.status});

  @override
  List<Object> get props => [];

  static CompleteRequest fromJson(dynamic json) {
    return CompleteRequest(
      journey: json['journey'],
      departures: json['departures'],
      status: json['status'],
    );
  }
}
