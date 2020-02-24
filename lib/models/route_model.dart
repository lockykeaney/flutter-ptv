import 'package:equatable/equatable.dart';

class RouteModel extends Equatable {
  final int routeId;
  final int routeType;
  final String routeName;

  const RouteModel({this.routeId, this.routeName, this.routeType});

  @override
  List<Object> get props => [routeId, routeName, routeType];

  static RouteModel fromJson(dynamic json) {
    return RouteModel(
      routeId: json['route_id'],
      routeType: json['route_type'],
      routeName: json['route_name'],
    );
  }
}

class RouteStatusModel extends Equatable {
  final String description;
  final String timestamp;

  const RouteStatusModel({this.description, this.timestamp});

  @override
  List<Object> get props => [description, timestamp];

  static RouteStatusModel fromJson(dynamic json) {
    return RouteStatusModel(
      description: json['description'],
      timestamp: json['timestamp'],
    );
  }
}
