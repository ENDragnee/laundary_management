import 'package:powersync/powersync.dart';

// Key Point: This schema MUST match the SQL tables you created in Supabase.
const schema = Schema([
  Table('laundries', [
    Column.text('name'),
    Column.text('phone_number'),
    Column.text('tier'), // TRIAL, REGULAR, PREMIUM
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  Table('orders', [
    Column.text('laundry_id'),
    Column.text('customer_name'),
    Column.text('phone_number'),
    Column.text('code'),
    Column.text('clothes'), // Stored as JSON string
    Column.real('total_price'),
    Column.integer('status'),
    Column.text('due_date'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
]);
