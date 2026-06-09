import 'package:tflite_flutter/tflite_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../models/classification_result.dart';

class ClassificationService {
  Interpreter? _interpreter;

  static const String _modelPath = 'assets/models/behavior_model.tflite';

  bool get isModelLoaded => _interpreter != null;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset(_modelPath);
  }

  void dispose() {
    _interpreter?.close();
    _interpreter = null;
  }

  /// Runs inference on a single [windowSize × 3] window.
  ///
  /// [window] must have shape [100][3] — use PreprocessingService.prepareWindow().
  Future<ClassificationResult> classify(
    String animalId,
    List<List<double>> window,
    DateTime windowStart,
    DateTime windowEnd,
  ) async {
    assert(_interpreter != null, 'Call loadModel() before classify()');
    assert(window.length == AppConstants.windowSize);

    // Input shape:  [1, 100, 3]
    final input = [window];
    // Output shape: [1, 5]
    final output = [List<double>.filled(AppConstants.numClasses, 0.0)];

    _interpreter!.run(input, output);

    final probabilities = List<double>.from(output[0]);

    int behaviourClass = 0;
    double confidence = probabilities[0];
    for (int i = 1; i < probabilities.length; i++) {
      if (probabilities[i] > confidence) {
        confidence = probabilities[i];
        behaviourClass = i;
      }
    }

    return ClassificationResult(
      animalId: animalId,
      behaviourClass: behaviourClass,
      confidence: confidence,
      probabilities: probabilities,
      windowStart: windowStart,
      windowEnd: windowEnd,
    );
  }
}
