import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity states the rest of the app can react to
enum NetworkStatus { online, offline }

/// Watches the device's network connectivity and exposes a stream
/// that emits whenever the status changes.
///
/// The sync engine subscribes to [onConnectivityRestored] to know
/// when to trigger an upload attempt.
class ConnectivityMonitor {
  final Connectivity _connectivity;

  late final StreamController<NetworkStatus> _statusController;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  NetworkStatus _currentStatus = NetworkStatus.offline;
  NetworkStatus get currentStatus => _currentStatus;
  bool get isOnline => _currentStatus == NetworkStatus.online;

  ConnectivityMonitor({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity() {
    _statusController = StreamController<NetworkStatus>.broadcast();
  }

  /// Broadcast stream of network status changes.
  /// Emits [NetworkStatus.online] or [NetworkStatus.offline].
  Stream<NetworkStatus> get statusStream => _statusController.stream;

  /// Filtered stream that emits only when connectivity is RESTORED.
  /// This is what the sync engine listens to.
  Stream<NetworkStatus> get onConnectivityRestored => statusStream
      .where((status) => status == NetworkStatus.online);

  /// Starts monitoring connectivity.
  /// Call this once when the app initialises (e.g. in main.dart or a service).
  Future<void> start() async {
    // Check current status immediately on start
    final result = await _connectivity.checkConnectivity();
    _updateStatus(result);

    // Listen for future changes
    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  /// Stops monitoring. Call when the app is disposed.
  Future<void> stop() async {
    await _subscription?.cancel();
    await _statusController.close();
  }

  void _updateStatus(List<ConnectivityResult> results) {
    final isConnected = results.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet);

    final newStatus =
        isConnected ? NetworkStatus.online : NetworkStatus.offline;

    // Only emit if status actually changed — avoids duplicate triggers
    if (newStatus != _currentStatus) {
      _currentStatus = newStatus;
      _statusController.add(newStatus);
    }
  }

  /// One-off check — useful for the sync engine to verify
  /// connectivity is still active mid-sync before each batch.
  Future<bool> checkIsOnline() async {
    final result = await _connectivity.checkConnectivity();
    return result.any((r) =>
        r == ConnectivityResult.wifi ||
        r == ConnectivityResult.mobile ||
        r == ConnectivityResult.ethernet);
  }
}
