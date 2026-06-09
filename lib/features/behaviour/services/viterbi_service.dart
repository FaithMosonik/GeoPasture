import 'dart:math' as math;

import '../../../core/constants/app_constants.dart';
import '../models/classification_result.dart';

class ViterbiService {
  // Transition matrix A[i][j] = P(next state is j | current state is i).
  // Rows: current state. Columns: next state.
  // Order: Feeding(0), Rumination(1), Standing(2), Lying(3), Walking(4).
  static const List<List<double>> _transitionMatrix = [
    [0.999016, 0.000242, 0.000000, 0.000008, 0.000734], // from Feeding
    [0.000295, 0.993579, 0.000058, 0.000014, 0.006055], // from Rumination
    [0.000000, 0.004379, 0.980296, 0.000000, 0.015326], // from Standing
    [0.000594, 0.002078, 0.000000, 0.984561, 0.012767], // from Lying
    [0.000447, 0.003022, 0.000032, 0.000076, 0.996423], // from Walking
  ];

  // Emission matrix B[i][j] = P(model predicts j | true class is i).
  // Captures the classifier's systematic confusion patterns.
  // Rows: true state. Columns: predicted class.
  static const List<List<double>> _emissionMatrix = [
    [0.890133, 0.004418, 0.003240, 0.013549, 0.088660], // true Feeding
    [0.006287, 0.779547, 0.000419, 0.009220, 0.204526], // true Rumination
    [0.083333, 0.000000, 0.125000, 0.125000, 0.666667], // true Standing
    [0.100000, 0.053846, 0.000000, 0.061538, 0.784615], // true Lying
    [0.107408, 0.058275, 0.015235, 0.032756, 0.786326], // true Walking
  ];

  static const double _epsilon = 1e-10;

  /// Convenience wrapper — extracts class indices and delegates to [smoothClasses].
  List<int> smooth(List<ClassificationResult> sequence) =>
      smoothClasses(sequence.map((r) => r.behaviourClass).toList());

  /// Core Viterbi implementation. Accepts raw argmax class indices so callers
  /// with DB records don't need to construct [ClassificationResult] objects.
  List<int> smoothClasses(List<int> classes) {
    final n = classes.length;
    const k = AppConstants.numClasses;

    if (n == 0) return [];
    if (n == 1) return [classes.first];

    final logViterbi = List.generate(
      n,
      (_) => List<double>.filled(k, double.negativeInfinity),
    );
    final backptr = List.generate(n, (_) => List<int>.filled(k, 0));

    final logPrior = -math.log(k.toDouble());
    final obs0 = classes.first;
    for (int i = 0; i < k; i++) {
      logViterbi[0][i] =
          logPrior + math.log(_emissionMatrix[i][obs0] + _epsilon);
    }

    for (int t = 1; t < n; t++) {
      final obs = classes[t];
      for (int j = 0; j < k; j++) {
        final logEmit = math.log(_emissionMatrix[j][obs] + _epsilon);
        double maxLogProb = double.negativeInfinity;
        int bestPrev = 0;
        for (int i = 0; i < k; i++) {
          final logProb = logViterbi[t - 1][i] +
              math.log(_transitionMatrix[i][j] + _epsilon) +
              logEmit;
          if (logProb > maxLogProb) {
            maxLogProb = logProb;
            bestPrev = i;
          }
        }
        logViterbi[t][j] = maxLogProb;
        backptr[t][j] = bestPrev;
      }
    }

    final path = List<int>.filled(n, 0);
    double maxFinal = logViterbi[n - 1][0];
    path[n - 1] = 0;
    for (int i = 1; i < k; i++) {
      if (logViterbi[n - 1][i] > maxFinal) {
        maxFinal = logViterbi[n - 1][i];
        path[n - 1] = i;
      }
    }
    for (int t = n - 2; t >= 0; t--) {
      path[t] = backptr[t + 1][path[t + 1]];
    }

    return path;
  }
}
