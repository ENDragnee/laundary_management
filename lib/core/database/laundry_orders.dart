import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('LaundryOrder')
class LaundryOrders extends Table {
  @override
  String get tableName => 'orders';

  TextColumn get id => text().clientDefault(() => Uuid().v4())();
  TextColumn get laundryId => text().named('laundry_id')();
  TextColumn get customerName => text().named('customer_name')();
  TextColumn get phoneNumber => text().nullable().named('phone_number')();
  TextColumn get code => text()();
  TextColumn get clothes => text()();
  RealColumn get totalPrice => real().named('total_price')();
  IntColumn get status => integer().withDefault(const Constant(0))();

  // CHANGE: Use TextColumn for dates to match ISO8601 Supabase format
  TextColumn get dueDate => text().named('due_date')();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Laundry')
class Laundries extends Table {
  @override
  String get tableName => 'laundries';

  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get phoneNumber => text().nullable().named('phone_number')();
  TextColumn get tier => text().withDefault(const Constant('TRIAL'))();

  // CHANGE: Use TextColumn for dates
  TextColumn get createdAt => text().nullable().named('created_at')();
  TextColumn get updatedAt => text().nullable().named('updated_at')();

  @override
  Set<Column> get primaryKey => {id};
}
