import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';

import 'data/database/app_database.dart';
import 'data/receipt_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extractly',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const DbTestScreen(),
    );
  }
}

/// TEMPORARY: proves the database + repository work end to end.
/// Replaced by the real Home screen in Phase 4.
class DbTestScreen extends StatefulWidget {
  const DbTestScreen({super.key});

  @override
  State<DbTestScreen> createState() => _DbTestScreenState();
}

class _DbTestScreenState extends State<DbTestScreen> {
  late final AppDatabase _db;
  late final ReceiptRepository _repo;

  List<Receipt> _receipts = [];
  String _status = 'Ready';

  @override
  void initState() {
    super.initState();
    _db = AppDatabase();
    _repo = ReceiptRepository(_db);
    _load();
  }

  @override
  void dispose() {
    _db.close();
    super.dispose();
  }

  Future<void> _load() async {
    final rows = await _repo.getAllReceipts();
    setState(() => _receipts = rows);
  }

  Future<void> _addSample() async {
    final id = await _repo.saveReceipt(
      receipt: ReceiptsCompanion.insert(
        merchantName: const Value('Sample Cafe'),
        currency: const Value('LKR'),
        date: Value(DateTime.now().toIso8601String().substring(0, 10)),
        total: const Value(1450.00),
      ),
      items: [
        ReceiptItemsCompanion.insert(
          receiptId: 0, // overwritten inside the transaction
          description: 'Cappuccino',
          quantity: const Value(2),
          unitPrice: const Value(650),
          total: const Value(1300),
        ),
        ReceiptItemsCompanion.insert(
          receiptId: 0,
          description: 'Service charge',
          total: const Value(150),
        ),
      ],
    );
    setState(() => _status = 'Saved receipt #$id');
    await _load();
  }

  Future<void> _clear() async {
    for (final r in _receipts) {
      await _repo.deleteReceipt(r.id);
    }
    setState(() => _status = 'Cleared all');
    await _load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Extractly — DB test')),
      body: Column(
        children: [
          Padding(padding: const EdgeInsets.all(12), child: Text(_status)),
          Expanded(
            child: _receipts.isEmpty
                ? const Center(
                    child: Text('No receipts yet. Tap + to add one.'),
                  )
                : ListView.builder(
                    itemCount: _receipts.length,
                    itemBuilder: (context, i) {
                      final r = _receipts[i];
                      return ListTile(
                        title: Text(r.merchantName ?? '(no name)'),
                        subtitle: Text('${r.date ?? "?"} · #${r.id}'),
                        trailing: Text(
                          '${r.currency ?? ""} ${r.total?.toStringAsFixed(2) ?? "-"}',
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'clear',
            onPressed: _clear,
            label: const Text('Clear'),
            icon: const Icon(Icons.delete_outline),
          ),
          const SizedBox(width: 12),
          FloatingActionButton.extended(
            heroTag: 'add',
            onPressed: _addSample,
            label: const Text('Add sample'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
