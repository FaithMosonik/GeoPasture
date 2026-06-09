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
            radius: 60,
          ),
        )
        .toList();

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 48,
              sectionsSpace: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 6,
          alignment: WrapAlignment.center,
          children: BehaviourClass.labels.asMap().entries.map((e) {
            final pct = percents[e.key];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: _colours[e.key],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${e.value} ${pct.toStringAsFixed(1)}%',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
