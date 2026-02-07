import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
// The import for order_status is NOT needed here, so it has been removed.
import 'package:laundary_management/core/database/laundry_orders.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [LaundryOrders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2; // Version bumped to 2

  // CORRECTED MIGRATION STRATEGY
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // This block runs when upgrading from version 1 to 2.
          await m.addColumn(laundryOrders, laundryOrders.status);
        }
      },
    );
  }

  // C R U D Operations

  // READ ALL: Watch all orders, sorted by creation date
  Stream<List<LaundryOrder>> watchAllOrders() {
    return (select(laundryOrders)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  // SEARCH: Find orders by name, phone, or code
  Stream<List<LaundryOrder>> searchOrders(String query) {
    if (query.isEmpty) {
      // Return all orders if search is empty, to be more user-friendly
      return watchAllOrders();
    }
    return (select(laundryOrders)..where(
          (tbl) =>
              tbl.customerName.like('%$query%') |
              tbl.phoneNumber.like('%$query%') |
              tbl.code.like('%$query%'),
        ))
        .watch();
  }

  // CREATE: Add a new order
  Future<int> addOrder(LaundryOrdersCompanion entry) {
    return into(laundryOrders).insert(entry);
  }

  // UPDATE: Update an existing order
  Future<bool> updateOrder(LaundryOrdersCompanion entry) {
    return update(laundryOrders).replace(entry);
  }

  // DELETE: Delete an order by its id
  Future<int> deleteOrder(int id) {
    return (delete(laundryOrders)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'laundry.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
