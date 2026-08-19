// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ReceiptsTable extends Receipts with TableInfo<$ReceiptsTable, Receipt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _merchantNameMeta = const VerificationMeta(
    'merchantName',
  );
  @override
  late final GeneratedColumn<String> merchantName = GeneratedColumn<String>(
    'merchant_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _merchantAddressMeta = const VerificationMeta(
    'merchantAddress',
  );
  @override
  late final GeneratedColumn<String> merchantAddress = GeneratedColumn<String>(
    'merchant_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _merchantPhoneMeta = const VerificationMeta(
    'merchantPhone',
  );
  @override
  late final GeneratedColumn<String> merchantPhone = GeneratedColumn<String>(
    'merchant_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<String> time = GeneratedColumn<String>(
    'time',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taxMeta = const VerificationMeta('tax');
  @override
  late final GeneratedColumn<double> tax = GeneratedColumn<double>(
    'tax',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<double> tip = GeneratedColumn<double>(
    'tip',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _needsReviewMeta = const VerificationMeta(
    'needsReview',
  );
  @override
  late final GeneratedColumn<bool> needsReview = GeneratedColumn<bool>(
    'needs_review',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("needs_review" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _imagePathMeta = const VerificationMeta(
    'imagePath',
  );
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
    'image_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    merchantName,
    merchantAddress,
    merchantPhone,
    currency,
    date,
    time,
    subtotal,
    tax,
    tip,
    total,
    paymentMethod,
    needsReview,
    imagePath,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Receipt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('merchant_name')) {
      context.handle(
        _merchantNameMeta,
        merchantName.isAcceptableOrUnknown(
          data['merchant_name']!,
          _merchantNameMeta,
        ),
      );
    }
    if (data.containsKey('merchant_address')) {
      context.handle(
        _merchantAddressMeta,
        merchantAddress.isAcceptableOrUnknown(
          data['merchant_address']!,
          _merchantAddressMeta,
        ),
      );
    }
    if (data.containsKey('merchant_phone')) {
      context.handle(
        _merchantPhoneMeta,
        merchantPhone.isAcceptableOrUnknown(
          data['merchant_phone']!,
          _merchantPhoneMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('tax')) {
      context.handle(
        _taxMeta,
        tax.isAcceptableOrUnknown(data['tax']!, _taxMeta),
      );
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('needs_review')) {
      context.handle(
        _needsReviewMeta,
        needsReview.isAcceptableOrUnknown(
          data['needs_review']!,
          _needsReviewMeta,
        ),
      );
    }
    if (data.containsKey('image_path')) {
      context.handle(
        _imagePathMeta,
        imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Receipt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Receipt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      merchantName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_name'],
      ),
      merchantAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_address'],
      ),
      merchantPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}merchant_phone'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      ),
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      ),
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}time'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      ),
      tax: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax'],
      ),
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tip'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      needsReview: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}needs_review'],
      )!,
      imagePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_path'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class Receipt extends DataClass implements Insertable<Receipt> {
  final int id;
  final String? merchantName;
  final String? merchantAddress;
  final String? merchantPhone;
  final String? currency;
  final String? date;
  final String? time;
  final double? subtotal;
  final double? tax;
  final double? tip;
  final double? total;
  final String? paymentMethod;

  /// True when totals don't reconcile or a core field was missing/low-confidence.
  final bool needsReview;

  /// Local file path of the captured photo (set in a later phase).
  final String? imagePath;

  /// When this receipt was saved on the device.
  final DateTime createdAt;
  const Receipt({
    required this.id,
    this.merchantName,
    this.merchantAddress,
    this.merchantPhone,
    this.currency,
    this.date,
    this.time,
    this.subtotal,
    this.tax,
    this.tip,
    this.total,
    this.paymentMethod,
    required this.needsReview,
    this.imagePath,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || merchantName != null) {
      map['merchant_name'] = Variable<String>(merchantName);
    }
    if (!nullToAbsent || merchantAddress != null) {
      map['merchant_address'] = Variable<String>(merchantAddress);
    }
    if (!nullToAbsent || merchantPhone != null) {
      map['merchant_phone'] = Variable<String>(merchantPhone);
    }
    if (!nullToAbsent || currency != null) {
      map['currency'] = Variable<String>(currency);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<String>(date);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<String>(time);
    }
    if (!nullToAbsent || subtotal != null) {
      map['subtotal'] = Variable<double>(subtotal);
    }
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<double>(tax);
    }
    if (!nullToAbsent || tip != null) {
      map['tip'] = Variable<double>(tip);
    }
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<double>(total);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    map['needs_review'] = Variable<bool>(needsReview);
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      merchantName: merchantName == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantName),
      merchantAddress: merchantAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantAddress),
      merchantPhone: merchantPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(merchantPhone),
      currency: currency == null && nullToAbsent
          ? const Value.absent()
          : Value(currency),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      subtotal: subtotal == null && nullToAbsent
          ? const Value.absent()
          : Value(subtotal),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
      tip: tip == null && nullToAbsent ? const Value.absent() : Value(tip),
      total: total == null && nullToAbsent
          ? const Value.absent()
          : Value(total),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      needsReview: Value(needsReview),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
      createdAt: Value(createdAt),
    );
  }

  factory Receipt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Receipt(
      id: serializer.fromJson<int>(json['id']),
      merchantName: serializer.fromJson<String?>(json['merchantName']),
      merchantAddress: serializer.fromJson<String?>(json['merchantAddress']),
      merchantPhone: serializer.fromJson<String?>(json['merchantPhone']),
      currency: serializer.fromJson<String?>(json['currency']),
      date: serializer.fromJson<String?>(json['date']),
      time: serializer.fromJson<String?>(json['time']),
      subtotal: serializer.fromJson<double?>(json['subtotal']),
      tax: serializer.fromJson<double?>(json['tax']),
      tip: serializer.fromJson<double?>(json['tip']),
      total: serializer.fromJson<double?>(json['total']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      needsReview: serializer.fromJson<bool>(json['needsReview']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'merchantName': serializer.toJson<String?>(merchantName),
      'merchantAddress': serializer.toJson<String?>(merchantAddress),
      'merchantPhone': serializer.toJson<String?>(merchantPhone),
      'currency': serializer.toJson<String?>(currency),
      'date': serializer.toJson<String?>(date),
      'time': serializer.toJson<String?>(time),
      'subtotal': serializer.toJson<double?>(subtotal),
      'tax': serializer.toJson<double?>(tax),
      'tip': serializer.toJson<double?>(tip),
      'total': serializer.toJson<double?>(total),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'needsReview': serializer.toJson<bool>(needsReview),
      'imagePath': serializer.toJson<String?>(imagePath),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Receipt copyWith({
    int? id,
    Value<String?> merchantName = const Value.absent(),
    Value<String?> merchantAddress = const Value.absent(),
    Value<String?> merchantPhone = const Value.absent(),
    Value<String?> currency = const Value.absent(),
    Value<String?> date = const Value.absent(),
    Value<String?> time = const Value.absent(),
    Value<double?> subtotal = const Value.absent(),
    Value<double?> tax = const Value.absent(),
    Value<double?> tip = const Value.absent(),
    Value<double?> total = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    bool? needsReview,
    Value<String?> imagePath = const Value.absent(),
    DateTime? createdAt,
  }) => Receipt(
    id: id ?? this.id,
    merchantName: merchantName.present ? merchantName.value : this.merchantName,
    merchantAddress: merchantAddress.present
        ? merchantAddress.value
        : this.merchantAddress,
    merchantPhone: merchantPhone.present
        ? merchantPhone.value
        : this.merchantPhone,
    currency: currency.present ? currency.value : this.currency,
    date: date.present ? date.value : this.date,
    time: time.present ? time.value : this.time,
    subtotal: subtotal.present ? subtotal.value : this.subtotal,
    tax: tax.present ? tax.value : this.tax,
    tip: tip.present ? tip.value : this.tip,
    total: total.present ? total.value : this.total,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    needsReview: needsReview ?? this.needsReview,
    imagePath: imagePath.present ? imagePath.value : this.imagePath,
    createdAt: createdAt ?? this.createdAt,
  );
  Receipt copyWithCompanion(ReceiptsCompanion data) {
    return Receipt(
      id: data.id.present ? data.id.value : this.id,
      merchantName: data.merchantName.present
          ? data.merchantName.value
          : this.merchantName,
      merchantAddress: data.merchantAddress.present
          ? data.merchantAddress.value
          : this.merchantAddress,
      merchantPhone: data.merchantPhone.present
          ? data.merchantPhone.value
          : this.merchantPhone,
      currency: data.currency.present ? data.currency.value : this.currency,
      date: data.date.present ? data.date.value : this.date,
      time: data.time.present ? data.time.value : this.time,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      tax: data.tax.present ? data.tax.value : this.tax,
      tip: data.tip.present ? data.tip.value : this.tip,
      total: data.total.present ? data.total.value : this.total,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      needsReview: data.needsReview.present
          ? data.needsReview.value
          : this.needsReview,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Receipt(')
          ..write('id: $id, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantAddress: $merchantAddress, ')
          ..write('merchantPhone: $merchantPhone, ')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('needsReview: $needsReview, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    merchantName,
    merchantAddress,
    merchantPhone,
    currency,
    date,
    time,
    subtotal,
    tax,
    tip,
    total,
    paymentMethod,
    needsReview,
    imagePath,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Receipt &&
          other.id == this.id &&
          other.merchantName == this.merchantName &&
          other.merchantAddress == this.merchantAddress &&
          other.merchantPhone == this.merchantPhone &&
          other.currency == this.currency &&
          other.date == this.date &&
          other.time == this.time &&
          other.subtotal == this.subtotal &&
          other.tax == this.tax &&
          other.tip == this.tip &&
          other.total == this.total &&
          other.paymentMethod == this.paymentMethod &&
          other.needsReview == this.needsReview &&
          other.imagePath == this.imagePath &&
          other.createdAt == this.createdAt);
}

class ReceiptsCompanion extends UpdateCompanion<Receipt> {
  final Value<int> id;
  final Value<String?> merchantName;
  final Value<String?> merchantAddress;
  final Value<String?> merchantPhone;
  final Value<String?> currency;
  final Value<String?> date;
  final Value<String?> time;
  final Value<double?> subtotal;
  final Value<double?> tax;
  final Value<double?> tip;
  final Value<double?> total;
  final Value<String?> paymentMethod;
  final Value<bool> needsReview;
  final Value<String?> imagePath;
  final Value<DateTime> createdAt;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.merchantAddress = const Value.absent(),
    this.merchantPhone = const Value.absent(),
    this.currency = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.needsReview = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    this.id = const Value.absent(),
    this.merchantName = const Value.absent(),
    this.merchantAddress = const Value.absent(),
    this.merchantPhone = const Value.absent(),
    this.currency = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.tax = const Value.absent(),
    this.tip = const Value.absent(),
    this.total = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.needsReview = const Value.absent(),
    this.imagePath = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  static Insertable<Receipt> custom({
    Expression<int>? id,
    Expression<String>? merchantName,
    Expression<String>? merchantAddress,
    Expression<String>? merchantPhone,
    Expression<String>? currency,
    Expression<String>? date,
    Expression<String>? time,
    Expression<double>? subtotal,
    Expression<double>? tax,
    Expression<double>? tip,
    Expression<double>? total,
    Expression<String>? paymentMethod,
    Expression<bool>? needsReview,
    Expression<String>? imagePath,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (merchantName != null) 'merchant_name': merchantName,
      if (merchantAddress != null) 'merchant_address': merchantAddress,
      if (merchantPhone != null) 'merchant_phone': merchantPhone,
      if (currency != null) 'currency': currency,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
      if (subtotal != null) 'subtotal': subtotal,
      if (tax != null) 'tax': tax,
      if (tip != null) 'tip': tip,
      if (total != null) 'total': total,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (needsReview != null) 'needs_review': needsReview,
      if (imagePath != null) 'image_path': imagePath,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ReceiptsCompanion copyWith({
    Value<int>? id,
    Value<String?>? merchantName,
    Value<String?>? merchantAddress,
    Value<String?>? merchantPhone,
    Value<String?>? currency,
    Value<String?>? date,
    Value<String?>? time,
    Value<double?>? subtotal,
    Value<double?>? tax,
    Value<double?>? tip,
    Value<double?>? total,
    Value<String?>? paymentMethod,
    Value<bool>? needsReview,
    Value<String?>? imagePath,
    Value<DateTime>? createdAt,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      merchantName: merchantName ?? this.merchantName,
      merchantAddress: merchantAddress ?? this.merchantAddress,
      merchantPhone: merchantPhone ?? this.merchantPhone,
      currency: currency ?? this.currency,
      date: date ?? this.date,
      time: time ?? this.time,
      subtotal: subtotal ?? this.subtotal,
      tax: tax ?? this.tax,
      tip: tip ?? this.tip,
      total: total ?? this.total,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      needsReview: needsReview ?? this.needsReview,
      imagePath: imagePath ?? this.imagePath,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (merchantName.present) {
      map['merchant_name'] = Variable<String>(merchantName.value);
    }
    if (merchantAddress.present) {
      map['merchant_address'] = Variable<String>(merchantAddress.value);
    }
    if (merchantPhone.present) {
      map['merchant_phone'] = Variable<String>(merchantPhone.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<String>(time.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (tax.present) {
      map['tax'] = Variable<double>(tax.value);
    }
    if (tip.present) {
      map['tip'] = Variable<double>(tip.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (needsReview.present) {
      map['needs_review'] = Variable<bool>(needsReview.value);
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('merchantName: $merchantName, ')
          ..write('merchantAddress: $merchantAddress, ')
          ..write('merchantPhone: $merchantPhone, ')
          ..write('currency: $currency, ')
          ..write('date: $date, ')
          ..write('time: $time, ')
          ..write('subtotal: $subtotal, ')
          ..write('tax: $tax, ')
          ..write('tip: $tip, ')
          ..write('total: $total, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('needsReview: $needsReview, ')
          ..write('imagePath: $imagePath, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReceiptItemsTable extends ReceiptItems
    with TableInfo<$ReceiptItemsTable, ReceiptItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _receiptIdMeta = const VerificationMeta(
    'receiptId',
  );
  @override
  late final GeneratedColumn<int> receiptId = GeneratedColumn<int>(
    'receipt_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES receipts (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
    'quantity',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<double> total = GeneratedColumn<double>(
    'total',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    receiptId,
    description,
    quantity,
    unitPrice,
    total,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipt_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceiptItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('receipt_id')) {
      context.handle(
        _receiptIdMeta,
        receiptId.isAcceptableOrUnknown(data['receipt_id']!, _receiptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_receiptIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      receiptId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}receipt_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity'],
      ),
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      ),
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total'],
      ),
    );
  }

  @override
  $ReceiptItemsTable createAlias(String alias) {
    return $ReceiptItemsTable(attachedDatabase, alias);
  }
}

class ReceiptItem extends DataClass implements Insertable<ReceiptItem> {
  final int id;

  /// Foreign key → Receipts.id. Deleting a receipt deletes its items.
  final int receiptId;
  final String description;
  final double? quantity;
  final double? unitPrice;
  final double? total;
  const ReceiptItem({
    required this.id,
    required this.receiptId,
    required this.description,
    this.quantity,
    this.unitPrice,
    this.total,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['receipt_id'] = Variable<int>(receiptId);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || quantity != null) {
      map['quantity'] = Variable<double>(quantity);
    }
    if (!nullToAbsent || unitPrice != null) {
      map['unit_price'] = Variable<double>(unitPrice);
    }
    if (!nullToAbsent || total != null) {
      map['total'] = Variable<double>(total);
    }
    return map;
  }

  ReceiptItemsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptItemsCompanion(
      id: Value(id),
      receiptId: Value(receiptId),
      description: Value(description),
      quantity: quantity == null && nullToAbsent
          ? const Value.absent()
          : Value(quantity),
      unitPrice: unitPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(unitPrice),
      total: total == null && nullToAbsent
          ? const Value.absent()
          : Value(total),
    );
  }

  factory ReceiptItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptItem(
      id: serializer.fromJson<int>(json['id']),
      receiptId: serializer.fromJson<int>(json['receiptId']),
      description: serializer.fromJson<String>(json['description']),
      quantity: serializer.fromJson<double?>(json['quantity']),
      unitPrice: serializer.fromJson<double?>(json['unitPrice']),
      total: serializer.fromJson<double?>(json['total']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'receiptId': serializer.toJson<int>(receiptId),
      'description': serializer.toJson<String>(description),
      'quantity': serializer.toJson<double?>(quantity),
      'unitPrice': serializer.toJson<double?>(unitPrice),
      'total': serializer.toJson<double?>(total),
    };
  }

  ReceiptItem copyWith({
    int? id,
    int? receiptId,
    String? description,
    Value<double?> quantity = const Value.absent(),
    Value<double?> unitPrice = const Value.absent(),
    Value<double?> total = const Value.absent(),
  }) => ReceiptItem(
    id: id ?? this.id,
    receiptId: receiptId ?? this.receiptId,
    description: description ?? this.description,
    quantity: quantity.present ? quantity.value : this.quantity,
    unitPrice: unitPrice.present ? unitPrice.value : this.unitPrice,
    total: total.present ? total.value : this.total,
  );
  ReceiptItem copyWithCompanion(ReceiptItemsCompanion data) {
    return ReceiptItem(
      id: data.id.present ? data.id.value : this.id,
      receiptId: data.receiptId.present ? data.receiptId.value : this.receiptId,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      total: data.total.present ? data.total.value : this.total,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptItem(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, receiptId, description, quantity, unitPrice, total);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptItem &&
          other.id == this.id &&
          other.receiptId == this.receiptId &&
          other.description == this.description &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.total == this.total);
}

class ReceiptItemsCompanion extends UpdateCompanion<ReceiptItem> {
  final Value<int> id;
  final Value<int> receiptId;
  final Value<String> description;
  final Value<double?> quantity;
  final Value<double?> unitPrice;
  final Value<double?> total;
  const ReceiptItemsCompanion({
    this.id = const Value.absent(),
    this.receiptId = const Value.absent(),
    this.description = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
  });
  ReceiptItemsCompanion.insert({
    this.id = const Value.absent(),
    required int receiptId,
    required String description,
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.total = const Value.absent(),
  }) : receiptId = Value(receiptId),
       description = Value(description);
  static Insertable<ReceiptItem> custom({
    Expression<int>? id,
    Expression<int>? receiptId,
    Expression<String>? description,
    Expression<double>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? total,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (receiptId != null) 'receipt_id': receiptId,
      if (description != null) 'description': description,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (total != null) 'total': total,
    });
  }

  ReceiptItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? receiptId,
    Value<String>? description,
    Value<double?>? quantity,
    Value<double?>? unitPrice,
    Value<double?>? total,
  }) {
    return ReceiptItemsCompanion(
      id: id ?? this.id,
      receiptId: receiptId ?? this.receiptId,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      total: total ?? this.total,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (receiptId.present) {
      map['receipt_id'] = Variable<int>(receiptId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (total.present) {
      map['total'] = Variable<double>(total.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptItemsCompanion(')
          ..write('id: $id, ')
          ..write('receiptId: $receiptId, ')
          ..write('description: $description, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('total: $total')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $ReceiptItemsTable receiptItems = $ReceiptItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [receipts, receiptItems];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'receipts',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('receipt_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ReceiptsTableCreateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<int> id,
      Value<String?> merchantName,
      Value<String?> merchantAddress,
      Value<String?> merchantPhone,
      Value<String?> currency,
      Value<String?> date,
      Value<String?> time,
      Value<double?> subtotal,
      Value<double?> tax,
      Value<double?> tip,
      Value<double?> total,
      Value<String?> paymentMethod,
      Value<bool> needsReview,
      Value<String?> imagePath,
      Value<DateTime> createdAt,
    });
typedef $$ReceiptsTableUpdateCompanionBuilder =
    ReceiptsCompanion Function({
      Value<int> id,
      Value<String?> merchantName,
      Value<String?> merchantAddress,
      Value<String?> merchantPhone,
      Value<String?> currency,
      Value<String?> date,
      Value<String?> time,
      Value<double?> subtotal,
      Value<double?> tax,
      Value<double?> tip,
      Value<double?> total,
      Value<String?> paymentMethod,
      Value<bool> needsReview,
      Value<String?> imagePath,
      Value<DateTime> createdAt,
    });

final class $$ReceiptsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptsTable, Receipt> {
  $$ReceiptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ReceiptItemsTable, List<ReceiptItem>>
  _receiptItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.receiptItems,
    aliasName: 'receipts__id__receipt_items__receipt_id',
  );

  $$ReceiptItemsTableProcessedTableManager get receiptItemsRefs {
    final manager = $$ReceiptItemsTableTableManager(
      $_db,
      $_db.receiptItems,
    ).filter((f) => f.receiptId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
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

  ColumnFilters<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantAddress => $composableBuilder(
    column: $table.merchantAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get merchantPhone => $composableBuilder(
    column: $table.merchantPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get needsReview => $composableBuilder(
    column: $table.needsReview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> receiptItemsRefs(
    Expression<bool> Function($$ReceiptItemsTableFilterComposer f) f,
  ) {
    final $$ReceiptItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receiptItems,
      getReferencedColumn: (t) => t.receiptId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptItemsTableFilterComposer(
            $db: $db,
            $table: $db.receiptItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
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

  ColumnOrderings<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantAddress => $composableBuilder(
    column: $table.merchantAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get merchantPhone => $composableBuilder(
    column: $table.merchantPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tax => $composableBuilder(
    column: $table.tax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get needsReview => $composableBuilder(
    column: $table.needsReview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagePath => $composableBuilder(
    column: $table.imagePath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get merchantName => $composableBuilder(
    column: $table.merchantName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantAddress => $composableBuilder(
    column: $table.merchantAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get merchantPhone => $composableBuilder(
    column: $table.merchantPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get tax =>
      $composableBuilder(column: $table.tax, builder: (column) => column);

  GeneratedColumn<double> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get needsReview => $composableBuilder(
    column: $table.needsReview,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> receiptItemsRefs<T extends Object>(
    Expression<T> Function($$ReceiptItemsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receiptItems,
      getReferencedColumn: (t) => t.receiptId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.receiptItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          Receipt,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (Receipt, $$ReceiptsTableReferences),
          Receipt,
          PrefetchHooks Function({bool receiptItemsRefs})
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> merchantName = const Value.absent(),
                Value<String?> merchantAddress = const Value.absent(),
                Value<String?> merchantPhone = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> date = const Value.absent(),
                Value<String?> time = const Value.absent(),
                Value<double?> subtotal = const Value.absent(),
                Value<double?> tax = const Value.absent(),
                Value<double?> tip = const Value.absent(),
                Value<double?> total = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<bool> needsReview = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                merchantName: merchantName,
                merchantAddress: merchantAddress,
                merchantPhone: merchantPhone,
                currency: currency,
                date: date,
                time: time,
                subtotal: subtotal,
                tax: tax,
                tip: tip,
                total: total,
                paymentMethod: paymentMethod,
                needsReview: needsReview,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> merchantName = const Value.absent(),
                Value<String?> merchantAddress = const Value.absent(),
                Value<String?> merchantPhone = const Value.absent(),
                Value<String?> currency = const Value.absent(),
                Value<String?> date = const Value.absent(),
                Value<String?> time = const Value.absent(),
                Value<double?> subtotal = const Value.absent(),
                Value<double?> tax = const Value.absent(),
                Value<double?> tip = const Value.absent(),
                Value<double?> total = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<bool> needsReview = const Value.absent(),
                Value<String?> imagePath = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                merchantName: merchantName,
                merchantAddress: merchantAddress,
                merchantPhone: merchantPhone,
                currency: currency,
                date: date,
                time: time,
                subtotal: subtotal,
                tax: tax,
                tip: tip,
                total: total,
                paymentMethod: paymentMethod,
                needsReview: needsReview,
                imagePath: imagePath,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({receiptItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (receiptItemsRefs) db.receiptItems],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (receiptItemsRefs)
                    await $_getPrefetchedData<
                      Receipt,
                      $ReceiptsTable,
                      ReceiptItem
                    >(
                      currentTable: table,
                      referencedTable: $$ReceiptsTableReferences
                          ._receiptItemsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ReceiptsTableReferences(
                        db,
                        table,
                        p0,
                      ).receiptItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.receiptId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      Receipt,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (Receipt, $$ReceiptsTableReferences),
      Receipt,
      PrefetchHooks Function({bool receiptItemsRefs})
    >;
typedef $$ReceiptItemsTableCreateCompanionBuilder =
    ReceiptItemsCompanion Function({
      Value<int> id,
      required int receiptId,
      required String description,
      Value<double?> quantity,
      Value<double?> unitPrice,
      Value<double?> total,
    });
typedef $$ReceiptItemsTableUpdateCompanionBuilder =
    ReceiptItemsCompanion Function({
      Value<int> id,
      Value<int> receiptId,
      Value<String> description,
      Value<double?> quantity,
      Value<double?> unitPrice,
      Value<double?> total,
    });

final class $$ReceiptItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptItemsTable, ReceiptItem> {
  $$ReceiptItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReceiptsTable _receiptIdTable(_$AppDatabase db) =>
      db.receipts.createAlias('receipt_items__receipt_id__receipts__id');

  $$ReceiptsTableProcessedTableManager get receiptId {
    final $_column = $_itemColumn<int>('receipt_id')!;

    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_receiptIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReceiptItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptItemsTable> {
  $$ReceiptItemsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  $$ReceiptsTableFilterComposer get receiptId {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptItemsTable> {
  $$ReceiptItemsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReceiptsTableOrderingComposer get receiptId {
    final $$ReceiptsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableOrderingComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptItemsTable> {
  $$ReceiptItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  $$ReceiptsTableAnnotationComposer get receiptId {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.receiptId,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptItemsTable,
          ReceiptItem,
          $$ReceiptItemsTableFilterComposer,
          $$ReceiptItemsTableOrderingComposer,
          $$ReceiptItemsTableAnnotationComposer,
          $$ReceiptItemsTableCreateCompanionBuilder,
          $$ReceiptItemsTableUpdateCompanionBuilder,
          (ReceiptItem, $$ReceiptItemsTableReferences),
          ReceiptItem,
          PrefetchHooks Function({bool receiptId})
        > {
  $$ReceiptItemsTableTableManager(_$AppDatabase db, $ReceiptItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> receiptId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<double?> quantity = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> total = const Value.absent(),
              }) => ReceiptItemsCompanion(
                id: id,
                receiptId: receiptId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int receiptId,
                required String description,
                Value<double?> quantity = const Value.absent(),
                Value<double?> unitPrice = const Value.absent(),
                Value<double?> total = const Value.absent(),
              }) => ReceiptItemsCompanion.insert(
                id: id,
                receiptId: receiptId,
                description: description,
                quantity: quantity,
                unitPrice: unitPrice,
                total: total,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReceiptItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({receiptId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (receiptId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.receiptId,
                                referencedTable: $$ReceiptItemsTableReferences
                                    ._receiptIdTable(db),
                                referencedColumn: $$ReceiptItemsTableReferences
                                    ._receiptIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReceiptItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptItemsTable,
      ReceiptItem,
      $$ReceiptItemsTableFilterComposer,
      $$ReceiptItemsTableOrderingComposer,
      $$ReceiptItemsTableAnnotationComposer,
      $$ReceiptItemsTableCreateCompanionBuilder,
      $$ReceiptItemsTableUpdateCompanionBuilder,
      (ReceiptItem, $$ReceiptItemsTableReferences),
      ReceiptItem,
      PrefetchHooks Function({bool receiptId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$ReceiptItemsTableTableManager get receiptItems =>
      $$ReceiptItemsTableTableManager(_db, _db.receiptItems);
}
