import '../../../database/app_database.dart';
import '../../../database/tables/behaviour_classification.dart';
import '../models/time_budget.dart';

class TimeBudgetService {
  /// Aggregates [classifications] into percentage time spent per behaviour
  /// class over the period they span. Returns a zero-budget if the list
  /// is empty.
  TimeBudget compute(
    String animalId,
    DateTime date,
    List<BehaviourClassificationData> classifications,
  ) {
    if (classifications.isEmpty) {
      return TimeBudget(
        animalId: animalId,
        date: date,
        grazingPercent: 0,
        ruminatingPercent: 0,
        standingPercent: 0,
        lyingPercent: 0,
        walkingPercent: 0,
        totalWindows: 0,
      );
    }

    final counts = List<int>.filled(5, 0);
    for (final c in classifications) {
      counts[c.behaviourClass]++;
    }

    final total = classifications.length;

    return TimeBudget(
      animalId: animalId,
      date: date,
      grazingPercent: counts[BehaviourClass.grazing] / total * 100,
      ruminatingPercent: counts[BehaviourClass.ruminating] / total * 100,
      standingPercent: counts[BehaviourClass.standing] / total * 100,
      lyingPercent: counts[BehaviourClass.lying] / total * 100,
      walkingPercent: counts[BehaviourClass.walking] / total * 100,
      totalWindows: total,
    );
  }
}
