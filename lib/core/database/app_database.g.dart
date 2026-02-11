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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    clientDefault: () => Uuid().v4(),
  );
  static const VerificationMeta _laundryIdMeta = const VerificationMeta(
    'laundryId',
  );
  @override
  late final GeneratedColumn<String> laundryId = GeneratedColumn<String>(
    'laundry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
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
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<String> dueDate = GeneratedColumn<String>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    laundryId,
    customerName,
    phoneNumber,
    code,
    clothes,
    totalPrice,
    status,
    dueDate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'orders';
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
    if (data.containsKey('laundry_id')) {
      context.handle(
        _laundryIdMeta,
        laundryId.isAcceptableOrUnknown(data['laundry_id']!, _laundryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_laundryIdMeta);
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
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('clothes')) {
      context.handle(
        _clothesMeta,
        clothes.isAcceptableOrUnknown(data['clothes']!, _clothesMeta),
      );
    } else if (isInserting) {
      context.missing(_clothesMeta);
    }
    if (data.containsKey('total_price')) {
      context.handle(
        _totalPriceMeta,
        totalPrice.isAcceptableOrUnknown(data['total_price']!, _totalPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_totalPriceMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
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
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      laundryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}laundry_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      clothes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clothes'],
      )!,
      totalPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_price'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}status'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}due_date'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
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
  final String id;
  final String laundryId;
  final String customerName;
  final String? phoneNumber;
  final String code;
  final String clothes;
  final double totalPrice;
  final int status;
  final String dueDate;
  final String createdAt;
  final String updatedAt;
  const LaundryOrder({
    required this.id,
    required this.laundryId,
    required this.customerName,
    this.phoneNumber,
    required this.code,
    required this.clothes,
    required this.totalPrice,
    required this.status,
    required this.dueDate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['laundry_id'] = Variable<String>(laundryId);
    map['customer_name'] = Variable<String>(customerName);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['code'] = Variable<String>(code);
    map['clothes'] = Variable<String>(clothes);
    map['total_price'] = Variable<double>(totalPrice);
    map['status'] = Variable<int>(status);
    map['due_date'] = Variable<String>(dueDate);
    map['created_at'] = Variable<String>(createdAt);
    map['updated_at'] = Variable<String>(updatedAt);
    return map;
  }

  LaundryOrdersCompanion toCompanion(bool nullToAbsent) {
    return LaundryOrdersCompanion(
      id: Value(id),
      laundryId: Value(laundryId),
      customerName: Value(customerName),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      code: Value(code),
      clothes: Value(clothes),
      totalPrice: Value(totalPrice),
      status: Value(status),
      dueDate: Value(dueDate),
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
      id: serializer.fromJson<String>(json['id']),
      laundryId: serializer.fromJson<String>(json['laundryId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      code: serializer.fromJson<String>(json['code']),
      clothes: serializer.fromJson<String>(json['clothes']),
      totalPrice: serializer.fromJson<double>(json['totalPrice']),
      status: serializer.fromJson<int>(json['status']),
      dueDate: serializer.fromJson<String>(json['dueDate']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'laundryId': serializer.toJson<String>(laundryId),
      'customerName': serializer.toJson<String>(customerName),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'code': serializer.toJson<String>(code),
      'clothes': serializer.toJson<String>(clothes),
      'totalPrice': serializer.toJson<double>(totalPrice),
      'status': serializer.toJson<int>(status),
      'dueDate': serializer.toJson<String>(dueDate),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  LaundryOrder copyWith({
    String? id,
    String? laundryId,
    String? customerName,
    Value<String?> phoneNumber = const Value.absent(),
    String? code,
    String? clothes,
    double? totalPrice,
    int? status,
    String? dueDate,
    String? createdAt,
    String? updatedAt,
  }) => LaundryOrder(
    id: id ?? this.id,
    laundryId: laundryId ?? this.laundryId,
    customerName: customerName ?? this.customerName,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    code: code ?? this.code,
    clothes: clothes ?? this.clothes,
    totalPrice: totalPrice ?? this.totalPrice,
    status: status ?? this.status,
    dueDate: dueDate ?? this.dueDate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LaundryOrder copyWithCompanion(LaundryOrdersCompanion data) {
    return LaundryOrder(
      id: data.id.present ? data.id.value : this.id,
      laundryId: data.laundryId.present ? data.laundryId.value : this.laundryId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      code: data.code.present ? data.code.value : this.code,
      clothes: data.clothes.present ? data.clothes.value : this.clothes,
      totalPrice: data.totalPrice.present
          ? data.totalPrice.value
          : this.totalPrice,
      status: data.status.present ? data.status.value : this.status,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LaundryOrder(')
          ..write('id: $id, ')
          ..write('laundryId: $laundryId, ')
          ..write('customerName: $customerName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('code: $code, ')
          ..write('clothes: $clothes, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    laundryId,
    customerName,
    phoneNumber,
    code,
    clothes,
    totalPrice,
    status,
    dueDate,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LaundryOrder &&
          other.id == this.id &&
          other.laundryId == this.laundryId &&
          other.customerName == this.customerName &&
          other.phoneNumber == this.phoneNumber &&
          other.code == this.code &&
          other.clothes == this.clothes &&
          other.totalPrice == this.totalPrice &&
          other.status == this.status &&
          other.dueDate == this.dueDate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LaundryOrdersCompanion extends UpdateCompanion<LaundryOrder> {
  final Value<String> id;
  final Value<String> laundryId;
  final Value<String> customerName;
  final Value<String?> phoneNumber;
  final Value<String> code;
  final Value<String> clothes;
  final Value<double> totalPrice;
  final Value<int> status;
  final Value<String> dueDate;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  final Value<int> rowid;
  const LaundryOrdersCompanion({
    this.id = const Value.absent(),
    this.laundryId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.code = const Value.absent(),
    this.clothes = const Value.absent(),
    this.totalPrice = const Value.absent(),
    this.status = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LaundryOrdersCompanion.insert({
    this.id = const Value.absent(),
    required String laundryId,
    required String customerName,
    this.phoneNumber = const Value.absent(),
    required String code,
    required String clothes,
    required double totalPrice,
    this.status = const Value.absent(),
    required String dueDate,
    required String createdAt,
    required String updatedAt,
    this.rowid = const Value.absent(),
  }) : laundryId = Value(laundryId),
       customerName = Value(customerName),
       code = Value(code),
       clothes = Value(clothes),
       totalPrice = Value(totalPrice),
       dueDate = Value(dueDate),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<LaundryOrder> custom({
    Expression<String>? id,
    Expression<String>? laundryId,
    Expression<String>? customerName,
    Expression<String>? phoneNumber,
    Expression<String>? code,
    Expression<String>? clothes,
    Expression<double>? totalPrice,
    Expression<int>? status,
    Expression<String>? dueDate,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (laundryId != null) 'laundry_id': laundryId,
      if (customerName != null) 'customer_name': customerName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (code != null) 'code': code,
      if (clothes != null) 'clothes': clothes,
      if (totalPrice != null) 'total_price': totalPrice,
      if (status != null) 'status': status,
      if (dueDate != null) 'due_date': dueDate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LaundryOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? laundryId,
    Value<String>? customerName,
    Value<String?>? phoneNumber,
    Value<String>? code,
    Value<String>? clothes,
    Value<double>? totalPrice,
    Value<int>? status,
    Value<String>? dueDate,
    Value<String>? createdAt,
    Value<String>? updatedAt,
    Value<int>? rowid,
  }) {
    return LaundryOrdersCompanion(
      id: id ?? this.id,
      laundryId: laundryId ?? this.laundryId,
      customerName: customerName ?? this.customerName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      code: code ?? this.code,
      clothes: clothes ?? this.clothes,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      dueDate: dueDate ?? this.dueDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (laundryId.present) {
      map['laundry_id'] = Variable<String>(laundryId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (clothes.present) {
      map['clothes'] = Variable<String>(clothes.value);
    }
    if (totalPrice.present) {
      map['total_price'] = Variable<double>(totalPrice.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<String>(dueDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LaundryOrdersCompanion(')
          ..write('id: $id, ')
          ..write('laundryId: $laundryId, ')
          ..write('customerName: $customerName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('code: $code, ')
          ..write('clothes: $clothes, ')
          ..write('totalPrice: $totalPrice, ')
          ..write('status: $status, ')
          ..write('dueDate: $dueDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LaundriesTable extends Laundries
    with TableInfo<$LaundriesTable, Laundry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LaundriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tierMeta = const VerificationMeta('tier');
  @override
  late final GeneratedColumn<String> tier = GeneratedColumn<String>(
    'tier',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('TRIAL'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<String> createdAt = GeneratedColumn<String>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<String> updatedAt = GeneratedColumn<String>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    phoneNumber,
    tier,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'laundries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Laundry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('tier')) {
      context.handle(
        _tierMeta,
        tier.isAcceptableOrUnknown(data['tier']!, _tierMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Laundry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Laundry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      tier: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tier'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $LaundriesTable createAlias(String alias) {
    return $LaundriesTable(attachedDatabase, alias);
  }
}

class Laundry extends DataClass implements Insertable<Laundry> {
  final String id;
  final String? name;
  final String? phoneNumber;
  final String tier;
  final String? createdAt;
  final String? updatedAt;
  const Laundry({
    required this.id,
    this.name,
    this.phoneNumber,
    required this.tier,
    this.createdAt,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    map['tier'] = Variable<String>(tier);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  LaundriesCompanion toCompanion(bool nullToAbsent) {
    return LaundriesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      tier: Value(tier),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Laundry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Laundry(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      tier: serializer.fromJson<String>(json['tier']),
      createdAt: serializer.fromJson<String?>(json['createdAt']),
      updatedAt: serializer.fromJson<String?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'tier': serializer.toJson<String>(tier),
      'createdAt': serializer.toJson<String?>(createdAt),
      'updatedAt': serializer.toJson<String?>(updatedAt),
    };
  }

  Laundry copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    String? tier,
    Value<String?> createdAt = const Value.absent(),
    Value<String?> updatedAt = const Value.absent(),
  }) => Laundry(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    tier: tier ?? this.tier,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  Laundry copyWithCompanion(LaundriesCompanion data) {
    return Laundry(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      tier: data.tier.present ? data.tier.value : this.tier,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Laundry(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('tier: $tier, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, phoneNumber, tier, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Laundry &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.tier == this.tier &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LaundriesCompanion extends UpdateCompanion<Laundry> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> phoneNumber;
  final Value<String> tier;
  final Value<String?> createdAt;
  final Value<String?> updatedAt;
  final Value<int> rowid;
  const LaundriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.tier = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LaundriesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.tier = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<Laundry> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? tier,
    Expression<String>? createdAt,
    Expression<String>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (tier != null) 'tier': tier,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LaundriesCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? phoneNumber,
    Value<String>? tier,
    Value<String?>? createdAt,
    Value<String?>? updatedAt,
    Value<int>? rowid,
  }) {
    return LaundriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      tier: tier ?? this.tier,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (tier.present) {
      map['tier'] = Variable<String>(tier.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LaundriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('tier: $tier, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LaundryOrdersTable laundryOrders = $LaundryOrdersTable(this);
  late final $LaundriesTable laundries = $LaundriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    laundryOrders,
    laundries,
  ];
}

typedef $$LaundryOrdersTableCreateCompanionBuilder =
    LaundryOrdersCompanion Function({
      Value<String> id,
      required String laundryId,
      required String customerName,
      Value<String?> phoneNumber,
      required String code,
      required String clothes,
      required double totalPrice,
      Value<int> status,
      required String dueDate,
      required String createdAt,
      required String updatedAt,
      Value<int> rowid,
    });
typedef $$LaundryOrdersTableUpdateCompanionBuilder =
    LaundryOrdersCompanion Function({
      Value<String> id,
      Value<String> laundryId,
      Value<String> customerName,
      Value<String?> phoneNumber,
      Value<String> code,
      Value<String> clothes,
      Value<double> totalPrice,
      Value<int> status,
      Value<String> dueDate,
      Value<String> createdAt,
      Value<String> updatedAt,
      Value<int> rowid,
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
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get laundryId => $composableBuilder(
    column: $table.laundryId,
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

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clothes => $composableBuilder(
    column: $table.clothes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
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
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get laundryId => $composableBuilder(
    column: $table.laundryId,
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

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clothes => $composableBuilder(
    column: $table.clothes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get laundryId =>
      $composableBuilder(column: $table.laundryId, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get clothes =>
      $composableBuilder(column: $table.clothes, builder: (column) => column);

  GeneratedColumn<double> get totalPrice => $composableBuilder(
    column: $table.totalPrice,
    builder: (column) => column,
  );

  GeneratedColumn<int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
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
                Value<String> id = const Value.absent(),
                Value<String> laundryId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> clothes = const Value.absent(),
                Value<double> totalPrice = const Value.absent(),
                Value<int> status = const Value.absent(),
                Value<String> dueDate = const Value.absent(),
                Value<String> createdAt = const Value.absent(),
                Value<String> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LaundryOrdersCompanion(
                id: id,
                laundryId: laundryId,
                customerName: customerName,
                phoneNumber: phoneNumber,
                code: code,
                clothes: clothes,
                totalPrice: totalPrice,
                status: status,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                required String laundryId,
                required String customerName,
                Value<String?> phoneNumber = const Value.absent(),
                required String code,
                required String clothes,
                required double totalPrice,
                Value<int> status = const Value.absent(),
                required String dueDate,
                required String createdAt,
                required String updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => LaundryOrdersCompanion.insert(
                id: id,
                laundryId: laundryId,
                customerName: customerName,
                phoneNumber: phoneNumber,
                code: code,
                clothes: clothes,
                totalPrice: totalPrice,
                status: status,
                dueDate: dueDate,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
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
typedef $$LaundriesTableCreateCompanionBuilder =
    LaundriesCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> phoneNumber,
      Value<String> tier,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });
typedef $$LaundriesTableUpdateCompanionBuilder =
    LaundriesCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> phoneNumber,
      Value<String> tier,
      Value<String?> createdAt,
      Value<String?> updatedAt,
      Value<int> rowid,
    });

class $$LaundriesTableFilterComposer
    extends Composer<_$AppDatabase, $LaundriesTable> {
  $$LaundriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LaundriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LaundriesTable> {
  $$LaundriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tier => $composableBuilder(
    column: $table.tier,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LaundriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LaundriesTable> {
  $$LaundriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tier =>
      $composableBuilder(column: $table.tier, builder: (column) => column);

  GeneratedColumn<String> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LaundriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LaundriesTable,
          Laundry,
          $$LaundriesTableFilterComposer,
          $$LaundriesTableOrderingComposer,
          $$LaundriesTableAnnotationComposer,
          $$LaundriesTableCreateCompanionBuilder,
          $$LaundriesTableUpdateCompanionBuilder,
          (Laundry, BaseReferences<_$AppDatabase, $LaundriesTable, Laundry>),
          Laundry,
          PrefetchHooks Function()
        > {
  $$LaundriesTableTableManager(_$AppDatabase db, $LaundriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LaundriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LaundriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LaundriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LaundriesCompanion(
                id: id,
                name: name,
                phoneNumber: phoneNumber,
                tier: tier,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String> tier = const Value.absent(),
                Value<String?> createdAt = const Value.absent(),
                Value<String?> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LaundriesCompanion.insert(
                id: id,
                name: name,
                phoneNumber: phoneNumber,
                tier: tier,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LaundriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LaundriesTable,
      Laundry,
      $$LaundriesTableFilterComposer,
      $$LaundriesTableOrderingComposer,
      $$LaundriesTableAnnotationComposer,
      $$LaundriesTableCreateCompanionBuilder,
      $$LaundriesTableUpdateCompanionBuilder,
      (Laundry, BaseReferences<_$AppDatabase, $LaundriesTable, Laundry>),
      Laundry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LaundryOrdersTableTableManager get laundryOrders =>
      $$LaundryOrdersTableTableManager(_db, _db.laundryOrders);
  $$LaundriesTableTableManager get laundries =>
      $$LaundriesTableTableManager(_db, _db.laundries);
}
