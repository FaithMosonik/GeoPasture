import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/alert_count_notifier.dart';
import '../../../data/repositories/behaviour_repository.dart';
import '../../../database/app_database.dart';
import '../../../database/tables/distress_alert.dart';
import '../../../shared/theme/app_theme.dart';
import '../../../sync/offline_demo_screen.dart'; // adjust path if needed

class AlertDetailScreen extends StatelessWidget {
  final DistressAlertData alert;

  const AlertDetailScreen({super.key, required this.alert});

  @override
  Widget build(BuildContext context) {
    final isHigh = alert.severity == AlertSeverity.high;
    final severityColour = isHigh ? AppTheme.alertRed : AppTheme.warningOrange;
    final isUnread = alert.isAcknowledged == 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Alert Detail')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: severityColour,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                alert.severity,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(alert.message, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            _DetailRow(
              label: 'Time',
              value: DateFormat('dd MMM yyyy, HH:mm').format(alert.timestamp),
            ),
            _DetailRow(
              label: 'Type',
              value: alert.alertType
                  .replaceAll('_', ' ')
                  .split(' ')
                  .map((w) =>
                      w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
                  .join(' '),
            ),
            _DetailRow(
              label: 'Status',
              value: isUnread ? 'Unacknowledged' : 'Acknowledged',
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const OfflineDemoScreen()),
                ),
                child: const Text('Offline Demo'),
              ),
            ),
            const SizedBox(height: 8),
            if (isUnread)
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primaryGreen,
                  ),
                  onPressed: () async {
                    final repo = context.read<BehaviourRepository>();
                    final notifier = context.read<AlertCountNotifier>();
                    await repo.acknowledgeAlert(alert.id);
                    await notifier.refresh();
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Text('Acknowledge Alert'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 13))),
        ],
      ),
    );
  }
}