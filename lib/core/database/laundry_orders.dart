import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

@DataClassName('LaundryOrder')
class LaundryOrders extends Table {
  @override
  String get tableName => 'orders';

  TextColumn get id => text().clientDefault(() => Uuid().v4())();

  TextColumn get laundryId => text()();

  TextColumn get customerName => text()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get code => text()();
  TextColumn get clothes => text()();
  RealColumn get totalPrice => real()();

  IntColumn get status => integer().withDefault(const Constant(0))();

  DateTimeColumn get dueDate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
