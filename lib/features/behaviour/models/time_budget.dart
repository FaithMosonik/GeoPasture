import '../../../database/tables/behaviour_classification.dart';

class TimeBudget {
  final String animalId;
  final DateTime date;
  final double grazingPercent;
  final double ruminatingPercent;
  final double standingPercent;
  final double lyingPercent;
  final double walkingPercent;

  /// Number of 10-second windows that make up this budget.
  final int totalWindows;

  const TimeBudget({
    required this.animalId,
    required this.date,
    required this.grazingPercent,
    required this.ruminatingPercent,
    required this.standingPercent,
    required this.lyingPercent,
    required this.walkingPercent,
    required this.totalWindows,
  });

  double percentFor(int behaviourClass) {
    switch (behaviourClass) {
      case BehaviourClass.grazing:
        return grazingPercent;
      case BehaviourClass.ruminating:
        return ruminatingPercent;
      case BehaviourClass.standing:
        return standingPercent;
      case BehaviourClass.lying:
        return lyingPercent;
      case BehaviourClass.walking:
        return walkingPercent;
      default:
        return 0.0;
    }
  }
}
