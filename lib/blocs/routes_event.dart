import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:ptv/models/models.dart';

// abstract class RoutesEvent extends Equatable {
//   const RoutesEvent();
// }

// class FetchRoutes extends RoutesEvent {
//   List<SingleRoute> routes = new List<SingleRoute>();

//   FetchRoutes({@required this.routes}) : assert(routes != null);

//   @override
//   List<Object> get props => [routes];
// }

abstract class RoutesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchRoutes extends RoutesEvent {}
