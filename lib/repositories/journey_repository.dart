import 'dart:async';

import 'package:meta/meta.dart';
import 'package:ptv/models/models.dart';

import 'journey_dao.dart';

class JourneyRepository {
  // final dbProvider = DBProvider.db;
  // final DBProvider dbProvider;

  // JourneyRepository({@required this.dbProvider}) : assert(dbProvider != null);

  final journeyDao = JourneyDao();

  Future<List<JourneyModel>> fetchJourneys() async {
    return await journeyDao.getJourneys();
  }

  Future<int> insertJourney(JourneyModel journey) async {
    return await journeyDao.newJourney(journey);
  }
}
