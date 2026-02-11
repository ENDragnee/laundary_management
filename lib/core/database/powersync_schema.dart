import 'package:powersync/powersync.dart';

const schema = Schema([
  // 1. ENSURE THIS TABLE EXISTS
  Table('laundries', [
    Column.text('name'),
    Column.text('phone_number'),
    Column.text('tier'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  // 2. Your Orders Table
  Table('orders', [
    Column.text('laundry_id'),
    Column.text('customer_name'),
    Column.text('phone_number'),
    Column.text('code'),
    Column.text('clothes'),
    Column.real('total_price'),
    Column.text('status'),
    Column.text('due_date'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
]);
