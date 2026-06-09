import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'core/services/notification_service.dart';
import 'core/workers/alert_worker.dart';
import 'data/local/dao/animal_dao.dart';
import 'data/local/dao/behaviour_classification_dao.dart';
import 'data/local/dao/distress_alert_dao.dart';
import 'data/repositories/behaviour_repository.dart';
import 'database/app_database.dart';
import 'features/behaviour/screens/app_shell.dart';
import 'features/behaviour/services/alert_service.dart';
import 'features/behaviour/services/classification_service.dart';
import 'features/behaviour/services/preprocessing_service.dart';
import 'features/behaviour/services/viterbi_service.dart';
import 'shared/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase requires google-services.json (Android) / GoogleService-Info.plist (iOS).
  // Guarded so the app still launches for local development before those files are added.
  try {
    await Firebase.initializeApp();
  } catch (_) {}

  // ── Database & DAOs ────────────────────────────────────────────────────
  final db = AppDatabase();
  final animalDao = AnimalDao(db);
  final classificationDao = BehaviourClassificationDao(db);
  final distressAlertDao = DistressAlertDao(db);

  // ── Services ───────────────────────────────────────────────────────────
  final classificationService = ClassificationService();
  await classificationService.loadModel(); // no-op until model file arrives

  final repo = BehaviourRepository(
    animalDao: animalDao,
    classificationDao: classificationDao,
    distressAlertDao: distressAlertDao,
    preprocessingService: PreprocessingService(),
    classificationService: classificationService,
    viterbiService: ViterbiService(),
    alertService: AlertService(distressAlertDao),
  );

  // ── Notifications ──────────────────────────────────────────────────────
  await NotificationService.init();

  // ── Background worker ──────────────────────────────────────────────────
  await Workmanager().initialize(callbackDispatcher);
  await Workmanager().registerPeriodicTask(
    alertEvaluationTask,
    alertEvaluationTask,
    frequency: const Duration(hours: 6),
    constraints: Constraints(networkType: NetworkType.notRequired),
  );

  runApp(
    MultiProvider(
      providers: [
        Provider<BehaviourRepository>.value(value: repo),
      ],
      child: const GeoPastureApp(),
    ),
  );
}

class GeoPastureApp extends StatelessWidget {
  const GeoPastureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GeoPasture',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppShell(),
    );
  }
}
