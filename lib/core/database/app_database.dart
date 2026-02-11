import 'package:drift/drift.dart';
import 'package:drift_sqlite_async/drift_sqlite_async.dart';
import 'package:laundary_management/core/constants/order_status.dart';
import 'package:laundary_management/core/database/laundry_orders.dart';
import 'package:powersync/powersync.dart' as ps;
import 'package:uuid/uuid.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [LaundryOrders, Laundries])
class AppDatabase extends _$AppDatabase {
  AppDatabase(ps.PowerSyncDatabase db) : super(SqliteAsyncDriftConnection(db));

  @override
  int get schemaVersion => 1;

  Stream<List<LaundryOrder>> watchAllOrders() {
    return (select(laundryOrders)..orderBy([
          (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
        ]))
        .watch();
  }

  /// Real-time search across customer name, phone, and order code
  Stream<List<LaundryOrder>> searchOrders(String query) {
    final sanitizedQuery = query.trim();
    if (sanitizedQuery.isEmpty) return watchAllOrders();

    final term = '%$sanitizedQuery%';
    return (select(laundryOrders)
          ..where(
            (tbl) =>
                tbl.customerName.like(term) |
                tbl.phoneNumber.like(term) |
                tbl.code.like(term),
          )
          ..orderBy([
            (t) =>
                OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Create a new order. PowerSync handles the background upload to Supabase.
  Future<void> addOrder(LaundryOrdersCompanion entry) {
    return into(laundryOrders).insert(entry);
  }

  /// Update an existing order.
  Future<bool> updateOrder(LaundryOrdersCompanion entry) {
    return update(laundryOrders).replace(entry);
  }

  /// Delete an order by UUID.
  Future<int> deleteOrder(String id) {
    return (delete(laundryOrders)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<Laundry?> getLaundryProfile(String userId) {
    return (select(
      laundries,
    )..where((t) => t.id.equals(userId))).getSingleOrNull();
  }

  /// Watch the laundry profile for real-time Tier updates (e.g., TRIAL -> REGULAR)
  Stream<Laundry?> watchLaundryProfile(String userId) {
    return (select(
      laundries,
    )..where((t) => t.id.equals(userId))).watchSingleOrNull();
  }

  /// Update the shop profile (used during Onboarding)
  Future<bool> updateLaundryProfile(LaundriesCompanion entry) {
    return update(laundries).replace(entry);
  }
}
