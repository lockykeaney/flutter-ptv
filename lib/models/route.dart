import 'package:equatable/equatable.dart';

class Route extends Equatable {
  final int routeId;
  final int routeType;
  final String routeName;

  const Route({this.routeId, this.routeName, this.routeType});

  @override
  List<Object> get props => [routeId, routeName, routeType];

  static Route fromJson(dynamic json) {
    return Route(
      routeId: json['route_id'],
      routeType: json['route_type'],
      routeName: json['route_name'],
    );
  }
}
