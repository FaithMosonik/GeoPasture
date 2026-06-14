import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workmanager/workmanager.dart';

import 'core/notifiers/alert_count_notifier.dart';
import 'core/services/data_seeder.dart';
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
import 'sync/connectivity_monitor.dart';
import 'sync/sync_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ── Firebase ───────────────────────────────────────────────────────────
  // Once you have google-services.json, run:
  //   dart pub global activate flutterfire_cli
  //   flutterfire configure --project=your-firebase-project-id
  // Then replace this block with:
  //   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    await Firebase.initializeApp();
  

  // ── Database & DAOs ────────────────────────────────────────────────────
  final db = AppDatabase();
  await DataSeeder(db).seedIfEmpty();
  final animalDao = AnimalDao(db);
  final classificationDao = BehaviourClassificationDao(db);
  final distressAlertDao = DistressAlertDao(db);

  // ── Sync ───────────────────────────────────────────────────────────────
  final syncRepository = SyncRepository(db);
  final connectivityMonitor = ConnectivityMonitor();
  await connectivityMonitor.start();

  // ── Services ───────────────────────────────────────────────────────────
  final classificationService = ClassificationService();
  try {
    await classificationService.loadModel();
  } catch (_) {}

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

  final alertCountNotifier = AlertCountNotifier(repo);
  await alertCountNotifier.refresh();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: db),
        Provider<SyncRepository>.value(value: syncRepository),
        Provider<ConnectivityMonitor>.value(value: connectivityMonitor),
        Provider<BehaviourRepository>.value(value: repo),
        ChangeNotifierProvider<AlertCountNotifier>.value(
          value: alertCountNotifier,
        ),
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