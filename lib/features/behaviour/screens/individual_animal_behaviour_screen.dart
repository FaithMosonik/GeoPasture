import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/behaviour_repository.dart';
import '../../../database/app_database.dart';
import '../widgets/behaviour_status_chip.dart';

class IndividualAnimalBehaviourScreen extends StatefulWidget {
  const IndividualAnimalBehaviourScreen({super.key});

  @override
  State<IndividualAnimalBehaviourScreen> createState() =>
      _IndividualAnimalBehaviourScreenState();
}

class _IndividualAnimalBehaviourScreenState
    extends State<IndividualAnimalBehaviourScreen> {
  // Replace with herd ID from auth/navigation context once auth flow is wired.
  static const _herdId = 'placeholder_herd_id';

  List<({AnimalData animal, BehaviourClassificationData? latest})> _rows = [];
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

    final rows = await Future.wait(
      animals.map((a) async {
        final latest = await repo.getLatestClassification(a.id);
        return (animal: a, latest: latest);
      }),
    );

    if (mounted) setState(() { _rows = rows; _loading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animal Behaviour')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _rows.isEmpty
              ? const Center(child: Text('No animals in this herd'))
              : RefreshIndicator(
                  onRefresh: _load,
                  child: ListView.separated(
                    itemCount: _rows.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final r = _rows[i];
                      final label = r.animal.name ??
                          'Animal ${r.animal.id.substring(0, 8)}';
                      return ListTile(
                        title: Text(label),
                        subtitle: Text(
                          r.animal.species,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        trailing: r.latest != null
                            ? BehaviourStatusChip(
                                behaviourClass: r.latest!.behaviourClass,
                              )
                            : const Text(
                                'No data',
                                style: TextStyle(color: Colors.grey),
                              ),
                      );
                    },
                  ),
                ),
    );
  }
}
