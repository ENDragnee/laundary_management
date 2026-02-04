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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'laundry.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}