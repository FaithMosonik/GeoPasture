import 'package:drift/drift.dart';
import 'animal.dart';

/// Behaviour class index constants matching the TFLite model's output order.
/// The model was trained with labels sorted alphabetically by Keras/sklearn.
/// lying (index 3) and walking (index 4) had insufficient training data —
/// the model will rarely if ever predict these in practice.
abstract class BehaviourClass {
  static const int grazing = 0;
  static const int ruminating = 1;
  static const int standing = 2;
  static const int lying = 3;
  static const int walking = 4;

  static const List<String> labels = [
    'Feeding',     // index 0 — trained, reliable
    'Rumination',  // index 1 — trained, reliable
    'Standing',    // index 2 — trained, reliable
    'Lying',       // index 3 — undertrained, low reliability
    'Walking',     // index 4 — undertrained, low reliability
  ];

  static String labelFor(int index) => labels[index];
}

/// Output of the TFLite CNN-LSTM model — one record per 10-second window.
/// Acts as the central data handoff between the inference service and
/// the alert logic. Also consumed by Lynn's sync engine for cloud upload.
///
/// Model architecture: Conv1D → BN → MaxPool → Conv1D → BN → MaxPool → LSTM → Dense → Dense(5, softmax)
/// Input shape: (1, 100, 3) — 100 timesteps × 3 accelerometer axes
/// Output shape: (1, 5) — softmax probabilities for 5 behaviour classes
///
/// Owned by: You (behaviour module)
class BehaviourClassification extends Table {
  TextColumn get id => text()();

  TextColumn get animalId =>
      text().references(Animal, #id)();

  /// Timestamp when inference was run
  DateTimeColumn get timestamp => dateTime()();

  /// Index of the highest-probability class (0–4)
  /// Use BehaviourClass.labelFor(behaviourClass) to get the string label
  IntColumn get behaviourClass => integer()();

  /// Softmax probability of the predicted class (0.0–1.0)
  RealColumn get confidence => real()();

  /// Start of the 100-sample accelerometer window that produced this result
  DateTimeColumn get windowStart => dateTime()();

  /// End of the window — always windowStart + 10 seconds at 10Hz
  DateTimeColumn get windowEnd => dateTime()();

  // ── All 5 softmax probabilities ──────────────────────────────────────
  // Stored individually so alert logic can reason about uncertainty
  // (e.g. flag windows where no single class exceeds 0.5 confidence)

  /// P(grazing) — index 0
  RealColumn get probGrazing => real()();

  /// P(ruminating) — index 1
  RealColumn get probRuminating => real()();

  /// P(standing) — index 2
  RealColumn get probStanding => real()();

  /// P(lying) — index 3 — undertrained
  RealColumn get probLying => real()();

  /// P(walking) — index 4 — undertrained
  RealColumn get probWalking => real()();

  /// Set to true once the alert logic has evaluated this record.
  /// Prevents the same window from triggering duplicate alerts.
  BoolColumn get alertProcessed =>
      boolean().withDefault(const Constant(false))();

  /// 0 = pending upload to Firestore, 1 = synced
  /// Consumed by Lynn's sync engine
  IntColumn get synced => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
