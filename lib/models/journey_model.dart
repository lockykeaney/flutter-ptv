import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class JourneyModel {
  int routeId;
  String routeName;
  int stopId;
  String stopName;
  int direction;
  String journeyName;

  JourneyModel({
    this.routeId,
    this.routeName,
    this.stopId,
    this.stopName,
    this.direction,
    this.journeyName,
  });

  factory JourneyModel.fromJson(Map<String, dynamic> json) => new JourneyModel(
        routeId: json["routeId"],
        routeName: json["routeName"],
        stopId: json["stopId"],
        stopName: json["stopName"],
        direction: json["direction"],
        journeyName: json["journeyName"],
      );

  Map<String, dynamic> toJson() => {
        "routeId": routeId,
        "routeName": routeName,
        "stopId": stopId,
        "stopName": stopName,
        "direction": direction,
        "journeyName": journeyName,
      };
}
// class JourneyModel extends Equatable {
//   final String id;
//   final int routeId;
//   final String routeName;
//   final int stopId;
//   final String stopName;
//   final int direction;
//   final bool defaultJourney;
//   final String journeyName;

//   const JourneyModel({
//     @required this.id,
//     @required this.routeId,
//     @required this.routeName,
//     @required this.stopId,
//     @required this.stopName,
//     @required this.direction,
//     @required this.defaultJourney,
//     @required this.journeyName,
//   });

//   @override
//   List<Object> get props => [
//         id,
//         routeId,
//         routeName,
//         stopId,
//         stopName,
//         direction,
//         defaultJourney,
//         journeyName
//       ];

//   factory JourneyModel.fromMap(Map<String, dynamic> json) {
//     return JourneyModel(
//       id: json["id"],
//       routeId: json["routeId"],
//       routeName: json["routeName"],
//       stopId: json["stopId"],
//       stopName: json["stopName"],
//       direction: json["direction"],
//       defaultJourney: json["defaultJourney"],
//       journeyName: json["journeyName"],
//     );
//   }
// }
