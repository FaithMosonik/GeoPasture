import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/app_database.dart';
import 'connectivity_monitor.dart';
import 'mock_sync_service.dart';
import 'sync_repository.dart';

/// Demo screen that proves offline-first functionality works.
class OfflineDemoScreen extends StatefulWidget {
  const OfflineDemoScreen({super.key});

  @override
  State<OfflineDemoScreen> createState() => _OfflineDemoScreenState();
}

class _OfflineDemoScreenState extends State<OfflineDemoScreen>
    with SingleTickerProviderStateMixin {
  late final MockSyncService _mockSync;
  late final ConnectivityMonitor _connectivity;
  late final TabController _tabController;

  List<BehaviourClassificationData> _records = [];
  List<PastureMapData> _pastureMaps = [];
  bool _isSyncing = false;
  bool _isDownloading = false;
  int _pendingCount = 0;
  String _syncMessage = '';

  bool _initialized = false;

@override
void initState() {
  super.initState();
  _tabController = TabController(length: 2, vsync: this);
}

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  if (_initialized) return;
  _initialized = true;

  final db = context.read<AppDatabase>();
  _connectivity = context.read<ConnectivityMonitor>();
  _mockSync = MockSyncService(
    db: db,
    repository: context.read<SyncRepository>(),
  );

  _loadData();
  _connectivity.statusStream.listen((_) {
    if (mounted) setState(() {});
  });
}
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final db = context.read<AppDatabase>();
    final records = await (db.select(db.behaviourClassification)
          ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
          ..limit(10))
        .get();
    final maps = await _mockSync.getCachedPastureMaps();
    final counts = await _mockSync.getPendingCounts();
    if (mounted) {
      setState(() {
        _records = records;
        _pastureMaps = maps;
        _pendingCount = counts.values.fold(0, (a, b) => a + b);
      });
    }
  }



  Future<void> _downloadPastureMaps() async {
    if (!_connectivity.isOnline) {
      setState(() => _syncMessage = 'Cannot download — device is offline');
      return;
    }
    setState(() { _isDownloading = true; _syncMessage = 'Downloading pasture maps...'; });
    await _mockSync.mockDownloadPastureMaps();
    await _loadData();
    if (mounted) setState(() { _isDownloading = false; _syncMessage = '2 pasture maps cached locally ✓'; });
  }

  Future<void> _runMockSync() async {
    if (!_connectivity.isOnline) {
      setState(() => _syncMessage = 'Cannot sync — device is offline');
      return;
    }
    setState(() { _isSyncing = true; _syncMessage = 'Uploading behaviour data...'; });
    final count = await _mockSync.mockUploadBehaviourClassifications();
    await _loadData();
    if (mounted) setState(() { _isSyncing = false; _syncMessage = count > 0 ? '$count records synced to cloud ✓' : 'Nothing to sync'; });
  }

  String _behaviourLabel(int index) {
    const labels = ['Grazing', 'Ruminating', 'Standing', 'Lying', 'Walking'];
    return index < labels.length ? labels[index] : 'Unknown';
  }

  Color _behaviourColor(int index) {
    const colors = [
      Color(0xFF2E7D32),
      Color(0xFF1565C0),
      Color(0xFFF57F17),
      Color(0xFF6A1B9A),
      Color(0xFFBF360C),
    ];
    return index < colors.length ? colors[index] : Colors.grey;
  }

  Color _conditionColor(String condition) {
    switch (condition.toLowerCase()) {
      case 'good':     return const Color(0xFF2E7D32);
      case 'moderate': return const Color(0xFFF57F17);
      case 'poor':     return const Color(0xFFB71C1C);
      default:         return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isOnline = _connectivity.isOnline;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        title: const Text('Offline-First Demo'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.pets, size: 16), text: 'Behaviour'),
            Tab(icon: Icon(Icons.grass, size: 16), text: 'Pasture Maps'),
          ],
        ),
      ),
      body: Column(
        children: [

          // ── Network status banner ────────────────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            color: isOnline ? const Color(0xFF2E7D32) : const Color(0xFFF57F17),
            child: Row(
              children: [
                Icon(isOnline ? Icons.wifi : Icons.wifi_off, color: Colors.white, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isOnline
                        ? 'Online — sync available'
                        : 'Offline — data served from local cache',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                  child: Text('$_pendingCount pending', style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
          ),

          // ── Action buttons ───────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
          
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isDownloading ? null : _downloadPastureMaps,
                        icon: _isDownloading
                            ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.download, size: 16),
                        label: Text(_isDownloading ? 'Downloading...' : 'Cache maps', style: const TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOnline ? const Color(0xFF00695C) : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isSyncing ? null : _runMockSync,
                        icon: _isSyncing
                            ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.cloud_upload, size: 16),
                        label: Text(_isSyncing ? 'Syncing...' : 'Sync up', style: const TextStyle(fontSize: 12)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isOnline ? const Color(0xFF2E7D32) : Colors.grey,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_syncMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      _syncMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: _syncMessage.contains('✓')
                            ? const Color(0xFF2E7D32)
                            : const Color(0xFFE65100),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // ── Tab content ──────────────────────────────────────────────
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [

                // ── Tab 1: Behaviour records ───────────────────────────
                _records.isEmpty
                    ? _emptyState('No behaviour records yet\nUse the app normally to generate data')
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: _records.length,
                        itemBuilder: (context, index) {
                          final r = _records[index];
                          final label = _behaviourLabel(r.behaviourClass);
                          final color = _behaviourColor(r.behaviourClass);
                          final confidence = (r.confidence * 100).toStringAsFixed(0);
                          final isSynced = r.synced == 1;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Row(
                              children: [
                                Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: color)),
                                      Text('Confidence: $confidence%  •  Stored locally in SQLite', style: const TextStyle(fontSize: 11, color: Color(0xFF757575))),
                                    ],
                                  ),
                                ),
                                _syncBadge(isSynced),
                              ],
                            ),
                          );
                        },
                      ),

                // ── Tab 2: Pasture maps ────────────────────────────────
                _pastureMaps.isEmpty
                    ? _emptyState('No pasture maps cached\nGo online and tap "Cache maps" to download')
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        itemCount: _pastureMaps.length,
                        itemBuilder: (context, index) {
                          final map = _pastureMaps[index];
                          final condColor = _conditionColor(map.condition);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: const Color(0xFFE0E0E0)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(child: Text(map.region, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14))),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: condColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(map.condition.toUpperCase(), style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: condColor)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                _mapDetail('NDVI Score', map.ndviScore.toStringAsFixed(2)),
                                _mapDetail('Biomass', '${map.biomassKgPerHa.toStringAsFixed(0)} kg/ha'),
                                _mapDetail('Carrying Capacity', '${map.carryingCapacity ?? 0} animals'),
                                _mapDetail('Sustainable for', '${map.durationDays ?? 0} days'),
                                const SizedBox(height: 4),
                                const Text('✓ Cached locally — available offline', style: TextStyle(fontSize: 10, color: Color(0xFF2E7D32), fontWeight: FontWeight.w500)),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _emptyState(String message) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.inbox, size: 48, color: Color(0xFFBDBDBD)),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 13)),
      ],
    ),
  );

  Widget _syncBadge(bool isSynced) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: isSynced ? const Color(0xFFE8F5E9) : const Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      isSynced ? '✓ Synced' : '⏳ Pending',
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: isSynced ? const Color(0xFF2E7D32) : const Color(0xFFE65100)),
    ),
  );

  Widget _mapDetail(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom: 2),
    child: Row(
      children: [
        Text('$label: ', style: const TextStyle(fontSize: 11, color: Color(0xFF757575))),
        Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Color(0xFF424242))),
      ],
    ),
  );
}