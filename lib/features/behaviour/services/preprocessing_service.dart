import '../../../core/constants/app_constants.dart';
import '../../../database/app_database.dart';

class PreprocessingService {
  // 2nd-order Butterworth high-pass filter coefficients.
  // Derived via bilinear transform: fc = 0.2 Hz, fs = 10 Hz, Q = 1/√2 (Butterworth).
  // Filter equation (Direct Form I):
  //   y[n] = b0·x[n] + b1·x[n-1] + b2·x[n-2] − a1·y[n-1] − a2·y[n-2]
  // a1 is negative, so -a1·y[n-1] adds positive feedback — this is correct.
  static const double _b0 = 0.91498;
  static const double _b1 = -1.82995;
  static const double _b2 = 0.91498;
  static const double _a1 = -1.82282;
  static const double _a2 = 0.83724;

  /// Applies the high-pass filter and packs readings into a [windowSize × 3]
  /// matrix suitable for direct use as TFLite input tensor [1, 100, 3].
  List<List<double>> prepareWindow(List<AccelerometerReadingData> readings) {
    assert(readings.length == AppConstants.windowSize);

    final xFiltered = _applyHPF(readings.map((r) => r.xAxis).toList());
    final yFiltered = _applyHPF(readings.map((r) => r.yAxis).toList());
    final zFiltered = _applyHPF(readings.map((r) => r.zAxis).toList());

    return List.generate(
      readings.length,
      (i) => [xFiltered[i], yFiltered[i], zFiltered[i]],
    );
  }

  List<double> _applyHPF(List<double> signal) {
    final output = List<double>.filled(signal.length, 0.0);
    double x1 = 0.0, x2 = 0.0;
    double y1 = 0.0, y2 = 0.0;

    for (int n = 0; n < signal.length; n++) {
      final x0 = signal[n];
      final y0 = _b0 * x0 + _b1 * x1 + _b2 * x2 - _a1 * y1 - _a2 * y2;
      output[n] = y0;
      x2 = x1;
      x1 = x0;
      y2 = y1;
      y1 = y0;
    }
    return output;
  }
}
