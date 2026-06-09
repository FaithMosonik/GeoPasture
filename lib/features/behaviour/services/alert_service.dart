import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/app_constants.dart';
import '../../../data/local/dao/distress_alert_dao.dart';
import '../../../database/app_database.dart';
import '../../../database/tables/distress_alert.dart';
import '../models/time_budget.dart';

class AlertService {
  final DistressAlertDao _distressAlertDao;
  static const _uuid = Uuid();

  AlertService(this._distressAlertDao);

  /// Evaluates [budget] against alert thresholds and inserts a [DistressAlert]
  /// for each breach. [lastClassificationId] is the most recent classification
  /// record in the budget window — used as the FK reference on the alert row.
  /// [pastoralistId] is resolved by the caller from the animal's herd.
  ///
  /// Returns the IDs of any alerts that were inserted (empty if no breach).
  Future<List<String>> evaluateAndAlert({
    required TimeBudget budget,
    required AnimalData animal,
    required String pastoralistId,
    required String lastClassificationId,
  }) async {
    final inserted = <String>[];
    final now = DateTime.now();
    final animalLabel = animal.name ?? 'Animal ${animal.id}';

    if (budget.grazingPercent < AppConstants.feedingMinThreshold) {
      final hours = (budget.grazingPercent / 100 * 24).toStringAsFixed(1);
      final id = _uuid.v4();
      await _distressAlertDao.insertAlert(
        DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.lowFeeding),
          message: Value(
            '$animalLabel has been feeding for only $hours hours '
            'in the last 24 hours.',
          ),
          severity: const Value(AlertSeverity.high),
          timestamp: Value(now),
        ),
      );
      inserted.add(id);
    }

    if (budget.ruminatingPercent < AppConstants.ruminationMinThreshold) {
      final hours = (budget.ruminatingPercent / 100 * 24).toStringAsFixed(1);
      final id = _uuid.v4();
      await _distressAlertDao.insertAlert(
        DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.lowRumination),
          message: Value(
            '$animalLabel has been ruminating for only $hours hours '
            'in the last 24 hours.',
          ),
          severity: const Value(AlertSeverity.medium),
          timestamp: Value(now),
        ),
      );
      inserted.add(id);
    }

    if (budget.walkingPercent > AppConstants.walkingMaxThreshold) {
      final hours = (budget.walkingPercent / 100 * 24).toStringAsFixed(1);
      final id = _uuid.v4();
      await _distressAlertDao.insertAlert(
        DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.excessiveWalking),
          message: Value(
            '$animalLabel has been walking for $hours hours '
            'in the last 24 hours.',
          ),
          severity: const Value(AlertSeverity.medium),
          timestamp: Value(now),
        ),
      );
      inserted.add(id);
    }

    return inserted;
  }
}
