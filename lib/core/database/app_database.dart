import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:laundary_management/core/database/laundry_orders.dart';
import 'package:powersync/powersync.dart' as ps;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [LaundryOrders])
class AppDatabase extends _$AppDatabase {
  AppDatabase(ps.PowerSyncDatabase db) : super(SqliteAsyncDriftConnection(db));

  @override
  int get schemaVersion => 1;

  // --- CRUD Operations ---
  Stream<List<LaundryOrder>> watchAllOrders() {
    return (select(laundryOrders)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  Stream<List<LaundryOrder>> searchOrders(String query) {
    if (query.isEmpty) return watchAllOrders();
    return (select(laundryOrders)..where(
          (tbl) =>
              tbl.customerName.like('%$query%') |
              tbl.phoneNumber.like('%$query%') |
              tbl.code.like('%$query%'),
        ))
        .watch();
  }

  Future<int> addOrder(LaundryOrdersCompanion entry) {
    return into(laundryOrders).insert(entry);
  }

  Future<bool> updateOrder(LaundryOrdersCompanion entry) {
    return update(laundryOrders).replace(entry);
  }

  Future<int> deleteOrder(String id) {
    return (delete(laundryOrders)..where((tbl) => tbl.id.equals(id))).go();
  }
}
