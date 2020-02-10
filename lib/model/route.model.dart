import 'package:equatable/equatable.dart';

class SingleRoute extends Equatable {
  final int routeId;
  final int routeType;
  final String routeName;

  const SingleRoute({this.routeId, this.routeName, this.routeType});

  @override
  List<Object> get props => [routeId, routeName, routeType];

  static SingleRoute fromJson(dynamic json) {
    return SingleRoute(
      routeId: json['route_id'],
      routeType: json['route_type'],
      routeName: json['route_name'],
    );
  }
}
// class SingleRoute {
//   final int routeId;
//   final int routeType;
//   final String routeName;

//   SingleRoute({this.routeId, this.routeType, this.routeName});

//   factory SingleRoute.fromJson(Map<String, dynamic> json) {
//     return SingleRoute(
//       routeId: json['route_id'],
//       routeType: json['route_type'],
//       routeName: json['route_name'],
//     );
//   }
// }
