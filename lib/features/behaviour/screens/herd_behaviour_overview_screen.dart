import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/behaviour_repository.dart';
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
  // Replace with herd ID from auth/navigation context once auth flow is wired.
  static const _herdId = 'placeholder_herd_id';

  TimeBudget? _budget;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    final budget = await context
        .read<BehaviourRepository>()
        .getHerdDailyTimeBudget(_herdId, DateTime.now());
    if (mounted) setState(() { _budget = budget; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Herd Overview')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Today's Behaviour Budget",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  TimeBudgetDonutChart(budget: _budget!),
                  const SizedBox(height: 16),
                  Text(
                    '${_budget!.totalWindows} windows recorded today',
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
    );
  }
}
