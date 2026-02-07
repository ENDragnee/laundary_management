import 'package:drift/drift.dart';

@DataClassName('LaundryOrder')
class LaundryOrders extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get customerName => text()();
  TextColumn get phoneNumber => text()();
  TextColumn get clothes => text()(); // Will be stored as a JSON string
  DateTimeColumn get dueDate => dateTime()();
  RealColumn get totalPrice => real()();
  TextColumn get code => text().unique()();
  IntColumn get status => integer().withDefault(const Constant(0))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
}
