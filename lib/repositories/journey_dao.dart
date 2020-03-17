import 'dart:async';
import 'dart:developer';
import 'package:ptv/models/models.dart';

import '../core/database.dart';

class JourneyDao {
  final dbProvider = DatabaseProvider.dbProvider;

  Future<List<JourneyModel>> getJourneys() async {
    final db = await dbProvider.database;
    var res = await db.query('$tableName');

    List<JourneyModel> journeys = res.isNotEmpty
        ? res.map((journey) => JourneyModel.fromJson(journey)).toList()
        : [];

    return journeys;
  }

  Future<int> newJourney(JourneyModel journey) async {
    print("new journey in dao");
    final db = await dbProvider.database;
    print(journey.toJson());
    var res = await db.insert('$tableName', journey.toJson());
    return res;
  }
}
