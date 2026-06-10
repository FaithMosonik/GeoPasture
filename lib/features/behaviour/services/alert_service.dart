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

  // Require at least 30 minutes of monitoring before any alert fires.
  // Prevents noise alerts on a handful of windows at the start of the day.
  static const _minWindows = 36; // 36 × 10 s = 6 min (conservative minimum)

  AlertService(this._distressAlertDao);

  Future<List<String>> evaluateAndAlert({
    required TimeBudget budget,
    required AnimalData animal,
    required String pastoralistId,
    required String lastClassificationId,
  }) async {
    // Insufficient data — skip evaluation entirely
    if (budget.totalWindows < _minWindows) return [];

    final inserted = <String>[];
    final now = DateTime.now();
    final label = animal.name ?? 'Animal ${animal.id}';

    // Actual monitored hours — used in messages so they reflect reality
    final monitoredHrs = budget.totalWindows * 10 / 3600;
    final monitoredLabel = '${monitoredHrs.toStringAsFixed(1)} hrs of monitoring';

    if (budget.grazingPercent < AppConstants.feedingMinThreshold) {
      if (!await _distressAlertDao.hasActiveAlert(
          animal.id, AlertType.lowFeeding)) {
        final actualHrs =
            (budget.grazingPercent / 100 * monitoredHrs).toStringAsFixed(1);
        final id = _uuid.v4();
        await _distressAlertDao.insertAlert(DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.lowFeeding),
          message: Value(
            '$label has been feeding for only $actualHrs hrs out of '
            '$monitoredLabel today.',
          ),
          severity: const Value(AlertSeverity.high),
          timestamp: Value(now),
        ));
        inserted.add(id);
      }
    }

    if (budget.ruminatingPercent < AppConstants.ruminationMinThreshold) {
      if (!await _distressAlertDao.hasActiveAlert(
          animal.id, AlertType.lowRumination)) {
        final actualHrs =
            (budget.ruminatingPercent / 100 * monitoredHrs).toStringAsFixed(1);
        final id = _uuid.v4();
        await _distressAlertDao.insertAlert(DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.lowRumination),
          message: Value(
            '$label has been ruminating for only $actualHrs hrs out of '
            '$monitoredLabel today.',
          ),
          severity: const Value(AlertSeverity.medium),
          timestamp: Value(now),
        ));
        inserted.add(id);
      }
    }

    if (budget.walkingPercent > AppConstants.walkingMaxThreshold) {
      if (!await _distressAlertDao.hasActiveAlert(
          animal.id, AlertType.excessiveWalking)) {
        final actualHrs =
            (budget.walkingPercent / 100 * monitoredHrs).toStringAsFixed(1);
        final id = _uuid.v4();
        await _distressAlertDao.insertAlert(DistressAlertCompanion(
          id: Value(id),
          animalId: Value(animal.id),
          classificationId: Value(lastClassificationId),
          pastoralistId: Value(pastoralistId),
          alertType: const Value(AlertType.excessiveWalking),
          message: Value(
            '$label has been walking for $actualHrs hrs out of '
            '$monitoredLabel today — above the normal range.',
          ),
          severity: const Value(AlertSeverity.medium),
          timestamp: Value(now),
        ));
        inserted.add(id);
      }
    }

    return inserted;
  }
}
