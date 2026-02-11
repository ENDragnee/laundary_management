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

  // ==========================================
  // LAUNDRY ORDERS CRUD
  // ==========================================

  Stream<List<LaundryOrder>> watchAllOrders() {
    return (select(laundryOrders)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  /// Paginated Query with Offset
  Stream<List<LaundryOrder>> watchOrdersPaged({
    required int limit,
    required int offset,
    OrderStatus? filterStatus,
    bool sortDescending = true,
  }) {
    final query = select(laundryOrders);

    if (filterStatus != null) {
      query.where((t) => t.status.equalsValue(filterStatus));
    }

    query.orderBy([
      (t) => OrderingTerm(
        expression: t.dueDate,
        mode: sortDescending ? OrderingMode.desc : OrderingMode.asc,
      ),
    ]);

    query.limit(limit, offset: offset);
    return query.watch();
  }

  /// Get the total count of orders for a specific filter using selectOnly
  Stream<int> watchOrderCount(OrderStatus? filterStatus) {
    // Define the count expression
    final countAmount = laundryOrders.id.count();
    
    // Create a selectOnly statement (more efficient for aggregates)
    final query = selectOnly(laundryOrders)..addColumns([countAmount]);

    if (filterStatus != null) {
      query.where(laundryOrders.status.equalsValue(filterStatus));
    }

    // Map the result row to an integer
    return query.map((row) => row.read(countAmount) ?? 0).watchSingle();
  }

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

  Future<int> addOrder(LaundryOrdersCompanion entry) {
    return into(laundryOrders).insert(entry);
  }

  Future<bool> updateOrder(LaundryOrdersCompanion entry) {
    return update(laundryOrders).replace(entry);
  }

  Future<int> deleteOrder(String id) {
    return (delete(laundryOrders)..where((tbl) => tbl.id.equals(id))).go();
  }

  // ==========================================
  // LAUNDRY PROFILE
  // ==========================================

  Future<Laundry?> getLaundryProfile(String userId) {
    return (select(laundries)..where((t) => t.id.equals(userId)))
        .getSingleOrNull();
  }

  Stream<Laundry?> watchLaundryProfile(String userId) {
    return (select(laundries)..where((t) => t.id.equals(userId)))
        .watchSingleOrNull();
  }

  Future<bool> updateLaundryProfile(LaundriesCompanion entry) {
    return update(laundries).replace(entry);
  }
}
