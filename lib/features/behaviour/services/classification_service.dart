import '../../../core/constants/app_constants.dart';
import '../models/classification_result.dart';

// Stub implementation — tflite_flutter re-enabled once:
//   1. Teammate pushes assets/models/behaviour_model.tflite
//   2. A tflite_flutter version compatible with Dart 3.11+ is confirmed
class ClassificationService {
  bool get isModelLoaded => false;

  Future<void> loadModel() async {
    // No-op until model file and compatible package are available.
  }

  void dispose() {}

  Future<ClassificationResult> classify(
    String animalId,
    List<List<double>> window,
    DateTime windowStart,
    DateTime windowEnd,
  ) async {
    assert(window.length == AppConstants.windowSize);
    // Returns equal probabilities as a neutral placeholder.
    final probabilities = List<double>.filled(AppConstants.numClasses, 1.0 / AppConstants.numClasses);
    return ClassificationResult(
      animalId: animalId,
      behaviourClass: 0,
      confidence: probabilities[0],
      probabilities: probabilities,
      windowStart: windowStart,
      windowEnd: windowEnd,
    );
  }
}
