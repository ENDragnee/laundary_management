import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:laundary_management/core/database/laundry_orders.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

@DriftDatabase(tables: [LaundryOrders])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // C R U D Operations

  // READ ALL: Watch all orders, sorted by creation date
  Stream<List<LaundryOrder>> watchAllOrders() {
    return (select(laundryOrders)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
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
