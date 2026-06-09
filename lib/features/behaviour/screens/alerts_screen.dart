import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/behaviour_repository.dart';
import '../../../database/app_database.dart';
import '../widgets/alert_card.dart';
import 'alert_detail_screen.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  List<DistressAlertData> _alerts = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final alerts =
        await context.read<BehaviourRepository>().getActiveAlerts();
    if (mounted) setState(() { _alerts = alerts; _loading = false; });
  }

  Future<void> _acknowledge(String alertId) async {
    await context.read<BehaviourRepository>().acknowledgeAlert(alertId);
    _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerts'),
        actions: [
          if (_alerts.isNotEmpty)
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${_alerts.length}',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _alerts.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline,
                          size: 48, color: Colors.green),
                      SizedBox(height: 12),
                      Text('No active alerts'),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    itemCount: _alerts.length,
                    itemBuilder: (_, i) {
                      final alert = _alerts[i];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AlertDetailScreen(alert: alert),
                          ),
                        ).then((_) => _load()),
                        child: AlertCard(
                          alert: alert,
                          onAcknowledge: () => _acknowledge(alert.id),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
