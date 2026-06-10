import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/behaviour_repository.dart';
import '../../../shared/theme/app_theme.dart';
import '../models/time_budget.dart';
import '../widgets/time_budget_donut_chart.dart';

class HerdBehaviourOverviewScreen extends StatefulWidget {
  const HerdBehaviourOverviewScreen({super.key});

  @override
  State<HerdBehaviourOverviewScreen> createState() =>
      _HerdBehaviourOverviewScreenState();
}

class _HerdBehaviourOverviewScreenState
    extends State<HerdBehaviourOverviewScreen> {
  static const _herdId = 'demo-herd-001';

  TimeBudget? _budget;
  int _animalCount = 0;
  int _alertCount = 0;
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
    final alerts  = await repo.getActiveAlerts();
    final budget  = await repo.getHerdDailyTimeBudget(_herdId, DateTime.now());
    if (mounted) {
      setState(() {
        _animalCount = animals.length;
        _alertCount  = alerts.length;
        _budget      = budget;
        _loading     = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundWhite,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'GEOPASTURE',
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              icon: Icon(Icons.account_circle_outlined, size: 28),
              onPressed: null,
              tooltip: 'Profile',
            ),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildWelcome(),
                    const SizedBox(height: 24),
                    _buildStatRow(),
                    const SizedBox(height: 20),
                    _buildBudgetCard(),
                  ],
                ),
              ),
            ),
    );
  }

  // ── Welcome section ───────────────────────────────────────────────────────

  Widget _buildWelcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WELCOME BACK,',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 1.8,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Faith Mosonik',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
            height: 1.1,
          ),
        ),
      ],
    );
  }

  // ── Stat cards ────────────────────────────────────────────────────────────

  Widget _buildStatRow() {
    final monitoringHrs =
        ((_budget?.totalWindows ?? 0) * 10 / 3600).toStringAsFixed(1);

    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: Icons.pets,
            value: '$_animalCount',
            label: 'Animals',
            color: AppTheme.primaryGreen,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.notifications_active,
            value: '$_alertCount',
            label: 'Active Alerts',
            color: _alertCount > 0 ? AppTheme.alertRed : AppTheme.accentGreen,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            icon: Icons.access_time,
            value: '${monitoringHrs}h',
            label: 'Recorded',
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  // ── Budget card ───────────────────────────────────────────────────────────

  Widget _buildBudgetCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DAILY TIME BUDGET',
              style: TextStyle(
                fontSize: 11,
                letterSpacing: 1.5,
                color: Colors.grey[500],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Herd Behavior Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 20),
            _budget == null
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(
                      child: Text('No behaviour data recorded today'),
                    ),
                  )
                : TimeBudgetDonutChart(budget: _budget!),
          ],
        ),
      ),
    );
  }
}

// ── Shared private widget ─────────────────────────────────────────────────────

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        child: Column(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
