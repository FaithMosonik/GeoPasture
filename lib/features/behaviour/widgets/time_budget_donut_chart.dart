import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../database/tables/behaviour_classification.dart';
import '../../../shared/theme/app_theme.dart';
import '../models/time_budget.dart';

class TimeBudgetDonutChart extends StatelessWidget {
  final TimeBudget budget;

  const TimeBudgetDonutChart({super.key, required this.budget});

  static const _colours = <Color>[
    AppTheme.accentGreen,   // Feeding
    Colors.blue,            // Rumination
    Colors.amber,           // Standing
    Colors.purple,          // Lying
    AppTheme.warningOrange, // Walking
  ];

  @override
  Widget build(BuildContext context) {
    if (budget.totalWindows == 0) {
      return const SizedBox(
        height: 200,
        child: Center(child: Text('No behaviour data for today')),
      );
    }

    final percents = [
      budget.grazingPercent,
      budget.ruminatingPercent,
      budget.standingPercent,
      budget.lyingPercent,
      budget.walkingPercent,
    ];

    final sections = percents.asMap().entries
        .where((e) => e.value > 0)
        .map(
          (e) => PieChartSectionData(
            value: e.value,
            color: _colours[e.key],
            title: e.value >= 5 ? '${e.value.toStringAsFixed(0)}%' : '',
            titleStyle: const TextStyle(
              fontSize: 11,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            radius: 52,
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 60,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 12),
        // Vertical legend — name on left, hours on right
        ...percents.asMap().entries.map((e) {
          final monitoredHours = budget.totalWindows * 10 / 3600;
          final hours = e.value / 100 * monitoredHours;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Container(
                  width: 11,
                  height: 11,
                  decoration: BoxDecoration(
                    color: _colours[e.key],
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    BehaviourClass.labels[e.key],
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ),
                Text(
                  '${hours.toStringAsFixed(1)} hrs',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
