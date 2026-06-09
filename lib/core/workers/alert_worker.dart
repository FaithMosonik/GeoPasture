import 'package:flutter/widgets.dart';
import 'package:workmanager/workmanager.dart';

import '../../data/local/dao/animal_dao.dart';
import '../../data/local/dao/behaviour_classification_dao.dart';
import '../../data/local/dao/distress_alert_dao.dart';
import '../../data/repositories/behaviour_repository.dart';
import '../../database/app_database.dart';
import '../../features/behaviour/services/alert_service.dart';
import '../../features/behaviour/services/classification_service.dart';
import '../../features/behaviour/services/preprocessing_service.dart';
import '../../features/behaviour/services/viterbi_service.dart';
import '../services/notification_service.dart';

/// Unique task name used when registering and matching the periodic job.
const alertEvaluationTask = 'com.geopasture.alert_evaluation';

/// Must be a top-level function. WorkManager runs this in a fresh isolate
/// that has no access to the main isolate's Provider tree.
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    final db = AppDatabase();
    try {
      final animalDao = AnimalDao(db);
      final classificationDao = BehaviourClassificationDao(db);
      final distressAlertDao = DistressAlertDao(db);

      final repo = BehaviourRepository(
        animalDao: animalDao,
        classificationDao: classificationDao,
        distressAlertDao: distressAlertDao,
        preprocessingService: PreprocessingService(),
        // ClassificationService is not called during alert evaluation,
        // but the constructor requires it — no loadModel() needed here.
        classificationService: ClassificationService(),
        viterbiService: ViterbiService(),
        alertService: AlertService(distressAlertDao),
      );

      await NotificationService.init();

      final herds = await db.select(db.herd).get();

      for (final herd in herds) {
        final animals = await animalDao.getAnimalsByHerd(herd.id);
        final newAlertIds = <String>[];

        for (final animal in animals) {
          final ids = await repo.evaluateAlerts(
            animal.id,
            herd.pastoralistId,
            DateTime.now(),
          );
          newAlertIds.addAll(ids);
        }

        if (newAlertIds.isNotEmpty) {
          final unack = await distressAlertDao.getUnacknowledgedAlerts();
          final newAlerts =
              unack.where((a) => newAlertIds.contains(a.id)).toList();

          final message = newAlerts.isNotEmpty
              ? newAlerts.first.message
              : '${newAlertIds.length} animal(s) need attention.';

          await NotificationService.showDistressAlert(
            notificationId: herd.id,
            alertCount: newAlertIds.length,
            message: message,
          );
        }
      }

      return true;
    } finally {
      await db.close();
    }
  });
}
