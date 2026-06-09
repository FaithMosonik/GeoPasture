import 'package:flutter/material.dart';

import '../../../database/tables/behaviour_classification.dart';
import '../../../shared/theme/app_theme.dart';

class BehaviourStatusChip extends StatelessWidget {
  final int behaviourClass;

  const BehaviourStatusChip({super.key, required this.behaviourClass});

  static const _colours = <Color>[
    AppTheme.accentGreen,   // Feeding
    Colors.blue,            // Rumination
    Colors.amber,           // Standing
    Colors.purple,          // Lying
    AppTheme.warningOrange, // Walking
  ];

  @override
  Widget build(BuildContext context) {
    final colour = _colours[behaviourClass];
    final label = BehaviourClass.labelFor(behaviourClass);

    return Chip(
      label: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: colour,
      padding: const EdgeInsets.symmetric(horizontal: 4),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
