import 'package:flutter/foundation.dart';

import '../../data/repositories/behaviour_repository.dart';

/// Single source of truth for the unacknowledged alert count.
/// Consumed by AppShell (badge) and the dashboard stat card.
/// Call [refresh] after any acknowledge action so both update instantly.
class AlertCountNotifier extends ChangeNotifier {
  final BehaviourRepository _repo;
  int _count = 0;

  AlertCountNotifier(this._repo);

  int get count => _count;

  Future<void> refresh() async {
    final alerts = await _repo.getActiveAlerts();
    final fresh = alerts.length;
    if (_count != fresh) {
      _count = fresh;
      notifyListeners();
    }
  }
}
