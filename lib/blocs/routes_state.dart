import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:ptv/models/models.dart';

abstract class RoutesState extends Equatable {
  const RoutesState();

  @override
  List<Object> get props => [];
}

class RoutesEmpty extends RoutesState {}

class RoutesLoading extends RoutesState {}

class RoutesLoaded extends RoutesState {
  final List<SingleRoute> routes;

  const RoutesLoaded({@required this.routes}) : assert(routes != null);

  @override
  List<Object> get props => [routes];
}

class RoutesError extends RoutesState {}
