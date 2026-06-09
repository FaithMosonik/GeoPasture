import '../../../database/tables/behaviour_classification.dart';

class ClassificationResult {
  final String animalId;
  final int behaviourClass;
  final double confidence;

  /// Softmax probabilities for all 5 classes, indexed by BehaviourClass constants.
  final List<double> probabilities;

  final DateTime windowStart;
  final DateTime windowEnd;

  const ClassificationResult({
    required this.animalId,
    required this.behaviourClass,
    required this.confidence,
    required this.probabilities,
    required this.windowStart,
    required this.windowEnd,
  }) : assert(probabilities.length == 5);

  String get label => BehaviourClass.labelFor(behaviourClass);

  double get probGrazing => probabilities[BehaviourClass.grazing];
  double get probRuminating => probabilities[BehaviourClass.ruminating];
  double get probStanding => probabilities[BehaviourClass.standing];
  double get probLying => probabilities[BehaviourClass.lying];
  double get probWalking => probabilities[BehaviourClass.walking];
}
