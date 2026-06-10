import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/alert_count_notifier.dart';
import '../../../data/repositories/behaviour_repository.dart';
import '../../../database/app_database.dart';
import '../../../shared/theme/app_theme.dart';
import '../widgets/alert_card.dart';
import 'alert_detail_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<DistressAlertData> _active = [];
  List<DistressAlertData> _history = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final all = await context.read<BehaviourRepository>().getAllAlerts();
    if (mounted) {
      setState(() {
        _active  = all.where((a) => a.isAcknowledged == 0).toList();
        _history = all.where((a) => a.isAcknowledged == 1).toList();
        _loading = false;
      });
      await context.read<AlertCountNotifier>().refresh();
    }
  }

  Future<void> _acknowledge(String alertId) async {
    await context.read<BehaviourRepository>().acknowledgeAlert(alertId);
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ALERTS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2.5,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: _loading ? null : _load,
          tooltip: 'Refresh',
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: _active.isEmpty && _history.isEmpty
                  ? const _EmptyState()
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      children: [
                        if (_active.isNotEmpty) ...[
                          _SectionHeader(
                            label: 'ACTIVE',
                            count: _active.length,
                            colour: AppTheme.alertRed,
                          ),
                          ..._active.map(
                            (alert) => GestureDetector(
                              onTap: () => _openDetail(alert),
                              child: AlertCard(
                                alert: alert,
                                onAcknowledge: () => _acknowledge(alert.id),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                        if (_history.isNotEmpty) ...[
                          _SectionHeader(
                            label: 'HISTORY',
                            count: _history.length,
                            colour: Colors.grey,
                          ),
                          ..._history.map(
                            (alert) => GestureDetector(
                              onTap: () => _openDetail(alert),
                              child: AlertCard(alert: alert),
                            ),
                          ),
                        ],
                      ],
                    ),
            ),
    );
  }

  void _openDetail(DistressAlertData alert) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AlertDetailScreen(alert: alert)),
    ).then((_) => _load());
  }
}

// ── Sub-widgets ───────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  final int count;
  final Color colour;

  const _SectionHeader({
    required this.label,
    required this.count,
    required this.colour,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
              color: colour,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '$count',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outline, size: 56, color: Colors.green),
          SizedBox(height: 12),
          Text(
            'No alerts recorded',
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 4),
          Text(
            'Your herd is behaving normally.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
