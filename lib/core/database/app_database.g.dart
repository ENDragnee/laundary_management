// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $LaundryOrdersTable extends LaundryOrders
    with TableInfo<$LaundryOrdersTable, LaundryOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LaundryOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _clothesMeta = const VerificationMeta(
    'clothes',
  );
  @override
  late final GeneratedColumn<String> clothes = GeneratedColumn<String>(
    'clothes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPriceMeta = const VerificationMeta(
    'totalPrice',
  );
  @override
  late final GeneratedColumn<double> totalPrice = GeneratedColumn<double>(
    'total_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    customerName,
    phoneNumber,
    clothes,
    dueDate,
    totalPrice,
    code,
    status,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'laundry_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<LaundryOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_phoneNumberMeta);
    }
    if (data.containsKey('clothes')) {
      context.handle(
        _clothesMeta,
        clothes.isAcceptableOrUnknown(data['clothes']!, _clothesMeta),
      );
    } else if (isInserting) {
      context.missing(_clothesMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LaundryOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LaundryOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      clothes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clothes'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LaundryOrdersTable createAlias(String alias) {
    return $LaundryOrdersTable(attachedDatabase, alias);
  }
}

class LaundryOrder extends DataClass implements Insertable<LaundryOrder> {
  final int id;
  final String customerName;
  final String phoneNumber;
  final String clothes;
  final DateTime dueDate;
  final double totalPrice;
  final String code;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LaundryOrder({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.clothes,
    required this.dueDate,
    required this.totalPrice,
    required this.code,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['customer_name'] = Variable<String>(customerName);
    map['phone_number'] = Variable<String>(phoneNumber);
    map['clothes'] = Variable<String>(clothes);
    map['due_date'] = Variable<DateTime>(dueDate);
    map['total_price'] = Variable<double>(totalPrice);
    map['code'] = Variable<String>(code);
    map['status'] = Variable<int>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LaundryOrdersCompanion toCompanion(bool nullToAbsent) {
    return LaundryOrdersCompanion(
      id: Value(id),
      customerName: Value(customerName),
      phoneNumber: Value(phoneNumber),
      clothes: Value(clothes),
      dueDate: Value(dueDate),
      totalPrice: Value(totalPrice),
      code: Value(code),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LaundryOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LaundryOrder(
      id: serializer.fromJson<int>(json['id']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      clothes: serializer.fromJson<String>(json['clothes']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      code: serializer.fromJson<String>(json['code']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'customerName': serializer.toJson<String>(customerName),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'clothes': serializer.toJson<String>(clothes),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'code': serializer.toJson<String>(code),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LaundryOrder copyWith({
    int? id,
    String? customerName,
    String? phoneNumber,
    String? clothes,
    DateTime? dueDate,
    double? totalPrice,
    String? code,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LaundryOrder(
    id: id ?? this.id,
    customerName: customerName ?? this.customerName,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    clothes: clothes ?? this.clothes,
    dueDate: dueDate ?? this.dueDate,
    totalPrice: totalPrice ?? this.totalPrice,
    code: code ?? this.code,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LaundryOrder copyWithCompanion(LaundryOrdersCompanion data) {
    return LaundryOrder(
      id: data.id.present ? data.id.value : this.id,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      clothes: data.clothes.present ? data.clothes.value : this.clothes,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      code: data.code.present ? data.code.value : this.code,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LaundryOrder(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('clothes: $clothes, ')
          ..write('dueDate: $dueDate, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('code: $code, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    customerName,
    phoneNumber,
    clothes,
    dueDate,
    totalPrice,
    code,
    status,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LaundryOrder &&
          other.id == this.id &&
          other.customerName == this.customerName &&
          other.phoneNumber == this.phoneNumber &&
          other.clothes == this.clothes &&
          other.dueDate == this.dueDate &&
          other.totalPrice == this.totalPrice &&
          other.code == this.code &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LaundryOrdersCompanion extends UpdateCompanion<LaundryOrder> {
  final Value<int> id;
  final Value<String> customerName;
  final Value<String> phoneNumber;
  final Value<String> clothes;
  final Value<DateTime> dueDate;
  final Value<double> totalPrice;
  final Value<String> code;
  final Value<int> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const LaundryOrdersCompanion({
    this.id = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.clothes = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.code = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  LaundryOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String customerName,
    required String phoneNumber,
    required String clothes,
    required DateTime dueDate,
    required double totalPrice,
    required String code,
    this.status = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : customerName = Value(customerName),
       phoneNumber = Value(phoneNumber),
       clothes = Value(clothes),
       dueDate = Value(dueDate),
       totalPrice = Value(totalPrice),
       code = Value(code),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LaundryOrder> custom({
    Expression<int>? id,
    Expression<String>? customerName,
    Expression<String>? phoneNumber,
    Expression<String>? clothes,
    Expression<DateTime>? dueDate,
    Expression<double>? totalPrice,
    Expression<String>? code,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (customerName != null) 'customer_name': customerName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (clothes != null) 'clothes': clothes,
      if (dueDate != null) 'due_date': dueDate,
      if (totalPrice != null) 'total_price': totalPrice,
      if (code != null) 'code': code,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  LaundryOrdersCompanion copyWith({
    Value<int>? id,
    Value<String>? customerName,
    Value<String>? phoneNumber,
    Value<String>? clothes,
    Value<DateTime>? dueDate,
    Value<double>? totalPrice,
    Value<String>? code,
    Value<int>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return LaundryOrdersCompanion(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      clothes: clothes ?? this.clothes,
      dueDate: dueDate ?? this.dueDate,
      totalPrice: totalPrice ?? this.totalPrice,
      code: code ?? this.code,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (clothes.present) {
      map['clothes'] = Variable<String>(clothes.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LaundryOrdersCompanion(')
          ..write('id: $id, ')
          ..write('customerName: $customerName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('clothes: $clothes, ')
          ..write('dueDate: $dueDate, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('code: $code, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LaundryOrdersTable laundryOrders = $LaundryOrdersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [laundryOrders];
}

typedef $$LaundryOrdersTableCreateCompanionBuilder =
    LaundryOrdersCompanion Function({
      Value<int> id,
      required String customerName,
      required String phoneNumber,
      required String clothes,
      required DateTime dueDate,
      required double totalPrice,
      required String code,
      Value<int> status,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$LaundryOrdersTableUpdateCompanionBuilder =
    LaundryOrdersCompanion Function({
      Value<int> id,
      Value<String> customerName,
      Value<String> phoneNumber,
      Value<String> clothes,
      Value<DateTime> dueDate,
      Value<double> totalPrice,
      Value<String> code,
      Value<int> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$LaundryOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $LaundryOrdersTable> {
  $$LaundryOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clothes => $composableBuilder(
    column: $table.clothes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LaundryOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $LaundryOrdersTable> {
  $$LaundryOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clothes => $composableBuilder(
    column: $table.clothes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LaundryOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LaundryOrdersTable> {
  $$LaundryOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clothes =>
      $composableBuilder(column: $table.clothes, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LaundryOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LaundryOrdersTable,
          LaundryOrder,
          $$LaundryOrdersTableFilterComposer,
          $$LaundryOrdersTableOrderingComposer,
          $$LaundryOrdersTableAnnotationComposer,
          $$LaundryOrdersTableCreateCompanionBuilder,
          $$LaundryOrdersTableUpdateCompanionBuilder,
          (
            LaundryOrder,
            BaseReferences<_$AppDatabase, $LaundryOrdersTable, LaundryOrder>,
          ),
          LaundryOrder,
          PrefetchHooks Function()
        > {
  $$LaundryOrdersTableTableManager(_$AppDatabase db, $LaundryOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LaundryOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LaundryOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LaundryOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String> clothes = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => LaundryOrdersCompanion(
                id: id,
                customerName: customerName,
                phoneNumber: phoneNumber,
                clothes: clothes,
                dueDate: dueDate,
                totalPrice: totalPrice,
                code: code,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String customerName,
                required String phoneNumber,
                required String clothes,
                required DateTime dueDate,
                required double totalPrice,
                required String code,
                Value<int> status = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => LaundryOrdersCompanion.insert(
                id: id,
                customerName: customerName,
                phoneNumber: phoneNumber,
                clothes: clothes,
                dueDate: dueDate,
                totalPrice: totalPrice,
                code: code,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LaundryOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LaundryOrdersTable,
      LaundryOrder,
      $$LaundryOrdersTableFilterComposer,
      $$LaundryOrdersTableOrderingComposer,
      $$LaundryOrdersTableAnnotationComposer,
      $$LaundryOrdersTableCreateCompanionBuilder,
      $$LaundryOrdersTableUpdateCompanionBuilder,
      (
        LaundryOrder,
        BaseReferences<_$AppDatabase, $LaundryOrdersTable, LaundryOrder>,
      ),
      LaundryOrder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LaundryOrdersTableTableManager get laundryOrders =>
      $$LaundryOrdersTableTableManager(_db, _db.laundryOrders);
}
