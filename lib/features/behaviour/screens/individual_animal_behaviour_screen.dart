import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/behaviour_repository.dart';
import '../../../database/app_database.dart';
import '../../../shared/theme/app_theme.dart';
import '../widgets/behaviour_status_chip.dart';

class IndividualAnimalBehaviourScreen extends StatefulWidget {
  const IndividualAnimalBehaviourScreen({super.key});

  @override
  State<IndividualAnimalBehaviourScreen> createState() =>
      _IndividualAnimalBehaviourScreenState();
}

class _IndividualAnimalBehaviourScreenState
    extends State<IndividualAnimalBehaviourScreen> {
  static const _herdId = 'demo-herd-001';

  List<_AnimalRow> _rows = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final repo = context.read<BehaviourRepository>();

    final animals = await repo.getAnimalsByHerd(_herdId);
    final activeAlerts = await repo.getActiveAlerts();
    final alertAnimalIds = activeAlerts.map((a) => a.animalId).toSet();

    final rows = await Future.wait(
      animals.map((a) async {
        final latest = await repo.getLatestClassification(a.id);
        return _AnimalRow(
          animal: a,
          latest: latest,
          hasAlert: alertAnimalIds.contains(a.id),
        );
      }),
    );

    if (mounted) setState(() { _rows = rows; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'HERD',
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
          : _rows.isEmpty
              ? const Center(child: Text('No animals in this herd'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    itemCount: _rows.length,
                    itemBuilder: (_, i) => _AnimalCard(row: _rows[i]),
                  ),
                ),
    );
  }
}

// ── Data holder ───────────────────────────────────────────────────────────────

class _AnimalRow {
  final AnimalData animal;
  final BehaviourClassificationData? latest;
  final bool hasAlert;

  const _AnimalRow({
    required this.animal,
    required this.latest,
    required this.hasAlert,
  });
}

// ── Card widget ───────────────────────────────────────────────────────────────

class _AnimalCard extends StatelessWidget {
  final _AnimalRow row;

  const _AnimalCard({required this.row});

  @override
  Widget build(BuildContext context) {
    final name = row.animal.name ?? 'Animal ${row.animal.id.substring(0, 8)}';
    final species = _capitalise(row.animal.species);
    final wearable = row.animal.wearableId;
    final latest = row.latest;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Animal avatar
            _Avatar(species: row.animal.species, hasAlert: row.hasAlert),
            const SizedBox(width: 14),

            // Name + species + last-seen
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      if (row.hasAlert) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 16,
                          color: AppTheme.alertRed,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    wearable != null ? '$species · $wearable' : species,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (latest != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      'Last seen ${_timeAgo(latest.timestamp)}',
                      style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                    ),
                  ],
                ],
              ),
            ),

            // Behaviour chip
            if (latest != null)
              BehaviourStatusChip(behaviourClass: latest.behaviourClass)
            else
              Text(
                'No data',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
          ],
        ),
      ),
    );
  }

  String _capitalise(String s) =>
      s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);

  String _timeAgo(DateTime t) {
    final diff = DateTime.now().difference(t);
    if (diff.inMinutes < 1) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return DateFormat('d MMM').format(t);
  }
}

// ── Avatar ────────────────────────────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  final String species;
  final bool hasAlert;

  const _Avatar({required this.species, required this.hasAlert});

  @override
  Widget build(BuildContext context) {
    final isCattle = species.toLowerCase() == 'cattle';
    final colour = hasAlert
        ? AppTheme.alertRed.withValues(alpha: 0.12)
        : AppTheme.primaryGreen.withValues(alpha: 0.10);

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(color: colour, shape: BoxShape.circle),
      child: Center(
        child: Text(
          isCattle ? '🐄' : '🐐',
          style: const TextStyle(fontSize: 22),
        ),
      ),
    );
  }
}
