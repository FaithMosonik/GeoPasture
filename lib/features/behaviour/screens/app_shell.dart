import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/notifiers/alert_count_notifier.dart';
import 'alerts_screen.dart';
import 'herd_behaviour_overview_screen.dart';
import 'individual_animal_behaviour_screen.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _screens = <Widget>[
    HerdBehaviourOverviewScreen(),
    _PasturesPlaceholder(),
    IndividualAnimalBehaviourScreen(),
    AlertsScreen(),
  ];

  void _onTabTap(int index) {
    setState(() => _currentIndex = index);
    // Refresh badge when leaving the alerts tab — user may have acknowledged alerts
    if (index != 3) {
      context.read<AlertCountNotifier>().refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final alertCount = context.watch<AlertCountNotifier>().count;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTap,
          type: BottomNavigationBarType.fixed,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Dashboard',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Pastures',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.pets),
              label: 'Herds',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                isLabelVisible: alertCount > 0,
                label: Text('$alertCount'),
                child: const Icon(Icons.notifications_outlined),
              ),
              label: 'Alerts',
            ),
          ],
        ),
      ),
    );
  }
}

class _PasturesPlaceholder extends StatelessWidget {
  const _PasturesPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.map_outlined, size: 56, color: Colors.grey),
            SizedBox(height: 12),
            Text(
              'Pasture maps coming soon',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
