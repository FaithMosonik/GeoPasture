class AppConstants {
  // Behaviour model
  static const int windowSize        = 100;   // 10 seconds at 10Hz
  static const int samplingRate      = 10;    // Hz
  static const int numAxes           = 3;     // X, Y, Z
  static const int numClasses        = 5;

  // Behaviour class labels
  static const Map<int, String> behaviourLabels = {
    0: 'Feeding',
    1: 'Rumination',
    2: 'Standing',
    3: 'Lying',
    4: 'Walking',
  };

  // Alert thresholds — daily time budget percentages
  static const double feedingMinThreshold     = 5.0;
  static const double ruminationMinThreshold  = 3.0;
  static const double walkingMaxThreshold     = 85.0;

  // Local database
  static const String dbName     = 'geopasture.db';
  static const int dbVersion     = 1;

  // Sync
  static const int localRetentionDays = 30;
}
