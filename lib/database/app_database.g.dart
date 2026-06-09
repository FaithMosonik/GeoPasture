// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $PastoralistTable extends Pastoralist
    with TableInfo<$PastoralistTable, PastoralistData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PastoralistTable(this.attachedDatabase, [this._alias]);
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
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
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
    name,
    phoneNumber,
    location,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pastoralist';
  @override
  VerificationContext validateIntegrity(
    Insertable<PastoralistData> instance, {
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
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
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
  PastoralistData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PastoralistData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PastoralistTable createAlias(String alias) {
    return $PastoralistTable(attachedDatabase, alias);
  }
}

class PastoralistData extends DataClass implements Insertable<PastoralistData> {
  /// UUID generated on registration
  final String id;
  final String name;

  /// Must be unique across all pastoralists
  final String phoneNumber;

  /// General region or county — not precise GPS
  final String? location;
  final DateTime createdAt;
  const PastoralistData({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.location,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['phone_number'] = Variable<String>(phoneNumber);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PastoralistCompanion toCompanion(bool nullToAbsent) {
    return PastoralistCompanion(
      id: Value(id),
      name: Value(name),
      phoneNumber: Value(phoneNumber),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      createdAt: Value(createdAt),
    );
  }

  factory PastoralistData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PastoralistData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phoneNumber: serializer.fromJson<String>(json['phoneNumber']),
      location: serializer.fromJson<String?>(json['location']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'phoneNumber': serializer.toJson<String>(phoneNumber),
      'location': serializer.toJson<String?>(location),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PastoralistData copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    Value<String?> location = const Value.absent(),
    DateTime? createdAt,
  }) => PastoralistData(
    id: id ?? this.id,
    name: name ?? this.name,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    location: location.present ? location.value : this.location,
    createdAt: createdAt ?? this.createdAt,
  );
  PastoralistData copyWithCompanion(PastoralistCompanion data) {
    return PastoralistData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      location: data.location.present ? data.location.value : this.location,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PastoralistData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('location: $location, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phoneNumber, location, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PastoralistData &&
          other.id == this.id &&
          other.name == this.name &&
          other.phoneNumber == this.phoneNumber &&
          other.location == this.location &&
          other.createdAt == this.createdAt);
}

class PastoralistCompanion extends UpdateCompanion<PastoralistData> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> phoneNumber;
  final Value<String?> location;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PastoralistCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.location = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PastoralistCompanion.insert({
    required String id,
    required String name,
    required String phoneNumber,
    this.location = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       phoneNumber = Value(phoneNumber);
  static Insertable<PastoralistData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? phoneNumber,
    Expression<String>? location,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (location != null) 'location': location,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PastoralistCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? phoneNumber,
    Value<String?>? location,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PastoralistCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
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
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastoralistCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('location: $location, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HerdTable extends Herd with TableInfo<$HerdTable, HerdData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HerdTable(this.attachedDatabase, [this._alias]);
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
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pastoralistIdMeta = const VerificationMeta(
    'pastoralistId',
  );
  @override
  late final GeneratedColumn<String> pastoralistId = GeneratedColumn<String>(
    'pastoralist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pastoralist (id)',
    ),
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
    name,
    size,
    pastoralistId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'herd';
  @override
  VerificationContext validateIntegrity(
    Insertable<HerdData> instance, {
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
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('pastoralist_id')) {
      context.handle(
        _pastoralistIdMeta,
        pastoralistId.isAcceptableOrUnknown(
          data['pastoralist_id']!,
          _pastoralistIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pastoralistIdMeta);
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
  HerdData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HerdData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      pastoralistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pastoralist_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HerdTable createAlias(String alias) {
    return $HerdTable(attachedDatabase, alias);
  }
}

class HerdData extends DataClass implements Insertable<HerdData> {
  final String id;
  final String name;

  /// Total number of animals in the herd
  final int size;
  final String pastoralistId;
  final DateTime createdAt;
  const HerdData({
    required this.id,
    required this.name,
    required this.size,
    required this.pastoralistId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['size'] = Variable<int>(size);
    map['pastoralist_id'] = Variable<String>(pastoralistId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HerdCompanion toCompanion(bool nullToAbsent) {
    return HerdCompanion(
      id: Value(id),
      name: Value(name),
      size: Value(size),
      pastoralistId: Value(pastoralistId),
      createdAt: Value(createdAt),
    );
  }

  factory HerdData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HerdData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      size: serializer.fromJson<int>(json['size']),
      pastoralistId: serializer.fromJson<String>(json['pastoralistId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'size': serializer.toJson<int>(size),
      'pastoralistId': serializer.toJson<String>(pastoralistId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HerdData copyWith({
    String? id,
    String? name,
    int? size,
    String? pastoralistId,
    DateTime? createdAt,
  }) => HerdData(
    id: id ?? this.id,
    name: name ?? this.name,
    size: size ?? this.size,
    pastoralistId: pastoralistId ?? this.pastoralistId,
    createdAt: createdAt ?? this.createdAt,
  );
  HerdData copyWithCompanion(HerdCompanion data) {
    return HerdData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      size: data.size.present ? data.size.value : this.size,
      pastoralistId: data.pastoralistId.present
          ? data.pastoralistId.value
          : this.pastoralistId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HerdData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('size: $size, ')
          ..write('pastoralistId: $pastoralistId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, size, pastoralistId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HerdData &&
          other.id == this.id &&
          other.name == this.name &&
          other.size == this.size &&
          other.pastoralistId == this.pastoralistId &&
          other.createdAt == this.createdAt);
}

class HerdCompanion extends UpdateCompanion<HerdData> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> size;
  final Value<String> pastoralistId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HerdCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.size = const Value.absent(),
    this.pastoralistId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HerdCompanion.insert({
    required String id,
    required String name,
    required int size,
    required String pastoralistId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       size = Value(size),
       pastoralistId = Value(pastoralistId);
  static Insertable<HerdData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? size,
    Expression<String>? pastoralistId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (size != null) 'size': size,
      if (pastoralistId != null) 'pastoralist_id': pastoralistId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HerdCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? size,
    Value<String>? pastoralistId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HerdCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      pastoralistId: pastoralistId ?? this.pastoralistId,
      createdAt: createdAt ?? this.createdAt,
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
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (pastoralistId.present) {
      map['pastoralist_id'] = Variable<String>(pastoralistId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HerdCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('size: $size, ')
          ..write('pastoralistId: $pastoralistId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AnimalTable extends Animal with TableInfo<$AnimalTable, AnimalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AnimalTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _herdIdMeta = const VerificationMeta('herdId');
  @override
  late final GeneratedColumn<String> herdId = GeneratedColumn<String>(
    'herd_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES herd (id)',
    ),
  );
  static const VerificationMeta _wearableIdMeta = const VerificationMeta(
    'wearableId',
  );
  @override
  late final GeneratedColumn<String> wearableId = GeneratedColumn<String>(
    'wearable_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tluValueMeta = const VerificationMeta(
    'tluValue',
  );
  @override
  late final GeneratedColumn<double> tluValue = GeneratedColumn<double>(
    'tlu_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1.0),
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
    name,
    species,
    herdId,
    wearableId,
    tluValue,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'animal';
  @override
  VerificationContext validateIntegrity(
    Insertable<AnimalData> instance, {
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
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('herd_id')) {
      context.handle(
        _herdIdMeta,
        herdId.isAcceptableOrUnknown(data['herd_id']!, _herdIdMeta),
      );
    } else if (isInserting) {
      context.missing(_herdIdMeta);
    }
    if (data.containsKey('wearable_id')) {
      context.handle(
        _wearableIdMeta,
        wearableId.isAcceptableOrUnknown(data['wearable_id']!, _wearableIdMeta),
      );
    }
    if (data.containsKey('tlu_value')) {
      context.handle(
        _tluValueMeta,
        tluValue.isAcceptableOrUnknown(data['tlu_value']!, _tluValueMeta),
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
  AnimalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AnimalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      herdId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}herd_id'],
      )!,
      wearableId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wearable_id'],
      ),
      tluValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tlu_value'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AnimalTable createAlias(String alias) {
    return $AnimalTable(attachedDatabase, alias);
  }
}

class AnimalData extends DataClass implements Insertable<AnimalData> {
  final String id;

  /// Optional tag name e.g. "Bessie"
  final String? name;

  /// e.g. "cattle", "camel", "goat"
  final String species;
  final String herdId;

  /// Nullable — only set when a wearable device is attached
  final String? wearableId;

  /// Tropical Livestock Unit weight:
  /// cattle = 1.0, camel = 1.4, goat = 0.1
  final double tluValue;
  final DateTime createdAt;
  const AnimalData({
    required this.id,
    this.name,
    required this.species,
    required this.herdId,
    this.wearableId,
    required this.tluValue,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['species'] = Variable<String>(species);
    map['herd_id'] = Variable<String>(herdId);
    if (!nullToAbsent || wearableId != null) {
      map['wearable_id'] = Variable<String>(wearableId);
    }
    map['tlu_value'] = Variable<double>(tluValue);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AnimalCompanion toCompanion(bool nullToAbsent) {
    return AnimalCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      species: Value(species),
      herdId: Value(herdId),
      wearableId: wearableId == null && nullToAbsent
          ? const Value.absent()
          : Value(wearableId),
      tluValue: Value(tluValue),
      createdAt: Value(createdAt),
    );
  }

  factory AnimalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AnimalData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      species: serializer.fromJson<String>(json['species']),
      herdId: serializer.fromJson<String>(json['herdId']),
      wearableId: serializer.fromJson<String?>(json['wearableId']),
      tluValue: serializer.fromJson<double>(json['tluValue']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'species': serializer.toJson<String>(species),
      'herdId': serializer.toJson<String>(herdId),
      'wearableId': serializer.toJson<String?>(wearableId),
      'tluValue': serializer.toJson<double>(tluValue),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AnimalData copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    String? species,
    String? herdId,
    Value<String?> wearableId = const Value.absent(),
    double? tluValue,
    DateTime? createdAt,
  }) => AnimalData(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    species: species ?? this.species,
    herdId: herdId ?? this.herdId,
    wearableId: wearableId.present ? wearableId.value : this.wearableId,
    tluValue: tluValue ?? this.tluValue,
    createdAt: createdAt ?? this.createdAt,
  );
  AnimalData copyWithCompanion(AnimalCompanion data) {
    return AnimalData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      species: data.species.present ? data.species.value : this.species,
      herdId: data.herdId.present ? data.herdId.value : this.herdId,
      wearableId: data.wearableId.present
          ? data.wearableId.value
          : this.wearableId,
      tluValue: data.tluValue.present ? data.tluValue.value : this.tluValue,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AnimalData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('herdId: $herdId, ')
          ..write('wearableId: $wearableId, ')
          ..write('tluValue: $tluValue, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, species, herdId, wearableId, tluValue, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AnimalData &&
          other.id == this.id &&
          other.name == this.name &&
          other.species == this.species &&
          other.herdId == this.herdId &&
          other.wearableId == this.wearableId &&
          other.tluValue == this.tluValue &&
          other.createdAt == this.createdAt);
}

class AnimalCompanion extends UpdateCompanion<AnimalData> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String> species;
  final Value<String> herdId;
  final Value<String?> wearableId;
  final Value<double> tluValue;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AnimalCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.species = const Value.absent(),
    this.herdId = const Value.absent(),
    this.wearableId = const Value.absent(),
    this.tluValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AnimalCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    required String species,
    required String herdId,
    this.wearableId = const Value.absent(),
    this.tluValue = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       species = Value(species),
       herdId = Value(herdId);
  static Insertable<AnimalData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? species,
    Expression<String>? herdId,
    Expression<String>? wearableId,
    Expression<double>? tluValue,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (species != null) 'species': species,
      if (herdId != null) 'herd_id': herdId,
      if (wearableId != null) 'wearable_id': wearableId,
      if (tluValue != null) 'tlu_value': tluValue,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AnimalCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String>? species,
    Value<String>? herdId,
    Value<String?>? wearableId,
    Value<double>? tluValue,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AnimalCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      species: species ?? this.species,
      herdId: herdId ?? this.herdId,
      wearableId: wearableId ?? this.wearableId,
      tluValue: tluValue ?? this.tluValue,
      createdAt: createdAt ?? this.createdAt,
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
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (herdId.present) {
      map['herd_id'] = Variable<String>(herdId.value);
    }
    if (wearableId.present) {
      map['wearable_id'] = Variable<String>(wearableId.value);
    }
    if (tluValue.present) {
      map['tlu_value'] = Variable<double>(tluValue.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AnimalCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('species: $species, ')
          ..write('herdId: $herdId, ')
          ..write('wearableId: $wearableId, ')
          ..write('tluValue: $tluValue, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WearableTable extends Wearable
    with TableInfo<$WearableTable, WearableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WearableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal (id)',
    ),
  );
  static const VerificationMeta _sampleRateMeta = const VerificationMeta(
    'sampleRate',
  );
  @override
  late final GeneratedColumn<int> sampleRate = GeneratedColumn<int>(
    'sample_rate',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(10),
  );
  static const VerificationMeta _batteryLevelMeta = const VerificationMeta(
    'batteryLevel',
  );
  @override
  late final GeneratedColumn<double> batteryLevel = GeneratedColumn<double>(
    'battery_level',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSeenMeta = const VerificationMeta(
    'lastSeen',
  );
  @override
  late final GeneratedColumn<DateTime> lastSeen = GeneratedColumn<DateTime>(
    'last_seen',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    sampleRate,
    batteryLevel,
    lastSeen,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wearable';
  @override
  VerificationContext validateIntegrity(
    Insertable<WearableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    }
    if (data.containsKey('sample_rate')) {
      context.handle(
        _sampleRateMeta,
        sampleRate.isAcceptableOrUnknown(data['sample_rate']!, _sampleRateMeta),
      );
    }
    if (data.containsKey('battery_level')) {
      context.handle(
        _batteryLevelMeta,
        batteryLevel.isAcceptableOrUnknown(
          data['battery_level']!,
          _batteryLevelMeta,
        ),
      );
    }
    if (data.containsKey('last_seen')) {
      context.handle(
        _lastSeenMeta,
        lastSeen.isAcceptableOrUnknown(data['last_seen']!, _lastSeenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WearableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WearableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      ),
      sampleRate: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sample_rate'],
      )!,
      batteryLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}battery_level'],
      ),
      lastSeen: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_seen'],
      ),
    );
  }

  @override
  $WearableTable createAlias(String alias) {
    return $WearableTable(attachedDatabase, alias);
  }
}

class WearableData extends DataClass implements Insertable<WearableData> {
  /// Device serial number — used as primary key
  final String id;

  /// Nullable until the device is assigned to an animal
  final String? animalId;

  /// Accelerometer sampling rate in Hz — default 10Hz
  /// At 10Hz, 100 samples = exactly 10 seconds (one TFLite window)
  final int sampleRate;

  /// Battery level as a fraction: 0.0 (empty) to 1.0 (full)
  final double? batteryLevel;

  /// Timestamp of last successful Bluetooth sync with the phone
  final DateTime? lastSeen;
  const WearableData({
    required this.id,
    this.animalId,
    required this.sampleRate,
    this.batteryLevel,
    this.lastSeen,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || animalId != null) {
      map['animal_id'] = Variable<String>(animalId);
    }
    map['sample_rate'] = Variable<int>(sampleRate);
    if (!nullToAbsent || batteryLevel != null) {
      map['battery_level'] = Variable<double>(batteryLevel);
    }
    if (!nullToAbsent || lastSeen != null) {
      map['last_seen'] = Variable<DateTime>(lastSeen);
    }
    return map;
  }

  WearableCompanion toCompanion(bool nullToAbsent) {
    return WearableCompanion(
      id: Value(id),
      animalId: animalId == null && nullToAbsent
          ? const Value.absent()
          : Value(animalId),
      sampleRate: Value(sampleRate),
      batteryLevel: batteryLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(batteryLevel),
      lastSeen: lastSeen == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSeen),
    );
  }

  factory WearableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WearableData(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String?>(json['animalId']),
      sampleRate: serializer.fromJson<int>(json['sampleRate']),
      batteryLevel: serializer.fromJson<double?>(json['batteryLevel']),
      lastSeen: serializer.fromJson<DateTime?>(json['lastSeen']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String?>(animalId),
      'sampleRate': serializer.toJson<int>(sampleRate),
      'batteryLevel': serializer.toJson<double?>(batteryLevel),
      'lastSeen': serializer.toJson<DateTime?>(lastSeen),
    };
  }

  WearableData copyWith({
    String? id,
    Value<String?> animalId = const Value.absent(),
    int? sampleRate,
    Value<double?> batteryLevel = const Value.absent(),
    Value<DateTime?> lastSeen = const Value.absent(),
  }) => WearableData(
    id: id ?? this.id,
    animalId: animalId.present ? animalId.value : this.animalId,
    sampleRate: sampleRate ?? this.sampleRate,
    batteryLevel: batteryLevel.present ? batteryLevel.value : this.batteryLevel,
    lastSeen: lastSeen.present ? lastSeen.value : this.lastSeen,
  );
  WearableData copyWithCompanion(WearableCompanion data) {
    return WearableData(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      sampleRate: data.sampleRate.present
          ? data.sampleRate.value
          : this.sampleRate,
      batteryLevel: data.batteryLevel.present
          ? data.batteryLevel.value
          : this.batteryLevel,
      lastSeen: data.lastSeen.present ? data.lastSeen.value : this.lastSeen,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WearableData(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('sampleRate: $sampleRate, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('lastSeen: $lastSeen')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, animalId, sampleRate, batteryLevel, lastSeen);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WearableData &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.sampleRate == this.sampleRate &&
          other.batteryLevel == this.batteryLevel &&
          other.lastSeen == this.lastSeen);
}

class WearableCompanion extends UpdateCompanion<WearableData> {
  final Value<String> id;
  final Value<String?> animalId;
  final Value<int> sampleRate;
  final Value<double?> batteryLevel;
  final Value<DateTime?> lastSeen;
  final Value<int> rowid;
  const WearableCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.sampleRate = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WearableCompanion.insert({
    required String id,
    this.animalId = const Value.absent(),
    this.sampleRate = const Value.absent(),
    this.batteryLevel = const Value.absent(),
    this.lastSeen = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<WearableData> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<int>? sampleRate,
    Expression<double>? batteryLevel,
    Expression<DateTime>? lastSeen,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (sampleRate != null) 'sample_rate': sampleRate,
      if (batteryLevel != null) 'battery_level': batteryLevel,
      if (lastSeen != null) 'last_seen': lastSeen,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WearableCompanion copyWith({
    Value<String>? id,
    Value<String?>? animalId,
    Value<int>? sampleRate,
    Value<double?>? batteryLevel,
    Value<DateTime?>? lastSeen,
    Value<int>? rowid,
  }) {
    return WearableCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      sampleRate: sampleRate ?? this.sampleRate,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      lastSeen: lastSeen ?? this.lastSeen,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (sampleRate.present) {
      map['sample_rate'] = Variable<int>(sampleRate.value);
    }
    if (batteryLevel.present) {
      map['battery_level'] = Variable<double>(batteryLevel.value);
    }
    if (lastSeen.present) {
      map['last_seen'] = Variable<DateTime>(lastSeen.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WearableCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('sampleRate: $sampleRate, ')
          ..write('batteryLevel: $batteryLevel, ')
          ..write('lastSeen: $lastSeen, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogTable extends SyncLog with TableInfo<$SyncLogTable, SyncLogData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIdMeta = const VerificationMeta(
    'recordId',
  );
  @override
  late final GeneratedColumn<String> recordId = GeneratedColumn<String>(
    'record_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTableMeta = const VerificationMeta(
    'targetTable',
  );
  @override
  late final GeneratedColumn<String> targetTable = GeneratedColumn<String>(
    'target_table',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncTimeMeta = const VerificationMeta(
    'syncTime',
  );
  @override
  late final GeneratedColumn<DateTime> syncTime = GeneratedColumn<DateTime>(
    'sync_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordsUploadedMeta = const VerificationMeta(
    'recordsUploaded',
  );
  @override
  late final GeneratedColumn<int> recordsUploaded = GeneratedColumn<int>(
    'records_uploaded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _recordsDownloadedMeta = const VerificationMeta(
    'recordsDownloaded',
  );
  @override
  late final GeneratedColumn<int> recordsDownloaded = GeneratedColumn<int>(
    'records_downloaded',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
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
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recordId,
    targetTable,
    syncTime,
    status,
    recordsUploaded,
    recordsDownloaded,
    retryCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_log';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncLogData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('record_id')) {
      context.handle(
        _recordIdMeta,
        recordId.isAcceptableOrUnknown(data['record_id']!, _recordIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recordIdMeta);
    }
    if (data.containsKey('target_table')) {
      context.handle(
        _targetTableMeta,
        targetTable.isAcceptableOrUnknown(
          data['target_table']!,
          _targetTableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetTableMeta);
    }
    if (data.containsKey('sync_time')) {
      context.handle(
        _syncTimeMeta,
        syncTime.isAcceptableOrUnknown(data['sync_time']!, _syncTimeMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('records_uploaded')) {
      context.handle(
        _recordsUploadedMeta,
        recordsUploaded.isAcceptableOrUnknown(
          data['records_uploaded']!,
          _recordsUploadedMeta,
        ),
      );
    }
    if (data.containsKey('records_downloaded')) {
      context.handle(
        _recordsDownloadedMeta,
        recordsDownloaded.isAcceptableOrUnknown(
          data['records_downloaded']!,
          _recordsDownloadedMeta,
        ),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
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
  SyncLogData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recordId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}record_id'],
      )!,
      targetTable: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_table'],
      )!,
      syncTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sync_time'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      recordsUploaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_uploaded'],
      )!,
      recordsDownloaded: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}records_downloaded'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncLogTable createAlias(String alias) {
    return $SyncLogTable(attachedDatabase, alias);
  }
}

class SyncLogData extends DataClass implements Insertable<SyncLogData> {
  final String id;

  /// The UUID of the record being synced (from whichever table it belongs to)
  final String recordId;

  /// Which table the record belongs to e.g. 'BEHAVIOUR_CLASSIFICATION'
  final String targetTable;

  /// When the sync was last attempted
  final DateTime? syncTime;

  /// One of SyncStatus constants: 'pending', 'synced', 'failed'
  final String status;
  final int recordsUploaded;
  final int recordsDownloaded;

  /// Number of retry attempts — used for exponential backoff
  final int retryCount;
  final DateTime createdAt;
  const SyncLogData({
    required this.id,
    required this.recordId,
    required this.targetTable,
    this.syncTime,
    required this.status,
    required this.recordsUploaded,
    required this.recordsDownloaded,
    required this.retryCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['record_id'] = Variable<String>(recordId);
    map['target_table'] = Variable<String>(targetTable);
    if (!nullToAbsent || syncTime != null) {
      map['sync_time'] = Variable<DateTime>(syncTime);
    }
    map['status'] = Variable<String>(status);
    map['records_uploaded'] = Variable<int>(recordsUploaded);
    map['records_downloaded'] = Variable<int>(recordsDownloaded);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncLogCompanion toCompanion(bool nullToAbsent) {
    return SyncLogCompanion(
      id: Value(id),
      recordId: Value(recordId),
      targetTable: Value(targetTable),
      syncTime: syncTime == null && nullToAbsent
          ? const Value.absent()
          : Value(syncTime),
      status: Value(status),
      recordsUploaded: Value(recordsUploaded),
      recordsDownloaded: Value(recordsDownloaded),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
    );
  }

  factory SyncLogData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogData(
      id: serializer.fromJson<String>(json['id']),
      recordId: serializer.fromJson<String>(json['recordId']),
      targetTable: serializer.fromJson<String>(json['targetTable']),
      syncTime: serializer.fromJson<DateTime?>(json['syncTime']),
      status: serializer.fromJson<String>(json['status']),
      recordsUploaded: serializer.fromJson<int>(json['recordsUploaded']),
      recordsDownloaded: serializer.fromJson<int>(json['recordsDownloaded']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recordId': serializer.toJson<String>(recordId),
      'targetTable': serializer.toJson<String>(targetTable),
      'syncTime': serializer.toJson<DateTime?>(syncTime),
      'status': serializer.toJson<String>(status),
      'recordsUploaded': serializer.toJson<int>(recordsUploaded),
      'recordsDownloaded': serializer.toJson<int>(recordsDownloaded),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncLogData copyWith({
    String? id,
    String? recordId,
    String? targetTable,
    Value<DateTime?> syncTime = const Value.absent(),
    String? status,
    int? recordsUploaded,
    int? recordsDownloaded,
    int? retryCount,
    DateTime? createdAt,
  }) => SyncLogData(
    id: id ?? this.id,
    recordId: recordId ?? this.recordId,
    targetTable: targetTable ?? this.targetTable,
    syncTime: syncTime.present ? syncTime.value : this.syncTime,
    status: status ?? this.status,
    recordsUploaded: recordsUploaded ?? this.recordsUploaded,
    recordsDownloaded: recordsDownloaded ?? this.recordsDownloaded,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncLogData copyWithCompanion(SyncLogCompanion data) {
    return SyncLogData(
      id: data.id.present ? data.id.value : this.id,
      recordId: data.recordId.present ? data.recordId.value : this.recordId,
      targetTable: data.targetTable.present
          ? data.targetTable.value
          : this.targetTable,
      syncTime: data.syncTime.present ? data.syncTime.value : this.syncTime,
      status: data.status.present ? data.status.value : this.status,
      recordsUploaded: data.recordsUploaded.present
          ? data.recordsUploaded.value
          : this.recordsUploaded,
      recordsDownloaded: data.recordsDownloaded.present
          ? data.recordsDownloaded.value
          : this.recordsDownloaded,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogData(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('targetTable: $targetTable, ')
          ..write('syncTime: $syncTime, ')
          ..write('status: $status, ')
          ..write('recordsUploaded: $recordsUploaded, ')
          ..write('recordsDownloaded: $recordsDownloaded, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recordId,
    targetTable,
    syncTime,
    status,
    recordsUploaded,
    recordsDownloaded,
    retryCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogData &&
          other.id == this.id &&
          other.recordId == this.recordId &&
          other.targetTable == this.targetTable &&
          other.syncTime == this.syncTime &&
          other.status == this.status &&
          other.recordsUploaded == this.recordsUploaded &&
          other.recordsDownloaded == this.recordsDownloaded &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt);
}

class SyncLogCompanion extends UpdateCompanion<SyncLogData> {
  final Value<String> id;
  final Value<String> recordId;
  final Value<String> targetTable;
  final Value<DateTime?> syncTime;
  final Value<String> status;
  final Value<int> recordsUploaded;
  final Value<int> recordsDownloaded;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncLogCompanion({
    this.id = const Value.absent(),
    this.recordId = const Value.absent(),
    this.targetTable = const Value.absent(),
    this.syncTime = const Value.absent(),
    this.status = const Value.absent(),
    this.recordsUploaded = const Value.absent(),
    this.recordsDownloaded = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLogCompanion.insert({
    required String id,
    required String recordId,
    required String targetTable,
    this.syncTime = const Value.absent(),
    required String status,
    this.recordsUploaded = const Value.absent(),
    this.recordsDownloaded = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recordId = Value(recordId),
       targetTable = Value(targetTable),
       status = Value(status);
  static Insertable<SyncLogData> custom({
    Expression<String>? id,
    Expression<String>? recordId,
    Expression<String>? targetTable,
    Expression<DateTime>? syncTime,
    Expression<String>? status,
    Expression<int>? recordsUploaded,
    Expression<int>? recordsDownloaded,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recordId != null) 'record_id': recordId,
      if (targetTable != null) 'target_table': targetTable,
      if (syncTime != null) 'sync_time': syncTime,
      if (status != null) 'status': status,
      if (recordsUploaded != null) 'records_uploaded': recordsUploaded,
      if (recordsDownloaded != null) 'records_downloaded': recordsDownloaded,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLogCompanion copyWith({
    Value<String>? id,
    Value<String>? recordId,
    Value<String>? targetTable,
    Value<DateTime?>? syncTime,
    Value<String>? status,
    Value<int>? recordsUploaded,
    Value<int>? recordsDownloaded,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncLogCompanion(
      id: id ?? this.id,
      recordId: recordId ?? this.recordId,
      targetTable: targetTable ?? this.targetTable,
      syncTime: syncTime ?? this.syncTime,
      status: status ?? this.status,
      recordsUploaded: recordsUploaded ?? this.recordsUploaded,
      recordsDownloaded: recordsDownloaded ?? this.recordsDownloaded,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recordId.present) {
      map['record_id'] = Variable<String>(recordId.value);
    }
    if (targetTable.present) {
      map['target_table'] = Variable<String>(targetTable.value);
    }
    if (syncTime.present) {
      map['sync_time'] = Variable<DateTime>(syncTime.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (recordsUploaded.present) {
      map['records_uploaded'] = Variable<int>(recordsUploaded.value);
    }
    if (recordsDownloaded.present) {
      map['records_downloaded'] = Variable<int>(recordsDownloaded.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogCompanion(')
          ..write('id: $id, ')
          ..write('recordId: $recordId, ')
          ..write('targetTable: $targetTable, ')
          ..write('syncTime: $syncTime, ')
          ..write('status: $status, ')
          ..write('recordsUploaded: $recordsUploaded, ')
          ..write('recordsDownloaded: $recordsDownloaded, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AccelerometerReadingTable extends AccelerometerReading
    with TableInfo<$AccelerometerReadingTable, AccelerometerReadingData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccelerometerReadingTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wearableIdMeta = const VerificationMeta(
    'wearableId',
  );
  @override
  late final GeneratedColumn<String> wearableId = GeneratedColumn<String>(
    'wearable_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES wearable (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xAxisMeta = const VerificationMeta('xAxis');
  @override
  late final GeneratedColumn<double> xAxis = GeneratedColumn<double>(
    'x_axis',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _yAxisMeta = const VerificationMeta('yAxis');
  @override
  late final GeneratedColumn<double> yAxis = GeneratedColumn<double>(
    'y_axis',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _zAxisMeta = const VerificationMeta('zAxis');
  @override
  late final GeneratedColumn<double> zAxis = GeneratedColumn<double>(
    'z_axis',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _processedMeta = const VerificationMeta(
    'processed',
  );
  @override
  late final GeneratedColumn<int> processed = GeneratedColumn<int>(
    'processed',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    wearableId,
    timestamp,
    xAxis,
    yAxis,
    zAxis,
    processed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accelerometer_reading';
  @override
  VerificationContext validateIntegrity(
    Insertable<AccelerometerReadingData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('wearable_id')) {
      context.handle(
        _wearableIdMeta,
        wearableId.isAcceptableOrUnknown(data['wearable_id']!, _wearableIdMeta),
      );
    } else if (isInserting) {
      context.missing(_wearableIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('x_axis')) {
      context.handle(
        _xAxisMeta,
        xAxis.isAcceptableOrUnknown(data['x_axis']!, _xAxisMeta),
      );
    } else if (isInserting) {
      context.missing(_xAxisMeta);
    }
    if (data.containsKey('y_axis')) {
      context.handle(
        _yAxisMeta,
        yAxis.isAcceptableOrUnknown(data['y_axis']!, _yAxisMeta),
      );
    } else if (isInserting) {
      context.missing(_yAxisMeta);
    }
    if (data.containsKey('z_axis')) {
      context.handle(
        _zAxisMeta,
        zAxis.isAcceptableOrUnknown(data['z_axis']!, _zAxisMeta),
      );
    } else if (isInserting) {
      context.missing(_zAxisMeta);
    }
    if (data.containsKey('processed')) {
      context.handle(
        _processedMeta,
        processed.isAcceptableOrUnknown(data['processed']!, _processedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccelerometerReadingData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccelerometerReadingData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      wearableId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wearable_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      xAxis: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}x_axis'],
      )!,
      yAxis: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}y_axis'],
      )!,
      zAxis: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}z_axis'],
      )!,
      processed: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}processed'],
      )!,
    );
  }

  @override
  $AccelerometerReadingTable createAlias(String alias) {
    return $AccelerometerReadingTable(attachedDatabase, alias);
  }
}

class AccelerometerReadingData extends DataClass
    implements Insertable<AccelerometerReadingData> {
  final String id;
  final String wearableId;
  final DateTime timestamp;

  /// Accelerometer X-axis reading in m/s²
  final double xAxis;

  /// Accelerometer Y-axis reading in m/s²
  final double yAxis;

  /// Accelerometer Z-axis reading in m/s²
  final double zAxis;

  /// 0 = pending inference, 1 = processed and safe to prune
  final int processed;
  const AccelerometerReadingData({
    required this.id,
    required this.wearableId,
    required this.timestamp,
    required this.xAxis,
    required this.yAxis,
    required this.zAxis,
    required this.processed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['wearable_id'] = Variable<String>(wearableId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['x_axis'] = Variable<double>(xAxis);
    map['y_axis'] = Variable<double>(yAxis);
    map['z_axis'] = Variable<double>(zAxis);
    map['processed'] = Variable<int>(processed);
    return map;
  }

  AccelerometerReadingCompanion toCompanion(bool nullToAbsent) {
    return AccelerometerReadingCompanion(
      id: Value(id),
      wearableId: Value(wearableId),
      timestamp: Value(timestamp),
      xAxis: Value(xAxis),
      yAxis: Value(yAxis),
      zAxis: Value(zAxis),
      processed: Value(processed),
    );
  }

  factory AccelerometerReadingData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccelerometerReadingData(
      id: serializer.fromJson<String>(json['id']),
      wearableId: serializer.fromJson<String>(json['wearableId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      xAxis: serializer.fromJson<double>(json['xAxis']),
      yAxis: serializer.fromJson<double>(json['yAxis']),
      zAxis: serializer.fromJson<double>(json['zAxis']),
      processed: serializer.fromJson<int>(json['processed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'wearableId': serializer.toJson<String>(wearableId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'xAxis': serializer.toJson<double>(xAxis),
      'yAxis': serializer.toJson<double>(yAxis),
      'zAxis': serializer.toJson<double>(zAxis),
      'processed': serializer.toJson<int>(processed),
    };
  }

  AccelerometerReadingData copyWith({
    String? id,
    String? wearableId,
    DateTime? timestamp,
    double? xAxis,
    double? yAxis,
    double? zAxis,
    int? processed,
  }) => AccelerometerReadingData(
    id: id ?? this.id,
    wearableId: wearableId ?? this.wearableId,
    timestamp: timestamp ?? this.timestamp,
    xAxis: xAxis ?? this.xAxis,
    yAxis: yAxis ?? this.yAxis,
    zAxis: zAxis ?? this.zAxis,
    processed: processed ?? this.processed,
  );
  AccelerometerReadingData copyWithCompanion(
    AccelerometerReadingCompanion data,
  ) {
    return AccelerometerReadingData(
      id: data.id.present ? data.id.value : this.id,
      wearableId: data.wearableId.present
          ? data.wearableId.value
          : this.wearableId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      xAxis: data.xAxis.present ? data.xAxis.value : this.xAxis,
      yAxis: data.yAxis.present ? data.yAxis.value : this.yAxis,
      zAxis: data.zAxis.present ? data.zAxis.value : this.zAxis,
      processed: data.processed.present ? data.processed.value : this.processed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AccelerometerReadingData(')
          ..write('id: $id, ')
          ..write('wearableId: $wearableId, ')
          ..write('timestamp: $timestamp, ')
          ..write('xAxis: $xAxis, ')
          ..write('yAxis: $yAxis, ')
          ..write('zAxis: $zAxis, ')
          ..write('processed: $processed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, wearableId, timestamp, xAxis, yAxis, zAxis, processed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccelerometerReadingData &&
          other.id == this.id &&
          other.wearableId == this.wearableId &&
          other.timestamp == this.timestamp &&
          other.xAxis == this.xAxis &&
          other.yAxis == this.yAxis &&
          other.zAxis == this.zAxis &&
          other.processed == this.processed);
}

class AccelerometerReadingCompanion
    extends UpdateCompanion<AccelerometerReadingData> {
  final Value<String> id;
  final Value<String> wearableId;
  final Value<DateTime> timestamp;
  final Value<double> xAxis;
  final Value<double> yAxis;
  final Value<double> zAxis;
  final Value<int> processed;
  final Value<int> rowid;
  const AccelerometerReadingCompanion({
    this.id = const Value.absent(),
    this.wearableId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.xAxis = const Value.absent(),
    this.yAxis = const Value.absent(),
    this.zAxis = const Value.absent(),
    this.processed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AccelerometerReadingCompanion.insert({
    required String id,
    required String wearableId,
    required DateTime timestamp,
    required double xAxis,
    required double yAxis,
    required double zAxis,
    this.processed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       wearableId = Value(wearableId),
       timestamp = Value(timestamp),
       xAxis = Value(xAxis),
       yAxis = Value(yAxis),
       zAxis = Value(zAxis);
  static Insertable<AccelerometerReadingData> custom({
    Expression<String>? id,
    Expression<String>? wearableId,
    Expression<DateTime>? timestamp,
    Expression<double>? xAxis,
    Expression<double>? yAxis,
    Expression<double>? zAxis,
    Expression<int>? processed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (wearableId != null) 'wearable_id': wearableId,
      if (timestamp != null) 'timestamp': timestamp,
      if (xAxis != null) 'x_axis': xAxis,
      if (yAxis != null) 'y_axis': yAxis,
      if (zAxis != null) 'z_axis': zAxis,
      if (processed != null) 'processed': processed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AccelerometerReadingCompanion copyWith({
    Value<String>? id,
    Value<String>? wearableId,
    Value<DateTime>? timestamp,
    Value<double>? xAxis,
    Value<double>? yAxis,
    Value<double>? zAxis,
    Value<int>? processed,
    Value<int>? rowid,
  }) {
    return AccelerometerReadingCompanion(
      id: id ?? this.id,
      wearableId: wearableId ?? this.wearableId,
      timestamp: timestamp ?? this.timestamp,
      xAxis: xAxis ?? this.xAxis,
      yAxis: yAxis ?? this.yAxis,
      zAxis: zAxis ?? this.zAxis,
      processed: processed ?? this.processed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (wearableId.present) {
      map['wearable_id'] = Variable<String>(wearableId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (xAxis.present) {
      map['x_axis'] = Variable<double>(xAxis.value);
    }
    if (yAxis.present) {
      map['y_axis'] = Variable<double>(yAxis.value);
    }
    if (zAxis.present) {
      map['z_axis'] = Variable<double>(zAxis.value);
    }
    if (processed.present) {
      map['processed'] = Variable<int>(processed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccelerometerReadingCompanion(')
          ..write('id: $id, ')
          ..write('wearableId: $wearableId, ')
          ..write('timestamp: $timestamp, ')
          ..write('xAxis: $xAxis, ')
          ..write('yAxis: $yAxis, ')
          ..write('zAxis: $zAxis, ')
          ..write('processed: $processed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BehaviourClassificationTable extends BehaviourClassification
    with TableInfo<$BehaviourClassificationTable, BehaviourClassificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BehaviourClassificationTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal (id)',
    ),
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _behaviourClassMeta = const VerificationMeta(
    'behaviourClass',
  );
  @override
  late final GeneratedColumn<int> behaviourClass = GeneratedColumn<int>(
    'behaviour_class',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMeta = const VerificationMeta(
    'confidence',
  );
  @override
  late final GeneratedColumn<double> confidence = GeneratedColumn<double>(
    'confidence',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windowStartMeta = const VerificationMeta(
    'windowStart',
  );
  @override
  late final GeneratedColumn<DateTime> windowStart = GeneratedColumn<DateTime>(
    'window_start',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _windowEndMeta = const VerificationMeta(
    'windowEnd',
  );
  @override
  late final GeneratedColumn<DateTime> windowEnd = GeneratedColumn<DateTime>(
    'window_end',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probGrazingMeta = const VerificationMeta(
    'probGrazing',
  );
  @override
  late final GeneratedColumn<double> probGrazing = GeneratedColumn<double>(
    'prob_grazing',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probRuminatingMeta = const VerificationMeta(
    'probRuminating',
  );
  @override
  late final GeneratedColumn<double> probRuminating = GeneratedColumn<double>(
    'prob_ruminating',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probStandingMeta = const VerificationMeta(
    'probStanding',
  );
  @override
  late final GeneratedColumn<double> probStanding = GeneratedColumn<double>(
    'prob_standing',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probLyingMeta = const VerificationMeta(
    'probLying',
  );
  @override
  late final GeneratedColumn<double> probLying = GeneratedColumn<double>(
    'prob_lying',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _probWalkingMeta = const VerificationMeta(
    'probWalking',
  );
  @override
  late final GeneratedColumn<double> probWalking = GeneratedColumn<double>(
    'prob_walking',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alertProcessedMeta = const VerificationMeta(
    'alertProcessed',
  );
  @override
  late final GeneratedColumn<bool> alertProcessed = GeneratedColumn<bool>(
    'alert_processed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("alert_processed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    timestamp,
    behaviourClass,
    confidence,
    windowStart,
    windowEnd,
    probGrazing,
    probRuminating,
    probStanding,
    probLying,
    probWalking,
    alertProcessed,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'behaviour_classification';
  @override
  VerificationContext validateIntegrity(
    Insertable<BehaviourClassificationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('behaviour_class')) {
      context.handle(
        _behaviourClassMeta,
        behaviourClass.isAcceptableOrUnknown(
          data['behaviour_class']!,
          _behaviourClassMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_behaviourClassMeta);
    }
    if (data.containsKey('confidence')) {
      context.handle(
        _confidenceMeta,
        confidence.isAcceptableOrUnknown(data['confidence']!, _confidenceMeta),
      );
    } else if (isInserting) {
      context.missing(_confidenceMeta);
    }
    if (data.containsKey('window_start')) {
      context.handle(
        _windowStartMeta,
        windowStart.isAcceptableOrUnknown(
          data['window_start']!,
          _windowStartMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_windowStartMeta);
    }
    if (data.containsKey('window_end')) {
      context.handle(
        _windowEndMeta,
        windowEnd.isAcceptableOrUnknown(data['window_end']!, _windowEndMeta),
      );
    } else if (isInserting) {
      context.missing(_windowEndMeta);
    }
    if (data.containsKey('prob_grazing')) {
      context.handle(
        _probGrazingMeta,
        probGrazing.isAcceptableOrUnknown(
          data['prob_grazing']!,
          _probGrazingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probGrazingMeta);
    }
    if (data.containsKey('prob_ruminating')) {
      context.handle(
        _probRuminatingMeta,
        probRuminating.isAcceptableOrUnknown(
          data['prob_ruminating']!,
          _probRuminatingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probRuminatingMeta);
    }
    if (data.containsKey('prob_standing')) {
      context.handle(
        _probStandingMeta,
        probStanding.isAcceptableOrUnknown(
          data['prob_standing']!,
          _probStandingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probStandingMeta);
    }
    if (data.containsKey('prob_lying')) {
      context.handle(
        _probLyingMeta,
        probLying.isAcceptableOrUnknown(data['prob_lying']!, _probLyingMeta),
      );
    } else if (isInserting) {
      context.missing(_probLyingMeta);
    }
    if (data.containsKey('prob_walking')) {
      context.handle(
        _probWalkingMeta,
        probWalking.isAcceptableOrUnknown(
          data['prob_walking']!,
          _probWalkingMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_probWalkingMeta);
    }
    if (data.containsKey('alert_processed')) {
      context.handle(
        _alertProcessedMeta,
        alertProcessed.isAcceptableOrUnknown(
          data['alert_processed']!,
          _alertProcessedMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BehaviourClassificationData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BehaviourClassificationData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      behaviourClass: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}behaviour_class'],
      )!,
      confidence: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}confidence'],
      )!,
      windowStart: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}window_start'],
      )!,
      windowEnd: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}window_end'],
      )!,
      probGrazing: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prob_grazing'],
      )!,
      probRuminating: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prob_ruminating'],
      )!,
      probStanding: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prob_standing'],
      )!,
      probLying: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prob_lying'],
      )!,
      probWalking: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prob_walking'],
      )!,
      alertProcessed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}alert_processed'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $BehaviourClassificationTable createAlias(String alias) {
    return $BehaviourClassificationTable(attachedDatabase, alias);
  }
}

class BehaviourClassificationData extends DataClass
    implements Insertable<BehaviourClassificationData> {
  final String id;
  final String animalId;

  /// Timestamp when inference was run
  final DateTime timestamp;

  /// Index of the highest-probability class (0–4)
  /// Use BehaviourClass.labelFor(behaviourClass) to get the string label
  final int behaviourClass;

  /// Softmax probability of the predicted class (0.0–1.0)
  final double confidence;

  /// Start of the 100-sample accelerometer window that produced this result
  final DateTime windowStart;

  /// End of the window — always windowStart + 10 seconds at 10Hz
  final DateTime windowEnd;

  /// P(grazing) — index 0
  final double probGrazing;

  /// P(ruminating) — index 1
  final double probRuminating;

  /// P(standing) — index 2
  final double probStanding;

  /// P(lying) — index 3 — undertrained
  final double probLying;

  /// P(walking) — index 4 — undertrained
  final double probWalking;

  /// Set to true once the alert logic has evaluated this record.
  /// Prevents the same window from triggering duplicate alerts.
  final bool alertProcessed;

  /// 0 = pending upload to Firestore, 1 = synced
  /// Consumed by Lynn's sync engine
  final int synced;
  const BehaviourClassificationData({
    required this.id,
    required this.animalId,
    required this.timestamp,
    required this.behaviourClass,
    required this.confidence,
    required this.windowStart,
    required this.windowEnd,
    required this.probGrazing,
    required this.probRuminating,
    required this.probStanding,
    required this.probLying,
    required this.probWalking,
    required this.alertProcessed,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['behaviour_class'] = Variable<int>(behaviourClass);
    map['confidence'] = Variable<double>(confidence);
    map['window_start'] = Variable<DateTime>(windowStart);
    map['window_end'] = Variable<DateTime>(windowEnd);
    map['prob_grazing'] = Variable<double>(probGrazing);
    map['prob_ruminating'] = Variable<double>(probRuminating);
    map['prob_standing'] = Variable<double>(probStanding);
    map['prob_lying'] = Variable<double>(probLying);
    map['prob_walking'] = Variable<double>(probWalking);
    map['alert_processed'] = Variable<bool>(alertProcessed);
    map['synced'] = Variable<int>(synced);
    return map;
  }

  BehaviourClassificationCompanion toCompanion(bool nullToAbsent) {
    return BehaviourClassificationCompanion(
      id: Value(id),
      animalId: Value(animalId),
      timestamp: Value(timestamp),
      behaviourClass: Value(behaviourClass),
      confidence: Value(confidence),
      windowStart: Value(windowStart),
      windowEnd: Value(windowEnd),
      probGrazing: Value(probGrazing),
      probRuminating: Value(probRuminating),
      probStanding: Value(probStanding),
      probLying: Value(probLying),
      probWalking: Value(probWalking),
      alertProcessed: Value(alertProcessed),
      synced: Value(synced),
    );
  }

  factory BehaviourClassificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BehaviourClassificationData(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      behaviourClass: serializer.fromJson<int>(json['behaviourClass']),
      confidence: serializer.fromJson<double>(json['confidence']),
      windowStart: serializer.fromJson<DateTime>(json['windowStart']),
      windowEnd: serializer.fromJson<DateTime>(json['windowEnd']),
      probGrazing: serializer.fromJson<double>(json['probGrazing']),
      probRuminating: serializer.fromJson<double>(json['probRuminating']),
      probStanding: serializer.fromJson<double>(json['probStanding']),
      probLying: serializer.fromJson<double>(json['probLying']),
      probWalking: serializer.fromJson<double>(json['probWalking']),
      alertProcessed: serializer.fromJson<bool>(json['alertProcessed']),
      synced: serializer.fromJson<int>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'behaviourClass': serializer.toJson<int>(behaviourClass),
      'confidence': serializer.toJson<double>(confidence),
      'windowStart': serializer.toJson<DateTime>(windowStart),
      'windowEnd': serializer.toJson<DateTime>(windowEnd),
      'probGrazing': serializer.toJson<double>(probGrazing),
      'probRuminating': serializer.toJson<double>(probRuminating),
      'probStanding': serializer.toJson<double>(probStanding),
      'probLying': serializer.toJson<double>(probLying),
      'probWalking': serializer.toJson<double>(probWalking),
      'alertProcessed': serializer.toJson<bool>(alertProcessed),
      'synced': serializer.toJson<int>(synced),
    };
  }

  BehaviourClassificationData copyWith({
    String? id,
    String? animalId,
    DateTime? timestamp,
    int? behaviourClass,
    double? confidence,
    DateTime? windowStart,
    DateTime? windowEnd,
    double? probGrazing,
    double? probRuminating,
    double? probStanding,
    double? probLying,
    double? probWalking,
    bool? alertProcessed,
    int? synced,
  }) => BehaviourClassificationData(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    timestamp: timestamp ?? this.timestamp,
    behaviourClass: behaviourClass ?? this.behaviourClass,
    confidence: confidence ?? this.confidence,
    windowStart: windowStart ?? this.windowStart,
    windowEnd: windowEnd ?? this.windowEnd,
    probGrazing: probGrazing ?? this.probGrazing,
    probRuminating: probRuminating ?? this.probRuminating,
    probStanding: probStanding ?? this.probStanding,
    probLying: probLying ?? this.probLying,
    probWalking: probWalking ?? this.probWalking,
    alertProcessed: alertProcessed ?? this.alertProcessed,
    synced: synced ?? this.synced,
  );
  BehaviourClassificationData copyWithCompanion(
    BehaviourClassificationCompanion data,
  ) {
    return BehaviourClassificationData(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      behaviourClass: data.behaviourClass.present
          ? data.behaviourClass.value
          : this.behaviourClass,
      confidence: data.confidence.present
          ? data.confidence.value
          : this.confidence,
      windowStart: data.windowStart.present
          ? data.windowStart.value
          : this.windowStart,
      windowEnd: data.windowEnd.present ? data.windowEnd.value : this.windowEnd,
      probGrazing: data.probGrazing.present
          ? data.probGrazing.value
          : this.probGrazing,
      probRuminating: data.probRuminating.present
          ? data.probRuminating.value
          : this.probRuminating,
      probStanding: data.probStanding.present
          ? data.probStanding.value
          : this.probStanding,
      probLying: data.probLying.present ? data.probLying.value : this.probLying,
      probWalking: data.probWalking.present
          ? data.probWalking.value
          : this.probWalking,
      alertProcessed: data.alertProcessed.present
          ? data.alertProcessed.value
          : this.alertProcessed,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BehaviourClassificationData(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('timestamp: $timestamp, ')
          ..write('behaviourClass: $behaviourClass, ')
          ..write('confidence: $confidence, ')
          ..write('windowStart: $windowStart, ')
          ..write('windowEnd: $windowEnd, ')
          ..write('probGrazing: $probGrazing, ')
          ..write('probRuminating: $probRuminating, ')
          ..write('probStanding: $probStanding, ')
          ..write('probLying: $probLying, ')
          ..write('probWalking: $probWalking, ')
          ..write('alertProcessed: $alertProcessed, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    timestamp,
    behaviourClass,
    confidence,
    windowStart,
    windowEnd,
    probGrazing,
    probRuminating,
    probStanding,
    probLying,
    probWalking,
    alertProcessed,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BehaviourClassificationData &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.timestamp == this.timestamp &&
          other.behaviourClass == this.behaviourClass &&
          other.confidence == this.confidence &&
          other.windowStart == this.windowStart &&
          other.windowEnd == this.windowEnd &&
          other.probGrazing == this.probGrazing &&
          other.probRuminating == this.probRuminating &&
          other.probStanding == this.probStanding &&
          other.probLying == this.probLying &&
          other.probWalking == this.probWalking &&
          other.alertProcessed == this.alertProcessed &&
          other.synced == this.synced);
}

class BehaviourClassificationCompanion
    extends UpdateCompanion<BehaviourClassificationData> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<DateTime> timestamp;
  final Value<int> behaviourClass;
  final Value<double> confidence;
  final Value<DateTime> windowStart;
  final Value<DateTime> windowEnd;
  final Value<double> probGrazing;
  final Value<double> probRuminating;
  final Value<double> probStanding;
  final Value<double> probLying;
  final Value<double> probWalking;
  final Value<bool> alertProcessed;
  final Value<int> synced;
  final Value<int> rowid;
  const BehaviourClassificationCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.behaviourClass = const Value.absent(),
    this.confidence = const Value.absent(),
    this.windowStart = const Value.absent(),
    this.windowEnd = const Value.absent(),
    this.probGrazing = const Value.absent(),
    this.probRuminating = const Value.absent(),
    this.probStanding = const Value.absent(),
    this.probLying = const Value.absent(),
    this.probWalking = const Value.absent(),
    this.alertProcessed = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BehaviourClassificationCompanion.insert({
    required String id,
    required String animalId,
    required DateTime timestamp,
    required int behaviourClass,
    required double confidence,
    required DateTime windowStart,
    required DateTime windowEnd,
    required double probGrazing,
    required double probRuminating,
    required double probStanding,
    required double probLying,
    required double probWalking,
    this.alertProcessed = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       timestamp = Value(timestamp),
       behaviourClass = Value(behaviourClass),
       confidence = Value(confidence),
       windowStart = Value(windowStart),
       windowEnd = Value(windowEnd),
       probGrazing = Value(probGrazing),
       probRuminating = Value(probRuminating),
       probStanding = Value(probStanding),
       probLying = Value(probLying),
       probWalking = Value(probWalking);
  static Insertable<BehaviourClassificationData> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<DateTime>? timestamp,
    Expression<int>? behaviourClass,
    Expression<double>? confidence,
    Expression<DateTime>? windowStart,
    Expression<DateTime>? windowEnd,
    Expression<double>? probGrazing,
    Expression<double>? probRuminating,
    Expression<double>? probStanding,
    Expression<double>? probLying,
    Expression<double>? probWalking,
    Expression<bool>? alertProcessed,
    Expression<int>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (timestamp != null) 'timestamp': timestamp,
      if (behaviourClass != null) 'behaviour_class': behaviourClass,
      if (confidence != null) 'confidence': confidence,
      if (windowStart != null) 'window_start': windowStart,
      if (windowEnd != null) 'window_end': windowEnd,
      if (probGrazing != null) 'prob_grazing': probGrazing,
      if (probRuminating != null) 'prob_ruminating': probRuminating,
      if (probStanding != null) 'prob_standing': probStanding,
      if (probLying != null) 'prob_lying': probLying,
      if (probWalking != null) 'prob_walking': probWalking,
      if (alertProcessed != null) 'alert_processed': alertProcessed,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BehaviourClassificationCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<DateTime>? timestamp,
    Value<int>? behaviourClass,
    Value<double>? confidence,
    Value<DateTime>? windowStart,
    Value<DateTime>? windowEnd,
    Value<double>? probGrazing,
    Value<double>? probRuminating,
    Value<double>? probStanding,
    Value<double>? probLying,
    Value<double>? probWalking,
    Value<bool>? alertProcessed,
    Value<int>? synced,
    Value<int>? rowid,
  }) {
    return BehaviourClassificationCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      timestamp: timestamp ?? this.timestamp,
      behaviourClass: behaviourClass ?? this.behaviourClass,
      confidence: confidence ?? this.confidence,
      windowStart: windowStart ?? this.windowStart,
      windowEnd: windowEnd ?? this.windowEnd,
      probGrazing: probGrazing ?? this.probGrazing,
      probRuminating: probRuminating ?? this.probRuminating,
      probStanding: probStanding ?? this.probStanding,
      probLying: probLying ?? this.probLying,
      probWalking: probWalking ?? this.probWalking,
      alertProcessed: alertProcessed ?? this.alertProcessed,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (behaviourClass.present) {
      map['behaviour_class'] = Variable<int>(behaviourClass.value);
    }
    if (confidence.present) {
      map['confidence'] = Variable<double>(confidence.value);
    }
    if (windowStart.present) {
      map['window_start'] = Variable<DateTime>(windowStart.value);
    }
    if (windowEnd.present) {
      map['window_end'] = Variable<DateTime>(windowEnd.value);
    }
    if (probGrazing.present) {
      map['prob_grazing'] = Variable<double>(probGrazing.value);
    }
    if (probRuminating.present) {
      map['prob_ruminating'] = Variable<double>(probRuminating.value);
    }
    if (probStanding.present) {
      map['prob_standing'] = Variable<double>(probStanding.value);
    }
    if (probLying.present) {
      map['prob_lying'] = Variable<double>(probLying.value);
    }
    if (probWalking.present) {
      map['prob_walking'] = Variable<double>(probWalking.value);
    }
    if (alertProcessed.present) {
      map['alert_processed'] = Variable<bool>(alertProcessed.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BehaviourClassificationCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('timestamp: $timestamp, ')
          ..write('behaviourClass: $behaviourClass, ')
          ..write('confidence: $confidence, ')
          ..write('windowStart: $windowStart, ')
          ..write('windowEnd: $windowEnd, ')
          ..write('probGrazing: $probGrazing, ')
          ..write('probRuminating: $probRuminating, ')
          ..write('probStanding: $probStanding, ')
          ..write('probLying: $probLying, ')
          ..write('probWalking: $probWalking, ')
          ..write('alertProcessed: $alertProcessed, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DistressAlertTable extends DistressAlert
    with TableInfo<$DistressAlertTable, DistressAlertData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DistressAlertTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _animalIdMeta = const VerificationMeta(
    'animalId',
  );
  @override
  late final GeneratedColumn<String> animalId = GeneratedColumn<String>(
    'animal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES animal (id)',
    ),
  );
  static const VerificationMeta _classificationIdMeta = const VerificationMeta(
    'classificationId',
  );
  @override
  late final GeneratedColumn<String> classificationId = GeneratedColumn<String>(
    'classification_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES behaviour_classification (id)',
    ),
  );
  static const VerificationMeta _pastoralistIdMeta = const VerificationMeta(
    'pastoralistId',
  );
  @override
  late final GeneratedColumn<String> pastoralistId = GeneratedColumn<String>(
    'pastoralist_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pastoralist (id)',
    ),
  );
  static const VerificationMeta _alertTypeMeta = const VerificationMeta(
    'alertType',
  );
  @override
  late final GeneratedColumn<String> alertType = GeneratedColumn<String>(
    'alert_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _severityMeta = const VerificationMeta(
    'severity',
  );
  @override
  late final GeneratedColumn<String> severity = GeneratedColumn<String>(
    'severity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isAcknowledgedMeta = const VerificationMeta(
    'isAcknowledged',
  );
  @override
  late final GeneratedColumn<int> isAcknowledged = GeneratedColumn<int>(
    'is_acknowledged',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<int> synced = GeneratedColumn<int>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    animalId,
    classificationId,
    pastoralistId,
    alertType,
    message,
    severity,
    timestamp,
    isAcknowledged,
    synced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'distress_alert';
  @override
  VerificationContext validateIntegrity(
    Insertable<DistressAlertData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('animal_id')) {
      context.handle(
        _animalIdMeta,
        animalId.isAcceptableOrUnknown(data['animal_id']!, _animalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_animalIdMeta);
    }
    if (data.containsKey('classification_id')) {
      context.handle(
        _classificationIdMeta,
        classificationId.isAcceptableOrUnknown(
          data['classification_id']!,
          _classificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_classificationIdMeta);
    }
    if (data.containsKey('pastoralist_id')) {
      context.handle(
        _pastoralistIdMeta,
        pastoralistId.isAcceptableOrUnknown(
          data['pastoralist_id']!,
          _pastoralistIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pastoralistIdMeta);
    }
    if (data.containsKey('alert_type')) {
      context.handle(
        _alertTypeMeta,
        alertType.isAcceptableOrUnknown(data['alert_type']!, _alertTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_alertTypeMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('severity')) {
      context.handle(
        _severityMeta,
        severity.isAcceptableOrUnknown(data['severity']!, _severityMeta),
      );
    } else if (isInserting) {
      context.missing(_severityMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    if (data.containsKey('is_acknowledged')) {
      context.handle(
        _isAcknowledgedMeta,
        isAcknowledged.isAcceptableOrUnknown(
          data['is_acknowledged']!,
          _isAcknowledgedMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DistressAlertData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DistressAlertData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      animalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}animal_id'],
      )!,
      classificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}classification_id'],
      )!,
      pastoralistId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pastoralist_id'],
      )!,
      alertType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alert_type'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      severity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}severity'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
      isAcknowledged: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}is_acknowledged'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}synced'],
      )!,
    );
  }

  @override
  $DistressAlertTable createAlias(String alias) {
    return $DistressAlertTable(attachedDatabase, alias);
  }
}

class DistressAlertData extends DataClass
    implements Insertable<DistressAlertData> {
  final String id;
  final String animalId;

  /// The specific classification record that pushed the threshold over the limit
  final String classificationId;
  final String pastoralistId;

  /// One of AlertType constants: 'low_feeding', 'low_rumination', 'excessive_walking'
  final String alertType;

  /// Human-readable alert message for display in the UI
  /// e.g. "Bessie has been grazing for only 2.1 hours in the last 24 hours"
  final String message;

  /// One of AlertSeverity constants: 'HIGH' or 'MEDIUM'
  final String severity;
  final DateTime timestamp;

  /// 0 = unread by pastoralist, 1 = acknowledged in the UI
  final int isAcknowledged;

  /// 0 = pending upload to Firestore, 1 = synced
  /// Consumed by Lynn's sync engine
  final int synced;
  const DistressAlertData({
    required this.id,
    required this.animalId,
    required this.classificationId,
    required this.pastoralistId,
    required this.alertType,
    required this.message,
    required this.severity,
    required this.timestamp,
    required this.isAcknowledged,
    required this.synced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['animal_id'] = Variable<String>(animalId);
    map['classification_id'] = Variable<String>(classificationId);
    map['pastoralist_id'] = Variable<String>(pastoralistId);
    map['alert_type'] = Variable<String>(alertType);
    map['message'] = Variable<String>(message);
    map['severity'] = Variable<String>(severity);
    map['timestamp'] = Variable<DateTime>(timestamp);
    map['is_acknowledged'] = Variable<int>(isAcknowledged);
    map['synced'] = Variable<int>(synced);
    return map;
  }

  DistressAlertCompanion toCompanion(bool nullToAbsent) {
    return DistressAlertCompanion(
      id: Value(id),
      animalId: Value(animalId),
      classificationId: Value(classificationId),
      pastoralistId: Value(pastoralistId),
      alertType: Value(alertType),
      message: Value(message),
      severity: Value(severity),
      timestamp: Value(timestamp),
      isAcknowledged: Value(isAcknowledged),
      synced: Value(synced),
    );
  }

  factory DistressAlertData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DistressAlertData(
      id: serializer.fromJson<String>(json['id']),
      animalId: serializer.fromJson<String>(json['animalId']),
      classificationId: serializer.fromJson<String>(json['classificationId']),
      pastoralistId: serializer.fromJson<String>(json['pastoralistId']),
      alertType: serializer.fromJson<String>(json['alertType']),
      message: serializer.fromJson<String>(json['message']),
      severity: serializer.fromJson<String>(json['severity']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      isAcknowledged: serializer.fromJson<int>(json['isAcknowledged']),
      synced: serializer.fromJson<int>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'animalId': serializer.toJson<String>(animalId),
      'classificationId': serializer.toJson<String>(classificationId),
      'pastoralistId': serializer.toJson<String>(pastoralistId),
      'alertType': serializer.toJson<String>(alertType),
      'message': serializer.toJson<String>(message),
      'severity': serializer.toJson<String>(severity),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'isAcknowledged': serializer.toJson<int>(isAcknowledged),
      'synced': serializer.toJson<int>(synced),
    };
  }

  DistressAlertData copyWith({
    String? id,
    String? animalId,
    String? classificationId,
    String? pastoralistId,
    String? alertType,
    String? message,
    String? severity,
    DateTime? timestamp,
    int? isAcknowledged,
    int? synced,
  }) => DistressAlertData(
    id: id ?? this.id,
    animalId: animalId ?? this.animalId,
    classificationId: classificationId ?? this.classificationId,
    pastoralistId: pastoralistId ?? this.pastoralistId,
    alertType: alertType ?? this.alertType,
    message: message ?? this.message,
    severity: severity ?? this.severity,
    timestamp: timestamp ?? this.timestamp,
    isAcknowledged: isAcknowledged ?? this.isAcknowledged,
    synced: synced ?? this.synced,
  );
  DistressAlertData copyWithCompanion(DistressAlertCompanion data) {
    return DistressAlertData(
      id: data.id.present ? data.id.value : this.id,
      animalId: data.animalId.present ? data.animalId.value : this.animalId,
      classificationId: data.classificationId.present
          ? data.classificationId.value
          : this.classificationId,
      pastoralistId: data.pastoralistId.present
          ? data.pastoralistId.value
          : this.pastoralistId,
      alertType: data.alertType.present ? data.alertType.value : this.alertType,
      message: data.message.present ? data.message.value : this.message,
      severity: data.severity.present ? data.severity.value : this.severity,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      isAcknowledged: data.isAcknowledged.present
          ? data.isAcknowledged.value
          : this.isAcknowledged,
      synced: data.synced.present ? data.synced.value : this.synced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DistressAlertData(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('classificationId: $classificationId, ')
          ..write('pastoralistId: $pastoralistId, ')
          ..write('alertType: $alertType, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('timestamp: $timestamp, ')
          ..write('isAcknowledged: $isAcknowledged, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    animalId,
    classificationId,
    pastoralistId,
    alertType,
    message,
    severity,
    timestamp,
    isAcknowledged,
    synced,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DistressAlertData &&
          other.id == this.id &&
          other.animalId == this.animalId &&
          other.classificationId == this.classificationId &&
          other.pastoralistId == this.pastoralistId &&
          other.alertType == this.alertType &&
          other.message == this.message &&
          other.severity == this.severity &&
          other.timestamp == this.timestamp &&
          other.isAcknowledged == this.isAcknowledged &&
          other.synced == this.synced);
}

class DistressAlertCompanion extends UpdateCompanion<DistressAlertData> {
  final Value<String> id;
  final Value<String> animalId;
  final Value<String> classificationId;
  final Value<String> pastoralistId;
  final Value<String> alertType;
  final Value<String> message;
  final Value<String> severity;
  final Value<DateTime> timestamp;
  final Value<int> isAcknowledged;
  final Value<int> synced;
  final Value<int> rowid;
  const DistressAlertCompanion({
    this.id = const Value.absent(),
    this.animalId = const Value.absent(),
    this.classificationId = const Value.absent(),
    this.pastoralistId = const Value.absent(),
    this.alertType = const Value.absent(),
    this.message = const Value.absent(),
    this.severity = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.isAcknowledged = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DistressAlertCompanion.insert({
    required String id,
    required String animalId,
    required String classificationId,
    required String pastoralistId,
    required String alertType,
    required String message,
    required String severity,
    required DateTime timestamp,
    this.isAcknowledged = const Value.absent(),
    this.synced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       animalId = Value(animalId),
       classificationId = Value(classificationId),
       pastoralistId = Value(pastoralistId),
       alertType = Value(alertType),
       message = Value(message),
       severity = Value(severity),
       timestamp = Value(timestamp);
  static Insertable<DistressAlertData> custom({
    Expression<String>? id,
    Expression<String>? animalId,
    Expression<String>? classificationId,
    Expression<String>? pastoralistId,
    Expression<String>? alertType,
    Expression<String>? message,
    Expression<String>? severity,
    Expression<DateTime>? timestamp,
    Expression<int>? isAcknowledged,
    Expression<int>? synced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (animalId != null) 'animal_id': animalId,
      if (classificationId != null) 'classification_id': classificationId,
      if (pastoralistId != null) 'pastoralist_id': pastoralistId,
      if (alertType != null) 'alert_type': alertType,
      if (message != null) 'message': message,
      if (severity != null) 'severity': severity,
      if (timestamp != null) 'timestamp': timestamp,
      if (isAcknowledged != null) 'is_acknowledged': isAcknowledged,
      if (synced != null) 'synced': synced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DistressAlertCompanion copyWith({
    Value<String>? id,
    Value<String>? animalId,
    Value<String>? classificationId,
    Value<String>? pastoralistId,
    Value<String>? alertType,
    Value<String>? message,
    Value<String>? severity,
    Value<DateTime>? timestamp,
    Value<int>? isAcknowledged,
    Value<int>? synced,
    Value<int>? rowid,
  }) {
    return DistressAlertCompanion(
      id: id ?? this.id,
      animalId: animalId ?? this.animalId,
      classificationId: classificationId ?? this.classificationId,
      pastoralistId: pastoralistId ?? this.pastoralistId,
      alertType: alertType ?? this.alertType,
      message: message ?? this.message,
      severity: severity ?? this.severity,
      timestamp: timestamp ?? this.timestamp,
      isAcknowledged: isAcknowledged ?? this.isAcknowledged,
      synced: synced ?? this.synced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (animalId.present) {
      map['animal_id'] = Variable<String>(animalId.value);
    }
    if (classificationId.present) {
      map['classification_id'] = Variable<String>(classificationId.value);
    }
    if (pastoralistId.present) {
      map['pastoralist_id'] = Variable<String>(pastoralistId.value);
    }
    if (alertType.present) {
      map['alert_type'] = Variable<String>(alertType.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (severity.present) {
      map['severity'] = Variable<String>(severity.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (isAcknowledged.present) {
      map['is_acknowledged'] = Variable<int>(isAcknowledged.value);
    }
    if (synced.present) {
      map['synced'] = Variable<int>(synced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DistressAlertCompanion(')
          ..write('id: $id, ')
          ..write('animalId: $animalId, ')
          ..write('classificationId: $classificationId, ')
          ..write('pastoralistId: $pastoralistId, ')
          ..write('alertType: $alertType, ')
          ..write('message: $message, ')
          ..write('severity: $severity, ')
          ..write('timestamp: $timestamp, ')
          ..write('isAcknowledged: $isAcknowledged, ')
          ..write('synced: $synced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PastureMapTable extends PastureMap
    with TableInfo<$PastureMapTable, PastureMapData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PastureMapTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _generatedAtMeta = const VerificationMeta(
    'generatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> generatedAt = GeneratedColumn<DateTime>(
    'generated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ndviScoreMeta = const VerificationMeta(
    'ndviScore',
  );
  @override
  late final GeneratedColumn<double> ndviScore = GeneratedColumn<double>(
    'ndvi_score',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conditionMeta = const VerificationMeta(
    'condition',
  );
  @override
  late final GeneratedColumn<String> condition = GeneratedColumn<String>(
    'condition',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _biomassKgPerHaMeta = const VerificationMeta(
    'biomassKgPerHa',
  );
  @override
  late final GeneratedColumn<double> biomassKgPerHa = GeneratedColumn<double>(
    'biomass_kg_per_ha',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _areaHaMeta = const VerificationMeta('areaHa');
  @override
  late final GeneratedColumn<double> areaHa = GeneratedColumn<double>(
    'area_ha',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalBiomassKgMeta = const VerificationMeta(
    'totalBiomassKg',
  );
  @override
  late final GeneratedColumn<double> totalBiomassKg = GeneratedColumn<double>(
    'total_biomass_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _carryingCapacityMeta = const VerificationMeta(
    'carryingCapacity',
  );
  @override
  late final GeneratedColumn<int> carryingCapacity = GeneratedColumn<int>(
    'carrying_capacity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationDaysMeta = const VerificationMeta(
    'durationDays',
  );
  @override
  late final GeneratedColumn<int> durationDays = GeneratedColumn<int>(
    'duration_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tilePathMeta = const VerificationMeta(
    'tilePath',
  );
  @override
  late final GeneratedColumn<String> tilePath = GeneratedColumn<String>(
    'tile_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    region,
    generatedAt,
    ndviScore,
    condition,
    biomassKgPerHa,
    areaHa,
    totalBiomassKg,
    carryingCapacity,
    durationDays,
    tilePath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pasture_map';
  @override
  VerificationContext validateIntegrity(
    Insertable<PastureMapData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    } else if (isInserting) {
      context.missing(_regionMeta);
    }
    if (data.containsKey('generated_at')) {
      context.handle(
        _generatedAtMeta,
        generatedAt.isAcceptableOrUnknown(
          data['generated_at']!,
          _generatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_generatedAtMeta);
    }
    if (data.containsKey('ndvi_score')) {
      context.handle(
        _ndviScoreMeta,
        ndviScore.isAcceptableOrUnknown(data['ndvi_score']!, _ndviScoreMeta),
      );
    } else if (isInserting) {
      context.missing(_ndviScoreMeta);
    }
    if (data.containsKey('condition')) {
      context.handle(
        _conditionMeta,
        condition.isAcceptableOrUnknown(data['condition']!, _conditionMeta),
      );
    } else if (isInserting) {
      context.missing(_conditionMeta);
    }
    if (data.containsKey('biomass_kg_per_ha')) {
      context.handle(
        _biomassKgPerHaMeta,
        biomassKgPerHa.isAcceptableOrUnknown(
          data['biomass_kg_per_ha']!,
          _biomassKgPerHaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_biomassKgPerHaMeta);
    }
    if (data.containsKey('area_ha')) {
      context.handle(
        _areaHaMeta,
        areaHa.isAcceptableOrUnknown(data['area_ha']!, _areaHaMeta),
      );
    } else if (isInserting) {
      context.missing(_areaHaMeta);
    }
    if (data.containsKey('total_biomass_kg')) {
      context.handle(
        _totalBiomassKgMeta,
        totalBiomassKg.isAcceptableOrUnknown(
          data['total_biomass_kg']!,
          _totalBiomassKgMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalBiomassKgMeta);
    }
    if (data.containsKey('carrying_capacity')) {
      context.handle(
        _carryingCapacityMeta,
        carryingCapacity.isAcceptableOrUnknown(
          data['carrying_capacity']!,
          _carryingCapacityMeta,
        ),
      );
    }
    if (data.containsKey('duration_days')) {
      context.handle(
        _durationDaysMeta,
        durationDays.isAcceptableOrUnknown(
          data['duration_days']!,
          _durationDaysMeta,
        ),
      );
    }
    if (data.containsKey('tile_path')) {
      context.handle(
        _tilePathMeta,
        tilePath.isAcceptableOrUnknown(data['tile_path']!, _tilePathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PastureMapData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PastureMapData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      )!,
      generatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}generated_at'],
      )!,
      ndviScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ndvi_score'],
      )!,
      condition: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}condition'],
      )!,
      biomassKgPerHa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}biomass_kg_per_ha'],
      )!,
      areaHa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}area_ha'],
      )!,
      totalBiomassKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_biomass_kg'],
      )!,
      carryingCapacity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}carrying_capacity'],
      ),
      durationDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_days'],
      ),
      tilePath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tile_path'],
      ),
    );
  }

  @override
  $PastureMapTable createAlias(String alias) {
    return $PastureMapTable(attachedDatabase, alias);
  }
}

class PastureMapData extends DataClass implements Insertable<PastureMapData> {
  final String id;

  /// Zone or paddock name e.g. "Laikipia North Block A"
  final String region;

  /// When Moses' satellite analysis pipeline last ran for this region
  final DateTime generatedAt;

  /// Normalised Difference Vegetation Index: 0.0 (bare) to 1.0 (dense)
  final double ndviScore;

  /// Human-readable condition derived from NDVI: "good", "moderate", "poor"
  final String condition;

  /// Dry matter biomass available per hectare (kg/ha)
  final double biomassKgPerHa;

  /// Total area of the pasture zone in hectares
  final double areaHa;

  /// Total available biomass = biomassKgPerHa × areaHa
  final double totalBiomassKg;

  /// Maximum number of animals this pasture can sustain at current biomass
  final int? carryingCapacity;

  /// Number of days the pasture can sustain the carrying capacity load
  final int? durationDays;

  /// Local file system path to the cached MBTiles map file for offline rendering
  /// Null if map tiles have not been downloaded yet
  final String? tilePath;
  const PastureMapData({
    required this.id,
    required this.region,
    required this.generatedAt,
    required this.ndviScore,
    required this.condition,
    required this.biomassKgPerHa,
    required this.areaHa,
    required this.totalBiomassKg,
    this.carryingCapacity,
    this.durationDays,
    this.tilePath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['region'] = Variable<String>(region);
    map['generated_at'] = Variable<DateTime>(generatedAt);
    map['ndvi_score'] = Variable<double>(ndviScore);
    map['condition'] = Variable<String>(condition);
    map['biomass_kg_per_ha'] = Variable<double>(biomassKgPerHa);
    map['area_ha'] = Variable<double>(areaHa);
    map['total_biomass_kg'] = Variable<double>(totalBiomassKg);
    if (!nullToAbsent || carryingCapacity != null) {
      map['carrying_capacity'] = Variable<int>(carryingCapacity);
    }
    if (!nullToAbsent || durationDays != null) {
      map['duration_days'] = Variable<int>(durationDays);
    }
    if (!nullToAbsent || tilePath != null) {
      map['tile_path'] = Variable<String>(tilePath);
    }
    return map;
  }

  PastureMapCompanion toCompanion(bool nullToAbsent) {
    return PastureMapCompanion(
      id: Value(id),
      region: Value(region),
      generatedAt: Value(generatedAt),
      ndviScore: Value(ndviScore),
      condition: Value(condition),
      biomassKgPerHa: Value(biomassKgPerHa),
      areaHa: Value(areaHa),
      totalBiomassKg: Value(totalBiomassKg),
      carryingCapacity: carryingCapacity == null && nullToAbsent
          ? const Value.absent()
          : Value(carryingCapacity),
      durationDays: durationDays == null && nullToAbsent
          ? const Value.absent()
          : Value(durationDays),
      tilePath: tilePath == null && nullToAbsent
          ? const Value.absent()
          : Value(tilePath),
    );
  }

  factory PastureMapData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PastureMapData(
      id: serializer.fromJson<String>(json['id']),
      region: serializer.fromJson<String>(json['region']),
      generatedAt: serializer.fromJson<DateTime>(json['generatedAt']),
      ndviScore: serializer.fromJson<double>(json['ndviScore']),
      condition: serializer.fromJson<String>(json['condition']),
      biomassKgPerHa: serializer.fromJson<double>(json['biomassKgPerHa']),
      areaHa: serializer.fromJson<double>(json['areaHa']),
      totalBiomassKg: serializer.fromJson<double>(json['totalBiomassKg']),
      carryingCapacity: serializer.fromJson<int?>(json['carryingCapacity']),
      durationDays: serializer.fromJson<int?>(json['durationDays']),
      tilePath: serializer.fromJson<String?>(json['tilePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'region': serializer.toJson<String>(region),
      'generatedAt': serializer.toJson<DateTime>(generatedAt),
      'ndviScore': serializer.toJson<double>(ndviScore),
      'condition': serializer.toJson<String>(condition),
      'biomassKgPerHa': serializer.toJson<double>(biomassKgPerHa),
      'areaHa': serializer.toJson<double>(areaHa),
      'totalBiomassKg': serializer.toJson<double>(totalBiomassKg),
      'carryingCapacity': serializer.toJson<int?>(carryingCapacity),
      'durationDays': serializer.toJson<int?>(durationDays),
      'tilePath': serializer.toJson<String?>(tilePath),
    };
  }

  PastureMapData copyWith({
    String? id,
    String? region,
    DateTime? generatedAt,
    double? ndviScore,
    String? condition,
    double? biomassKgPerHa,
    double? areaHa,
    double? totalBiomassKg,
    Value<int?> carryingCapacity = const Value.absent(),
    Value<int?> durationDays = const Value.absent(),
    Value<String?> tilePath = const Value.absent(),
  }) => PastureMapData(
    id: id ?? this.id,
    region: region ?? this.region,
    generatedAt: generatedAt ?? this.generatedAt,
    ndviScore: ndviScore ?? this.ndviScore,
    condition: condition ?? this.condition,
    biomassKgPerHa: biomassKgPerHa ?? this.biomassKgPerHa,
    areaHa: areaHa ?? this.areaHa,
    totalBiomassKg: totalBiomassKg ?? this.totalBiomassKg,
    carryingCapacity: carryingCapacity.present
        ? carryingCapacity.value
        : this.carryingCapacity,
    durationDays: durationDays.present ? durationDays.value : this.durationDays,
    tilePath: tilePath.present ? tilePath.value : this.tilePath,
  );
  PastureMapData copyWithCompanion(PastureMapCompanion data) {
    return PastureMapData(
      id: data.id.present ? data.id.value : this.id,
      region: data.region.present ? data.region.value : this.region,
      generatedAt: data.generatedAt.present
          ? data.generatedAt.value
          : this.generatedAt,
      ndviScore: data.ndviScore.present ? data.ndviScore.value : this.ndviScore,
      condition: data.condition.present ? data.condition.value : this.condition,
      biomassKgPerHa: data.biomassKgPerHa.present
          ? data.biomassKgPerHa.value
          : this.biomassKgPerHa,
      areaHa: data.areaHa.present ? data.areaHa.value : this.areaHa,
      totalBiomassKg: data.totalBiomassKg.present
          ? data.totalBiomassKg.value
          : this.totalBiomassKg,
      carryingCapacity: data.carryingCapacity.present
          ? data.carryingCapacity.value
          : this.carryingCapacity,
      durationDays: data.durationDays.present
          ? data.durationDays.value
          : this.durationDays,
      tilePath: data.tilePath.present ? data.tilePath.value : this.tilePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PastureMapData(')
          ..write('id: $id, ')
          ..write('region: $region, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('ndviScore: $ndviScore, ')
          ..write('condition: $condition, ')
          ..write('biomassKgPerHa: $biomassKgPerHa, ')
          ..write('areaHa: $areaHa, ')
          ..write('totalBiomassKg: $totalBiomassKg, ')
          ..write('carryingCapacity: $carryingCapacity, ')
          ..write('durationDays: $durationDays, ')
          ..write('tilePath: $tilePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    region,
    generatedAt,
    ndviScore,
    condition,
    biomassKgPerHa,
    areaHa,
    totalBiomassKg,
    carryingCapacity,
    durationDays,
    tilePath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PastureMapData &&
          other.id == this.id &&
          other.region == this.region &&
          other.generatedAt == this.generatedAt &&
          other.ndviScore == this.ndviScore &&
          other.condition == this.condition &&
          other.biomassKgPerHa == this.biomassKgPerHa &&
          other.areaHa == this.areaHa &&
          other.totalBiomassKg == this.totalBiomassKg &&
          other.carryingCapacity == this.carryingCapacity &&
          other.durationDays == this.durationDays &&
          other.tilePath == this.tilePath);
}

class PastureMapCompanion extends UpdateCompanion<PastureMapData> {
  final Value<String> id;
  final Value<String> region;
  final Value<DateTime> generatedAt;
  final Value<double> ndviScore;
  final Value<String> condition;
  final Value<double> biomassKgPerHa;
  final Value<double> areaHa;
  final Value<double> totalBiomassKg;
  final Value<int?> carryingCapacity;
  final Value<int?> durationDays;
  final Value<String?> tilePath;
  final Value<int> rowid;
  const PastureMapCompanion({
    this.id = const Value.absent(),
    this.region = const Value.absent(),
    this.generatedAt = const Value.absent(),
    this.ndviScore = const Value.absent(),
    this.condition = const Value.absent(),
    this.biomassKgPerHa = const Value.absent(),
    this.areaHa = const Value.absent(),
    this.totalBiomassKg = const Value.absent(),
    this.carryingCapacity = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.tilePath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PastureMapCompanion.insert({
    required String id,
    required String region,
    required DateTime generatedAt,
    required double ndviScore,
    required String condition,
    required double biomassKgPerHa,
    required double areaHa,
    required double totalBiomassKg,
    this.carryingCapacity = const Value.absent(),
    this.durationDays = const Value.absent(),
    this.tilePath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       region = Value(region),
       generatedAt = Value(generatedAt),
       ndviScore = Value(ndviScore),
       condition = Value(condition),
       biomassKgPerHa = Value(biomassKgPerHa),
       areaHa = Value(areaHa),
       totalBiomassKg = Value(totalBiomassKg);
  static Insertable<PastureMapData> custom({
    Expression<String>? id,
    Expression<String>? region,
    Expression<DateTime>? generatedAt,
    Expression<double>? ndviScore,
    Expression<String>? condition,
    Expression<double>? biomassKgPerHa,
    Expression<double>? areaHa,
    Expression<double>? totalBiomassKg,
    Expression<int>? carryingCapacity,
    Expression<int>? durationDays,
    Expression<String>? tilePath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (region != null) 'region': region,
      if (generatedAt != null) 'generated_at': generatedAt,
      if (ndviScore != null) 'ndvi_score': ndviScore,
      if (condition != null) 'condition': condition,
      if (biomassKgPerHa != null) 'biomass_kg_per_ha': biomassKgPerHa,
      if (areaHa != null) 'area_ha': areaHa,
      if (totalBiomassKg != null) 'total_biomass_kg': totalBiomassKg,
      if (carryingCapacity != null) 'carrying_capacity': carryingCapacity,
      if (durationDays != null) 'duration_days': durationDays,
      if (tilePath != null) 'tile_path': tilePath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PastureMapCompanion copyWith({
    Value<String>? id,
    Value<String>? region,
    Value<DateTime>? generatedAt,
    Value<double>? ndviScore,
    Value<String>? condition,
    Value<double>? biomassKgPerHa,
    Value<double>? areaHa,
    Value<double>? totalBiomassKg,
    Value<int?>? carryingCapacity,
    Value<int?>? durationDays,
    Value<String?>? tilePath,
    Value<int>? rowid,
  }) {
    return PastureMapCompanion(
      id: id ?? this.id,
      region: region ?? this.region,
      generatedAt: generatedAt ?? this.generatedAt,
      ndviScore: ndviScore ?? this.ndviScore,
      condition: condition ?? this.condition,
      biomassKgPerHa: biomassKgPerHa ?? this.biomassKgPerHa,
      areaHa: areaHa ?? this.areaHa,
      totalBiomassKg: totalBiomassKg ?? this.totalBiomassKg,
      carryingCapacity: carryingCapacity ?? this.carryingCapacity,
      durationDays: durationDays ?? this.durationDays,
      tilePath: tilePath ?? this.tilePath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (generatedAt.present) {
      map['generated_at'] = Variable<DateTime>(generatedAt.value);
    }
    if (ndviScore.present) {
      map['ndvi_score'] = Variable<double>(ndviScore.value);
    }
    if (condition.present) {
      map['condition'] = Variable<String>(condition.value);
    }
    if (biomassKgPerHa.present) {
      map['biomass_kg_per_ha'] = Variable<double>(biomassKgPerHa.value);
    }
    if (areaHa.present) {
      map['area_ha'] = Variable<double>(areaHa.value);
    }
    if (totalBiomassKg.present) {
      map['total_biomass_kg'] = Variable<double>(totalBiomassKg.value);
    }
    if (carryingCapacity.present) {
      map['carrying_capacity'] = Variable<int>(carryingCapacity.value);
    }
    if (durationDays.present) {
      map['duration_days'] = Variable<int>(durationDays.value);
    }
    if (tilePath.present) {
      map['tile_path'] = Variable<String>(tilePath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PastureMapCompanion(')
          ..write('id: $id, ')
          ..write('region: $region, ')
          ..write('generatedAt: $generatedAt, ')
          ..write('ndviScore: $ndviScore, ')
          ..write('condition: $condition, ')
          ..write('biomassKgPerHa: $biomassKgPerHa, ')
          ..write('areaHa: $areaHa, ')
          ..write('totalBiomassKg: $totalBiomassKg, ')
          ..write('carryingCapacity: $carryingCapacity, ')
          ..write('durationDays: $durationDays, ')
          ..write('tilePath: $tilePath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PastoralistTable pastoralist = $PastoralistTable(this);
  late final $HerdTable herd = $HerdTable(this);
  late final $AnimalTable animal = $AnimalTable(this);
  late final $WearableTable wearable = $WearableTable(this);
  late final $SyncLogTable syncLog = $SyncLogTable(this);
  late final $AccelerometerReadingTable accelerometerReading =
      $AccelerometerReadingTable(this);
  late final $BehaviourClassificationTable behaviourClassification =
      $BehaviourClassificationTable(this);
  late final $DistressAlertTable distressAlert = $DistressAlertTable(this);
  late final $PastureMapTable pastureMap = $PastureMapTable(this);
  late final AnimalDao animalDao = AnimalDao(this as AppDatabase);
  late final BehaviourClassificationDao behaviourClassificationDao =
      BehaviourClassificationDao(this as AppDatabase);
  late final DistressAlertDao distressAlertDao = DistressAlertDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    pastoralist,
    herd,
    animal,
    wearable,
    syncLog,
    accelerometerReading,
    behaviourClassification,
    distressAlert,
    pastureMap,
  ];
}

typedef $$PastoralistTableCreateCompanionBuilder =
    PastoralistCompanion Function({
      required String id,
      required String name,
      required String phoneNumber,
      Value<String?> location,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PastoralistTableUpdateCompanionBuilder =
    PastoralistCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> phoneNumber,
      Value<String?> location,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$PastoralistTableReferences
    extends BaseReferences<_$AppDatabase, $PastoralistTable, PastoralistData> {
  $$PastoralistTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HerdTable, List<HerdData>> _herdRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.herd,
    aliasName: $_aliasNameGenerator(db.pastoralist.id, db.herd.pastoralistId),
  );

  $$HerdTableProcessedTableManager get herdRefs {
    final manager = $$HerdTableTableManager(
      $_db,
      $_db.herd,
    ).filter((f) => f.pastoralistId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_herdRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DistressAlertTable, List<DistressAlertData>>
  _distressAlertRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.distressAlert,
    aliasName: $_aliasNameGenerator(
      db.pastoralist.id,
      db.distressAlert.pastoralistId,
    ),
  );

  $$DistressAlertTableProcessedTableManager get distressAlertRefs {
    final manager = $$DistressAlertTableTableManager(
      $_db,
      $_db.distressAlert,
    ).filter((f) => f.pastoralistId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_distressAlertRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PastoralistTableFilterComposer
    extends Composer<_$AppDatabase, $PastoralistTable> {
  $$PastoralistTableFilterComposer({
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

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> herdRefs(
    Expression<bool> Function($$HerdTableFilterComposer f) f,
  ) {
    final $$HerdTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.herd,
      getReferencedColumn: (t) => t.pastoralistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HerdTableFilterComposer(
            $db: $db,
            $table: $db.herd,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> distressAlertRefs(
    Expression<bool> Function($$DistressAlertTableFilterComposer f) f,
  ) {
    final $$DistressAlertTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.pastoralistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableFilterComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PastoralistTableOrderingComposer
    extends Composer<_$AppDatabase, $PastoralistTable> {
  $$PastoralistTableOrderingComposer({
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

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PastoralistTableAnnotationComposer
    extends Composer<_$AppDatabase, $PastoralistTable> {
  $$PastoralistTableAnnotationComposer({
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

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> herdRefs<T extends Object>(
    Expression<T> Function($$HerdTableAnnotationComposer a) f,
  ) {
    final $$HerdTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.herd,
      getReferencedColumn: (t) => t.pastoralistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HerdTableAnnotationComposer(
            $db: $db,
            $table: $db.herd,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> distressAlertRefs<T extends Object>(
    Expression<T> Function($$DistressAlertTableAnnotationComposer a) f,
  ) {
    final $$DistressAlertTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.pastoralistId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableAnnotationComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PastoralistTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PastoralistTable,
          PastoralistData,
          $$PastoralistTableFilterComposer,
          $$PastoralistTableOrderingComposer,
          $$PastoralistTableAnnotationComposer,
          $$PastoralistTableCreateCompanionBuilder,
          $$PastoralistTableUpdateCompanionBuilder,
          (PastoralistData, $$PastoralistTableReferences),
          PastoralistData,
          PrefetchHooks Function({bool herdRefs, bool distressAlertRefs})
        > {
  $$PastoralistTableTableManager(_$AppDatabase db, $PastoralistTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PastoralistTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PastoralistTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PastoralistTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phoneNumber = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastoralistCompanion(
                id: id,
                name: name,
                phoneNumber: phoneNumber,
                location: location,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String phoneNumber,
                Value<String?> location = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastoralistCompanion.insert(
                id: id,
                name: name,
                phoneNumber: phoneNumber,
                location: location,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PastoralistTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({herdRefs = false, distressAlertRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (herdRefs) db.herd,
                    if (distressAlertRefs) db.distressAlert,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (herdRefs)
                        await $_getPrefetchedData<
                          PastoralistData,
                          $PastoralistTable,
                          HerdData
                        >(
                          currentTable: table,
                          referencedTable: $$PastoralistTableReferences
                              ._herdRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastoralistTableReferences(
                                db,
                                table,
                                p0,
                              ).herdRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoralistId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (distressAlertRefs)
                        await $_getPrefetchedData<
                          PastoralistData,
                          $PastoralistTable,
                          DistressAlertData
                        >(
                          currentTable: table,
                          referencedTable: $$PastoralistTableReferences
                              ._distressAlertRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PastoralistTableReferences(
                                db,
                                table,
                                p0,
                              ).distressAlertRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pastoralistId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PastoralistTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PastoralistTable,
      PastoralistData,
      $$PastoralistTableFilterComposer,
      $$PastoralistTableOrderingComposer,
      $$PastoralistTableAnnotationComposer,
      $$PastoralistTableCreateCompanionBuilder,
      $$PastoralistTableUpdateCompanionBuilder,
      (PastoralistData, $$PastoralistTableReferences),
      PastoralistData,
      PrefetchHooks Function({bool herdRefs, bool distressAlertRefs})
    >;
typedef $$HerdTableCreateCompanionBuilder =
    HerdCompanion Function({
      required String id,
      required String name,
      required int size,
      required String pastoralistId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$HerdTableUpdateCompanionBuilder =
    HerdCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> size,
      Value<String> pastoralistId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$HerdTableReferences
    extends BaseReferences<_$AppDatabase, $HerdTable, HerdData> {
  $$HerdTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PastoralistTable _pastoralistIdTable(_$AppDatabase db) =>
      db.pastoralist.createAlias(
        $_aliasNameGenerator(db.herd.pastoralistId, db.pastoralist.id),
      );

  $$PastoralistTableProcessedTableManager get pastoralistId {
    final $_column = $_itemColumn<String>('pastoralist_id')!;

    final manager = $$PastoralistTableTableManager(
      $_db,
      $_db.pastoralist,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoralistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$AnimalTable, List<AnimalData>> _animalRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.animal,
    aliasName: $_aliasNameGenerator(db.herd.id, db.animal.herdId),
  );

  $$AnimalTableProcessedTableManager get animalRefs {
    final manager = $$AnimalTableTableManager(
      $_db,
      $_db.animal,
    ).filter((f) => f.herdId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_animalRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HerdTableFilterComposer extends Composer<_$AppDatabase, $HerdTable> {
  $$HerdTableFilterComposer({
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

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PastoralistTableFilterComposer get pastoralistId {
    final $$PastoralistTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableFilterComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> animalRefs(
    Expression<bool> Function($$AnimalTableFilterComposer f) f,
  ) {
    final $$AnimalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.herdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableFilterComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HerdTableOrderingComposer extends Composer<_$AppDatabase, $HerdTable> {
  $$HerdTableOrderingComposer({
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

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PastoralistTableOrderingComposer get pastoralistId {
    final $$PastoralistTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableOrderingComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HerdTableAnnotationComposer
    extends Composer<_$AppDatabase, $HerdTable> {
  $$HerdTableAnnotationComposer({
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

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PastoralistTableAnnotationComposer get pastoralistId {
    final $$PastoralistTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> animalRefs<T extends Object>(
    Expression<T> Function($$AnimalTableAnnotationComposer a) f,
  ) {
    final $$AnimalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.herdId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableAnnotationComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HerdTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HerdTable,
          HerdData,
          $$HerdTableFilterComposer,
          $$HerdTableOrderingComposer,
          $$HerdTableAnnotationComposer,
          $$HerdTableCreateCompanionBuilder,
          $$HerdTableUpdateCompanionBuilder,
          (HerdData, $$HerdTableReferences),
          HerdData,
          PrefetchHooks Function({bool pastoralistId, bool animalRefs})
        > {
  $$HerdTableTableManager(_$AppDatabase db, $HerdTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HerdTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HerdTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HerdTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<String> pastoralistId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HerdCompanion(
                id: id,
                name: name,
                size: size,
                pastoralistId: pastoralistId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required int size,
                required String pastoralistId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HerdCompanion.insert(
                id: id,
                name: name,
                size: size,
                pastoralistId: pastoralistId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$HerdTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({pastoralistId = false, animalRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (animalRefs) db.animal],
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
                    if (pastoralistId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pastoralistId,
                                referencedTable: $$HerdTableReferences
                                    ._pastoralistIdTable(db),
                                referencedColumn: $$HerdTableReferences
                                    ._pastoralistIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (animalRefs)
                    await $_getPrefetchedData<HerdData, $HerdTable, AnimalData>(
                      currentTable: table,
                      referencedTable: $$HerdTableReferences._animalRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$HerdTableReferences(db, table, p0).animalRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.herdId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$HerdTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HerdTable,
      HerdData,
      $$HerdTableFilterComposer,
      $$HerdTableOrderingComposer,
      $$HerdTableAnnotationComposer,
      $$HerdTableCreateCompanionBuilder,
      $$HerdTableUpdateCompanionBuilder,
      (HerdData, $$HerdTableReferences),
      HerdData,
      PrefetchHooks Function({bool pastoralistId, bool animalRefs})
    >;
typedef $$AnimalTableCreateCompanionBuilder =
    AnimalCompanion Function({
      required String id,
      Value<String?> name,
      required String species,
      required String herdId,
      Value<String?> wearableId,
      Value<double> tluValue,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$AnimalTableUpdateCompanionBuilder =
    AnimalCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String> species,
      Value<String> herdId,
      Value<String?> wearableId,
      Value<double> tluValue,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$AnimalTableReferences
    extends BaseReferences<_$AppDatabase, $AnimalTable, AnimalData> {
  $$AnimalTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HerdTable _herdIdTable(_$AppDatabase db) =>
      db.herd.createAlias($_aliasNameGenerator(db.animal.herdId, db.herd.id));

  $$HerdTableProcessedTableManager get herdId {
    final $_column = $_itemColumn<String>('herd_id')!;

    final manager = $$HerdTableTableManager(
      $_db,
      $_db.herd,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_herdIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$WearableTable, List<WearableData>>
  _wearableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.wearable,
    aliasName: $_aliasNameGenerator(db.animal.id, db.wearable.animalId),
  );

  $$WearableTableProcessedTableManager get wearableRefs {
    final manager = $$WearableTableTableManager(
      $_db,
      $_db.wearable,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_wearableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $BehaviourClassificationTable,
    List<BehaviourClassificationData>
  >
  _behaviourClassificationRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.behaviourClassification,
        aliasName: $_aliasNameGenerator(
          db.animal.id,
          db.behaviourClassification.animalId,
        ),
      );

  $$BehaviourClassificationTableProcessedTableManager
  get behaviourClassificationRefs {
    final manager = $$BehaviourClassificationTableTableManager(
      $_db,
      $_db.behaviourClassification,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _behaviourClassificationRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DistressAlertTable, List<DistressAlertData>>
  _distressAlertRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.distressAlert,
    aliasName: $_aliasNameGenerator(db.animal.id, db.distressAlert.animalId),
  );

  $$DistressAlertTableProcessedTableManager get distressAlertRefs {
    final manager = $$DistressAlertTableTableManager(
      $_db,
      $_db.distressAlert,
    ).filter((f) => f.animalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_distressAlertRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AnimalTableFilterComposer
    extends Composer<_$AppDatabase, $AnimalTable> {
  $$AnimalTableFilterComposer({
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

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wearableId => $composableBuilder(
    column: $table.wearableId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tluValue => $composableBuilder(
    column: $table.tluValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HerdTableFilterComposer get herdId {
    final $$HerdTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.herdId,
      referencedTable: $db.herd,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HerdTableFilterComposer(
            $db: $db,
            $table: $db.herd,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> wearableRefs(
    Expression<bool> Function($$WearableTableFilterComposer f) f,
  ) {
    final $$WearableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wearable,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WearableTableFilterComposer(
            $db: $db,
            $table: $db.wearable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> behaviourClassificationRefs(
    Expression<bool> Function($$BehaviourClassificationTableFilterComposer f) f,
  ) {
    final $$BehaviourClassificationTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.behaviourClassification,
          getReferencedColumn: (t) => t.animalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BehaviourClassificationTableFilterComposer(
                $db: $db,
                $table: $db.behaviourClassification,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> distressAlertRefs(
    Expression<bool> Function($$DistressAlertTableFilterComposer f) f,
  ) {
    final $$DistressAlertTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableFilterComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnimalTableOrderingComposer
    extends Composer<_$AppDatabase, $AnimalTable> {
  $$AnimalTableOrderingComposer({
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

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wearableId => $composableBuilder(
    column: $table.wearableId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tluValue => $composableBuilder(
    column: $table.tluValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HerdTableOrderingComposer get herdId {
    final $$HerdTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.herdId,
      referencedTable: $db.herd,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HerdTableOrderingComposer(
            $db: $db,
            $table: $db.herd,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AnimalTableAnnotationComposer
    extends Composer<_$AppDatabase, $AnimalTable> {
  $$AnimalTableAnnotationComposer({
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

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get wearableId => $composableBuilder(
    column: $table.wearableId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get tluValue =>
      $composableBuilder(column: $table.tluValue, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HerdTableAnnotationComposer get herdId {
    final $$HerdTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.herdId,
      referencedTable: $db.herd,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HerdTableAnnotationComposer(
            $db: $db,
            $table: $db.herd,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> wearableRefs<T extends Object>(
    Expression<T> Function($$WearableTableAnnotationComposer a) f,
  ) {
    final $$WearableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.wearable,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WearableTableAnnotationComposer(
            $db: $db,
            $table: $db.wearable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> behaviourClassificationRefs<T extends Object>(
    Expression<T> Function($$BehaviourClassificationTableAnnotationComposer a)
    f,
  ) {
    final $$BehaviourClassificationTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.behaviourClassification,
          getReferencedColumn: (t) => t.animalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BehaviourClassificationTableAnnotationComposer(
                $db: $db,
                $table: $db.behaviourClassification,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> distressAlertRefs<T extends Object>(
    Expression<T> Function($$DistressAlertTableAnnotationComposer a) f,
  ) {
    final $$DistressAlertTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.animalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableAnnotationComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AnimalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AnimalTable,
          AnimalData,
          $$AnimalTableFilterComposer,
          $$AnimalTableOrderingComposer,
          $$AnimalTableAnnotationComposer,
          $$AnimalTableCreateCompanionBuilder,
          $$AnimalTableUpdateCompanionBuilder,
          (AnimalData, $$AnimalTableReferences),
          AnimalData,
          PrefetchHooks Function({
            bool herdId,
            bool wearableRefs,
            bool behaviourClassificationRefs,
            bool distressAlertRefs,
          })
        > {
  $$AnimalTableTableManager(_$AppDatabase db, $AnimalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AnimalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AnimalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AnimalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<String> herdId = const Value.absent(),
                Value<String?> wearableId = const Value.absent(),
                Value<double> tluValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalCompanion(
                id: id,
                name: name,
                species: species,
                herdId: herdId,
                wearableId: wearableId,
                tluValue: tluValue,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                required String species,
                required String herdId,
                Value<String?> wearableId = const Value.absent(),
                Value<double> tluValue = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AnimalCompanion.insert(
                id: id,
                name: name,
                species: species,
                herdId: herdId,
                wearableId: wearableId,
                tluValue: tluValue,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$AnimalTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                herdId = false,
                wearableRefs = false,
                behaviourClassificationRefs = false,
                distressAlertRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (wearableRefs) db.wearable,
                    if (behaviourClassificationRefs) db.behaviourClassification,
                    if (distressAlertRefs) db.distressAlert,
                  ],
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
                        if (herdId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.herdId,
                                    referencedTable: $$AnimalTableReferences
                                        ._herdIdTable(db),
                                    referencedColumn: $$AnimalTableReferences
                                        ._herdIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (wearableRefs)
                        await $_getPrefetchedData<
                          AnimalData,
                          $AnimalTable,
                          WearableData
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalTableReferences
                              ._wearableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalTableReferences(
                                db,
                                table,
                                p0,
                              ).wearableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (behaviourClassificationRefs)
                        await $_getPrefetchedData<
                          AnimalData,
                          $AnimalTable,
                          BehaviourClassificationData
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalTableReferences
                              ._behaviourClassificationRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalTableReferences(
                                db,
                                table,
                                p0,
                              ).behaviourClassificationRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (distressAlertRefs)
                        await $_getPrefetchedData<
                          AnimalData,
                          $AnimalTable,
                          DistressAlertData
                        >(
                          currentTable: table,
                          referencedTable: $$AnimalTableReferences
                              ._distressAlertRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AnimalTableReferences(
                                db,
                                table,
                                p0,
                              ).distressAlertRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.animalId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AnimalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AnimalTable,
      AnimalData,
      $$AnimalTableFilterComposer,
      $$AnimalTableOrderingComposer,
      $$AnimalTableAnnotationComposer,
      $$AnimalTableCreateCompanionBuilder,
      $$AnimalTableUpdateCompanionBuilder,
      (AnimalData, $$AnimalTableReferences),
      AnimalData,
      PrefetchHooks Function({
        bool herdId,
        bool wearableRefs,
        bool behaviourClassificationRefs,
        bool distressAlertRefs,
      })
    >;
typedef $$WearableTableCreateCompanionBuilder =
    WearableCompanion Function({
      required String id,
      Value<String?> animalId,
      Value<int> sampleRate,
      Value<double?> batteryLevel,
      Value<DateTime?> lastSeen,
      Value<int> rowid,
    });
typedef $$WearableTableUpdateCompanionBuilder =
    WearableCompanion Function({
      Value<String> id,
      Value<String?> animalId,
      Value<int> sampleRate,
      Value<double?> batteryLevel,
      Value<DateTime?> lastSeen,
      Value<int> rowid,
    });

final class $$WearableTableReferences
    extends BaseReferences<_$AppDatabase, $WearableTable, WearableData> {
  $$WearableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AnimalTable _animalIdTable(_$AppDatabase db) => db.animal.createAlias(
    $_aliasNameGenerator(db.wearable.animalId, db.animal.id),
  );

  $$AnimalTableProcessedTableManager? get animalId {
    final $_column = $_itemColumn<String>('animal_id');
    if ($_column == null) return null;
    final manager = $$AnimalTableTableManager(
      $_db,
      $_db.animal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $AccelerometerReadingTable,
    List<AccelerometerReadingData>
  >
  _accelerometerReadingRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.accelerometerReading,
        aliasName: $_aliasNameGenerator(
          db.wearable.id,
          db.accelerometerReading.wearableId,
        ),
      );

  $$AccelerometerReadingTableProcessedTableManager
  get accelerometerReadingRefs {
    final manager = $$AccelerometerReadingTableTableManager(
      $_db,
      $_db.accelerometerReading,
    ).filter((f) => f.wearableId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _accelerometerReadingRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$WearableTableFilterComposer
    extends Composer<_$AppDatabase, $WearableTable> {
  $$WearableTableFilterComposer({
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

  ColumnFilters<int> get sampleRate => $composableBuilder(
    column: $table.sampleRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalTableFilterComposer get animalId {
    final $$AnimalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableFilterComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> accelerometerReadingRefs(
    Expression<bool> Function($$AccelerometerReadingTableFilterComposer f) f,
  ) {
    final $$AccelerometerReadingTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accelerometerReading,
      getReferencedColumn: (t) => t.wearableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccelerometerReadingTableFilterComposer(
            $db: $db,
            $table: $db.accelerometerReading,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$WearableTableOrderingComposer
    extends Composer<_$AppDatabase, $WearableTable> {
  $$WearableTableOrderingComposer({
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

  ColumnOrderings<int> get sampleRate => $composableBuilder(
    column: $table.sampleRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSeen => $composableBuilder(
    column: $table.lastSeen,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalTableOrderingComposer get animalId {
    final $$AnimalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableOrderingComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WearableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WearableTable> {
  $$WearableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sampleRate => $composableBuilder(
    column: $table.sampleRate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get batteryLevel => $composableBuilder(
    column: $table.batteryLevel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSeen =>
      $composableBuilder(column: $table.lastSeen, builder: (column) => column);

  $$AnimalTableAnnotationComposer get animalId {
    final $$AnimalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableAnnotationComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> accelerometerReadingRefs<T extends Object>(
    Expression<T> Function($$AccelerometerReadingTableAnnotationComposer a) f,
  ) {
    final $$AccelerometerReadingTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.accelerometerReading,
          getReferencedColumn: (t) => t.wearableId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AccelerometerReadingTableAnnotationComposer(
                $db: $db,
                $table: $db.accelerometerReading,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$WearableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WearableTable,
          WearableData,
          $$WearableTableFilterComposer,
          $$WearableTableOrderingComposer,
          $$WearableTableAnnotationComposer,
          $$WearableTableCreateCompanionBuilder,
          $$WearableTableUpdateCompanionBuilder,
          (WearableData, $$WearableTableReferences),
          WearableData,
          PrefetchHooks Function({bool animalId, bool accelerometerReadingRefs})
        > {
  $$WearableTableTableManager(_$AppDatabase db, $WearableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WearableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WearableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WearableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> animalId = const Value.absent(),
                Value<int> sampleRate = const Value.absent(),
                Value<double?> batteryLevel = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WearableCompanion(
                id: id,
                animalId: animalId,
                sampleRate: sampleRate,
                batteryLevel: batteryLevel,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> animalId = const Value.absent(),
                Value<int> sampleRate = const Value.absent(),
                Value<double?> batteryLevel = const Value.absent(),
                Value<DateTime?> lastSeen = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WearableCompanion.insert(
                id: id,
                animalId: animalId,
                sampleRate: sampleRate,
                batteryLevel: batteryLevel,
                lastSeen: lastSeen,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WearableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({animalId = false, accelerometerReadingRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (accelerometerReadingRefs) db.accelerometerReading,
                  ],
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
                        if (animalId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalId,
                                    referencedTable: $$WearableTableReferences
                                        ._animalIdTable(db),
                                    referencedColumn: $$WearableTableReferences
                                        ._animalIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (accelerometerReadingRefs)
                        await $_getPrefetchedData<
                          WearableData,
                          $WearableTable,
                          AccelerometerReadingData
                        >(
                          currentTable: table,
                          referencedTable: $$WearableTableReferences
                              ._accelerometerReadingRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$WearableTableReferences(
                                db,
                                table,
                                p0,
                              ).accelerometerReadingRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.wearableId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$WearableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WearableTable,
      WearableData,
      $$WearableTableFilterComposer,
      $$WearableTableOrderingComposer,
      $$WearableTableAnnotationComposer,
      $$WearableTableCreateCompanionBuilder,
      $$WearableTableUpdateCompanionBuilder,
      (WearableData, $$WearableTableReferences),
      WearableData,
      PrefetchHooks Function({bool animalId, bool accelerometerReadingRefs})
    >;
typedef $$SyncLogTableCreateCompanionBuilder =
    SyncLogCompanion Function({
      required String id,
      required String recordId,
      required String targetTable,
      Value<DateTime?> syncTime,
      required String status,
      Value<int> recordsUploaded,
      Value<int> recordsDownloaded,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SyncLogTableUpdateCompanionBuilder =
    SyncLogCompanion Function({
      Value<String> id,
      Value<String> recordId,
      Value<String> targetTable,
      Value<DateTime?> syncTime,
      Value<String> status,
      Value<int> recordsUploaded,
      Value<int> recordsDownloaded,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncLogTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableFilterComposer({
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

  ColumnFilters<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsUploaded => $composableBuilder(
    column: $table.recordsUploaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordsDownloaded => $composableBuilder(
    column: $table.recordsDownloaded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncLogTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableOrderingComposer({
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

  ColumnOrderings<String> get recordId => $composableBuilder(
    column: $table.recordId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncTime => $composableBuilder(
    column: $table.syncTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsUploaded => $composableBuilder(
    column: $table.recordsUploaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordsDownloaded => $composableBuilder(
    column: $table.recordsDownloaded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncLogTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogTable> {
  $$SyncLogTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get recordId =>
      $composableBuilder(column: $table.recordId, builder: (column) => column);

  GeneratedColumn<String> get targetTable => $composableBuilder(
    column: $table.targetTable,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get syncTime =>
      $composableBuilder(column: $table.syncTime, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get recordsUploaded => $composableBuilder(
    column: $table.recordsUploaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordsDownloaded => $composableBuilder(
    column: $table.recordsDownloaded,
    builder: (column) => column,
  );

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncLogTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncLogTable,
          SyncLogData,
          $$SyncLogTableFilterComposer,
          $$SyncLogTableOrderingComposer,
          $$SyncLogTableAnnotationComposer,
          $$SyncLogTableCreateCompanionBuilder,
          $$SyncLogTableUpdateCompanionBuilder,
          (
            SyncLogData,
            BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogData>,
          ),
          SyncLogData,
          PrefetchHooks Function()
        > {
  $$SyncLogTableTableManager(_$AppDatabase db, $SyncLogTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recordId = const Value.absent(),
                Value<String> targetTable = const Value.absent(),
                Value<DateTime?> syncTime = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> recordsUploaded = const Value.absent(),
                Value<int> recordsDownloaded = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncLogCompanion(
                id: id,
                recordId: recordId,
                targetTable: targetTable,
                syncTime: syncTime,
                status: status,
                recordsUploaded: recordsUploaded,
                recordsDownloaded: recordsDownloaded,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recordId,
                required String targetTable,
                Value<DateTime?> syncTime = const Value.absent(),
                required String status,
                Value<int> recordsUploaded = const Value.absent(),
                Value<int> recordsDownloaded = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncLogCompanion.insert(
                id: id,
                recordId: recordId,
                targetTable: targetTable,
                syncTime: syncTime,
                status: status,
                recordsUploaded: recordsUploaded,
                recordsDownloaded: recordsDownloaded,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncLogTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncLogTable,
      SyncLogData,
      $$SyncLogTableFilterComposer,
      $$SyncLogTableOrderingComposer,
      $$SyncLogTableAnnotationComposer,
      $$SyncLogTableCreateCompanionBuilder,
      $$SyncLogTableUpdateCompanionBuilder,
      (SyncLogData, BaseReferences<_$AppDatabase, $SyncLogTable, SyncLogData>),
      SyncLogData,
      PrefetchHooks Function()
    >;
typedef $$AccelerometerReadingTableCreateCompanionBuilder =
    AccelerometerReadingCompanion Function({
      required String id,
      required String wearableId,
      required DateTime timestamp,
      required double xAxis,
      required double yAxis,
      required double zAxis,
      Value<int> processed,
      Value<int> rowid,
    });
typedef $$AccelerometerReadingTableUpdateCompanionBuilder =
    AccelerometerReadingCompanion Function({
      Value<String> id,
      Value<String> wearableId,
      Value<DateTime> timestamp,
      Value<double> xAxis,
      Value<double> yAxis,
      Value<double> zAxis,
      Value<int> processed,
      Value<int> rowid,
    });

final class $$AccelerometerReadingTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AccelerometerReadingTable,
          AccelerometerReadingData
        > {
  $$AccelerometerReadingTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $WearableTable _wearableIdTable(_$AppDatabase db) =>
      db.wearable.createAlias(
        $_aliasNameGenerator(
          db.accelerometerReading.wearableId,
          db.wearable.id,
        ),
      );

  $$WearableTableProcessedTableManager get wearableId {
    final $_column = $_itemColumn<String>('wearable_id')!;

    final manager = $$WearableTableTableManager(
      $_db,
      $_db.wearable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_wearableIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccelerometerReadingTableFilterComposer
    extends Composer<_$AppDatabase, $AccelerometerReadingTable> {
  $$AccelerometerReadingTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get xAxis => $composableBuilder(
    column: $table.xAxis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yAxis => $composableBuilder(
    column: $table.yAxis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zAxis => $composableBuilder(
    column: $table.zAxis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get processed => $composableBuilder(
    column: $table.processed,
    builder: (column) => ColumnFilters(column),
  );

  $$WearableTableFilterComposer get wearableId {
    final $$WearableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wearableId,
      referencedTable: $db.wearable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WearableTableFilterComposer(
            $db: $db,
            $table: $db.wearable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccelerometerReadingTableOrderingComposer
    extends Composer<_$AppDatabase, $AccelerometerReadingTable> {
  $$AccelerometerReadingTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get xAxis => $composableBuilder(
    column: $table.xAxis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yAxis => $composableBuilder(
    column: $table.yAxis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zAxis => $composableBuilder(
    column: $table.zAxis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get processed => $composableBuilder(
    column: $table.processed,
    builder: (column) => ColumnOrderings(column),
  );

  $$WearableTableOrderingComposer get wearableId {
    final $$WearableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wearableId,
      referencedTable: $db.wearable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WearableTableOrderingComposer(
            $db: $db,
            $table: $db.wearable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccelerometerReadingTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccelerometerReadingTable> {
  $$AccelerometerReadingTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<double> get xAxis =>
      $composableBuilder(column: $table.xAxis, builder: (column) => column);

  GeneratedColumn<double> get yAxis =>
      $composableBuilder(column: $table.yAxis, builder: (column) => column);

  GeneratedColumn<double> get zAxis =>
      $composableBuilder(column: $table.zAxis, builder: (column) => column);

  GeneratedColumn<int> get processed =>
      $composableBuilder(column: $table.processed, builder: (column) => column);

  $$WearableTableAnnotationComposer get wearableId {
    final $$WearableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.wearableId,
      referencedTable: $db.wearable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WearableTableAnnotationComposer(
            $db: $db,
            $table: $db.wearable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccelerometerReadingTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccelerometerReadingTable,
          AccelerometerReadingData,
          $$AccelerometerReadingTableFilterComposer,
          $$AccelerometerReadingTableOrderingComposer,
          $$AccelerometerReadingTableAnnotationComposer,
          $$AccelerometerReadingTableCreateCompanionBuilder,
          $$AccelerometerReadingTableUpdateCompanionBuilder,
          (AccelerometerReadingData, $$AccelerometerReadingTableReferences),
          AccelerometerReadingData,
          PrefetchHooks Function({bool wearableId})
        > {
  $$AccelerometerReadingTableTableManager(
    _$AppDatabase db,
    $AccelerometerReadingTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccelerometerReadingTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccelerometerReadingTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AccelerometerReadingTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> wearableId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<double> xAxis = const Value.absent(),
                Value<double> yAxis = const Value.absent(),
                Value<double> zAxis = const Value.absent(),
                Value<int> processed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccelerometerReadingCompanion(
                id: id,
                wearableId: wearableId,
                timestamp: timestamp,
                xAxis: xAxis,
                yAxis: yAxis,
                zAxis: zAxis,
                processed: processed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String wearableId,
                required DateTime timestamp,
                required double xAxis,
                required double yAxis,
                required double zAxis,
                Value<int> processed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AccelerometerReadingCompanion.insert(
                id: id,
                wearableId: wearableId,
                timestamp: timestamp,
                xAxis: xAxis,
                yAxis: yAxis,
                zAxis: zAxis,
                processed: processed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccelerometerReadingTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({wearableId = false}) {
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
                    if (wearableId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.wearableId,
                                referencedTable:
                                    $$AccelerometerReadingTableReferences
                                        ._wearableIdTable(db),
                                referencedColumn:
                                    $$AccelerometerReadingTableReferences
                                        ._wearableIdTable(db)
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

typedef $$AccelerometerReadingTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccelerometerReadingTable,
      AccelerometerReadingData,
      $$AccelerometerReadingTableFilterComposer,
      $$AccelerometerReadingTableOrderingComposer,
      $$AccelerometerReadingTableAnnotationComposer,
      $$AccelerometerReadingTableCreateCompanionBuilder,
      $$AccelerometerReadingTableUpdateCompanionBuilder,
      (AccelerometerReadingData, $$AccelerometerReadingTableReferences),
      AccelerometerReadingData,
      PrefetchHooks Function({bool wearableId})
    >;
typedef $$BehaviourClassificationTableCreateCompanionBuilder =
    BehaviourClassificationCompanion Function({
      required String id,
      required String animalId,
      required DateTime timestamp,
      required int behaviourClass,
      required double confidence,
      required DateTime windowStart,
      required DateTime windowEnd,
      required double probGrazing,
      required double probRuminating,
      required double probStanding,
      required double probLying,
      required double probWalking,
      Value<bool> alertProcessed,
      Value<int> synced,
      Value<int> rowid,
    });
typedef $$BehaviourClassificationTableUpdateCompanionBuilder =
    BehaviourClassificationCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<DateTime> timestamp,
      Value<int> behaviourClass,
      Value<double> confidence,
      Value<DateTime> windowStart,
      Value<DateTime> windowEnd,
      Value<double> probGrazing,
      Value<double> probRuminating,
      Value<double> probStanding,
      Value<double> probLying,
      Value<double> probWalking,
      Value<bool> alertProcessed,
      Value<int> synced,
      Value<int> rowid,
    });

final class $$BehaviourClassificationTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BehaviourClassificationTable,
          BehaviourClassificationData
        > {
  $$BehaviourClassificationTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalTable _animalIdTable(_$AppDatabase db) => db.animal.createAlias(
    $_aliasNameGenerator(db.behaviourClassification.animalId, db.animal.id),
  );

  $$AnimalTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalTableTableManager(
      $_db,
      $_db.animal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$DistressAlertTable, List<DistressAlertData>>
  _distressAlertRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.distressAlert,
    aliasName: $_aliasNameGenerator(
      db.behaviourClassification.id,
      db.distressAlert.classificationId,
    ),
  );

  $$DistressAlertTableProcessedTableManager get distressAlertRefs {
    final manager = $$DistressAlertTableTableManager($_db, $_db.distressAlert)
        .filter(
          (f) => f.classificationId.id.sqlEquals($_itemColumn<String>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(_distressAlertRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BehaviourClassificationTableFilterComposer
    extends Composer<_$AppDatabase, $BehaviourClassificationTable> {
  $$BehaviourClassificationTableFilterComposer({
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

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get behaviourClass => $composableBuilder(
    column: $table.behaviourClass,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probGrazing => $composableBuilder(
    column: $table.probGrazing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probRuminating => $composableBuilder(
    column: $table.probRuminating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probStanding => $composableBuilder(
    column: $table.probStanding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probLying => $composableBuilder(
    column: $table.probLying,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get probWalking => $composableBuilder(
    column: $table.probWalking,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get alertProcessed => $composableBuilder(
    column: $table.alertProcessed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalTableFilterComposer get animalId {
    final $$AnimalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableFilterComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> distressAlertRefs(
    Expression<bool> Function($$DistressAlertTableFilterComposer f) f,
  ) {
    final $$DistressAlertTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.classificationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableFilterComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BehaviourClassificationTableOrderingComposer
    extends Composer<_$AppDatabase, $BehaviourClassificationTable> {
  $$BehaviourClassificationTableOrderingComposer({
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

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get behaviourClass => $composableBuilder(
    column: $table.behaviourClass,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get windowEnd => $composableBuilder(
    column: $table.windowEnd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probGrazing => $composableBuilder(
    column: $table.probGrazing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probRuminating => $composableBuilder(
    column: $table.probRuminating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probStanding => $composableBuilder(
    column: $table.probStanding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probLying => $composableBuilder(
    column: $table.probLying,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get probWalking => $composableBuilder(
    column: $table.probWalking,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get alertProcessed => $composableBuilder(
    column: $table.alertProcessed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalTableOrderingComposer get animalId {
    final $$AnimalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableOrderingComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BehaviourClassificationTableAnnotationComposer
    extends Composer<_$AppDatabase, $BehaviourClassificationTable> {
  $$BehaviourClassificationTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get behaviourClass => $composableBuilder(
    column: $table.behaviourClass,
    builder: (column) => column,
  );

  GeneratedColumn<double> get confidence => $composableBuilder(
    column: $table.confidence,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get windowStart => $composableBuilder(
    column: $table.windowStart,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get windowEnd =>
      $composableBuilder(column: $table.windowEnd, builder: (column) => column);

  GeneratedColumn<double> get probGrazing => $composableBuilder(
    column: $table.probGrazing,
    builder: (column) => column,
  );

  GeneratedColumn<double> get probRuminating => $composableBuilder(
    column: $table.probRuminating,
    builder: (column) => column,
  );

  GeneratedColumn<double> get probStanding => $composableBuilder(
    column: $table.probStanding,
    builder: (column) => column,
  );

  GeneratedColumn<double> get probLying =>
      $composableBuilder(column: $table.probLying, builder: (column) => column);

  GeneratedColumn<double> get probWalking => $composableBuilder(
    column: $table.probWalking,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get alertProcessed => $composableBuilder(
    column: $table.alertProcessed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  $$AnimalTableAnnotationComposer get animalId {
    final $$AnimalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableAnnotationComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> distressAlertRefs<T extends Object>(
    Expression<T> Function($$DistressAlertTableAnnotationComposer a) f,
  ) {
    final $$DistressAlertTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.distressAlert,
      getReferencedColumn: (t) => t.classificationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DistressAlertTableAnnotationComposer(
            $db: $db,
            $table: $db.distressAlert,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BehaviourClassificationTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BehaviourClassificationTable,
          BehaviourClassificationData,
          $$BehaviourClassificationTableFilterComposer,
          $$BehaviourClassificationTableOrderingComposer,
          $$BehaviourClassificationTableAnnotationComposer,
          $$BehaviourClassificationTableCreateCompanionBuilder,
          $$BehaviourClassificationTableUpdateCompanionBuilder,
          (
            BehaviourClassificationData,
            $$BehaviourClassificationTableReferences,
          ),
          BehaviourClassificationData,
          PrefetchHooks Function({bool animalId, bool distressAlertRefs})
        > {
  $$BehaviourClassificationTableTableManager(
    _$AppDatabase db,
    $BehaviourClassificationTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BehaviourClassificationTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BehaviourClassificationTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BehaviourClassificationTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> behaviourClass = const Value.absent(),
                Value<double> confidence = const Value.absent(),
                Value<DateTime> windowStart = const Value.absent(),
                Value<DateTime> windowEnd = const Value.absent(),
                Value<double> probGrazing = const Value.absent(),
                Value<double> probRuminating = const Value.absent(),
                Value<double> probStanding = const Value.absent(),
                Value<double> probLying = const Value.absent(),
                Value<double> probWalking = const Value.absent(),
                Value<bool> alertProcessed = const Value.absent(),
                Value<int> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BehaviourClassificationCompanion(
                id: id,
                animalId: animalId,
                timestamp: timestamp,
                behaviourClass: behaviourClass,
                confidence: confidence,
                windowStart: windowStart,
                windowEnd: windowEnd,
                probGrazing: probGrazing,
                probRuminating: probRuminating,
                probStanding: probStanding,
                probLying: probLying,
                probWalking: probWalking,
                alertProcessed: alertProcessed,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required DateTime timestamp,
                required int behaviourClass,
                required double confidence,
                required DateTime windowStart,
                required DateTime windowEnd,
                required double probGrazing,
                required double probRuminating,
                required double probStanding,
                required double probLying,
                required double probWalking,
                Value<bool> alertProcessed = const Value.absent(),
                Value<int> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BehaviourClassificationCompanion.insert(
                id: id,
                animalId: animalId,
                timestamp: timestamp,
                behaviourClass: behaviourClass,
                confidence: confidence,
                windowStart: windowStart,
                windowEnd: windowEnd,
                probGrazing: probGrazing,
                probRuminating: probRuminating,
                probStanding: probStanding,
                probLying: probLying,
                probWalking: probWalking,
                alertProcessed: alertProcessed,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BehaviourClassificationTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({animalId = false, distressAlertRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (distressAlertRefs) db.distressAlert,
                  ],
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
                        if (animalId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalId,
                                    referencedTable:
                                        $$BehaviourClassificationTableReferences
                                            ._animalIdTable(db),
                                    referencedColumn:
                                        $$BehaviourClassificationTableReferences
                                            ._animalIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (distressAlertRefs)
                        await $_getPrefetchedData<
                          BehaviourClassificationData,
                          $BehaviourClassificationTable,
                          DistressAlertData
                        >(
                          currentTable: table,
                          referencedTable:
                              $$BehaviourClassificationTableReferences
                                  ._distressAlertRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BehaviourClassificationTableReferences(
                                db,
                                table,
                                p0,
                              ).distressAlertRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.classificationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BehaviourClassificationTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BehaviourClassificationTable,
      BehaviourClassificationData,
      $$BehaviourClassificationTableFilterComposer,
      $$BehaviourClassificationTableOrderingComposer,
      $$BehaviourClassificationTableAnnotationComposer,
      $$BehaviourClassificationTableCreateCompanionBuilder,
      $$BehaviourClassificationTableUpdateCompanionBuilder,
      (BehaviourClassificationData, $$BehaviourClassificationTableReferences),
      BehaviourClassificationData,
      PrefetchHooks Function({bool animalId, bool distressAlertRefs})
    >;
typedef $$DistressAlertTableCreateCompanionBuilder =
    DistressAlertCompanion Function({
      required String id,
      required String animalId,
      required String classificationId,
      required String pastoralistId,
      required String alertType,
      required String message,
      required String severity,
      required DateTime timestamp,
      Value<int> isAcknowledged,
      Value<int> synced,
      Value<int> rowid,
    });
typedef $$DistressAlertTableUpdateCompanionBuilder =
    DistressAlertCompanion Function({
      Value<String> id,
      Value<String> animalId,
      Value<String> classificationId,
      Value<String> pastoralistId,
      Value<String> alertType,
      Value<String> message,
      Value<String> severity,
      Value<DateTime> timestamp,
      Value<int> isAcknowledged,
      Value<int> synced,
      Value<int> rowid,
    });

final class $$DistressAlertTableReferences
    extends
        BaseReferences<_$AppDatabase, $DistressAlertTable, DistressAlertData> {
  $$DistressAlertTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AnimalTable _animalIdTable(_$AppDatabase db) => db.animal.createAlias(
    $_aliasNameGenerator(db.distressAlert.animalId, db.animal.id),
  );

  $$AnimalTableProcessedTableManager get animalId {
    final $_column = $_itemColumn<String>('animal_id')!;

    final manager = $$AnimalTableTableManager(
      $_db,
      $_db.animal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_animalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BehaviourClassificationTable _classificationIdTable(
    _$AppDatabase db,
  ) => db.behaviourClassification.createAlias(
    $_aliasNameGenerator(
      db.distressAlert.classificationId,
      db.behaviourClassification.id,
    ),
  );

  $$BehaviourClassificationTableProcessedTableManager get classificationId {
    final $_column = $_itemColumn<String>('classification_id')!;

    final manager = $$BehaviourClassificationTableTableManager(
      $_db,
      $_db.behaviourClassification,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classificationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PastoralistTable _pastoralistIdTable(_$AppDatabase db) =>
      db.pastoralist.createAlias(
        $_aliasNameGenerator(db.distressAlert.pastoralistId, db.pastoralist.id),
      );

  $$PastoralistTableProcessedTableManager get pastoralistId {
    final $_column = $_itemColumn<String>('pastoralist_id')!;

    final manager = $$PastoralistTableTableManager(
      $_db,
      $_db.pastoralist,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pastoralistIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DistressAlertTableFilterComposer
    extends Composer<_$AppDatabase, $DistressAlertTable> {
  $$DistressAlertTableFilterComposer({
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

  ColumnFilters<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  $$AnimalTableFilterComposer get animalId {
    final $$AnimalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableFilterComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BehaviourClassificationTableFilterComposer get classificationId {
    final $$BehaviourClassificationTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.classificationId,
          referencedTable: $db.behaviourClassification,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BehaviourClassificationTableFilterComposer(
                $db: $db,
                $table: $db.behaviourClassification,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PastoralistTableFilterComposer get pastoralistId {
    final $$PastoralistTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableFilterComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistressAlertTableOrderingComposer
    extends Composer<_$AppDatabase, $DistressAlertTable> {
  $$DistressAlertTableOrderingComposer({
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

  ColumnOrderings<String> get alertType => $composableBuilder(
    column: $table.alertType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get severity => $composableBuilder(
    column: $table.severity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  $$AnimalTableOrderingComposer get animalId {
    final $$AnimalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableOrderingComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BehaviourClassificationTableOrderingComposer get classificationId {
    final $$BehaviourClassificationTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.classificationId,
          referencedTable: $db.behaviourClassification,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BehaviourClassificationTableOrderingComposer(
                $db: $db,
                $table: $db.behaviourClassification,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PastoralistTableOrderingComposer get pastoralistId {
    final $$PastoralistTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableOrderingComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistressAlertTableAnnotationComposer
    extends Composer<_$AppDatabase, $DistressAlertTable> {
  $$DistressAlertTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get alertType =>
      $composableBuilder(column: $table.alertType, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get severity =>
      $composableBuilder(column: $table.severity, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<int> get isAcknowledged => $composableBuilder(
    column: $table.isAcknowledged,
    builder: (column) => column,
  );

  GeneratedColumn<int> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  $$AnimalTableAnnotationComposer get animalId {
    final $$AnimalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.animalId,
      referencedTable: $db.animal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AnimalTableAnnotationComposer(
            $db: $db,
            $table: $db.animal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BehaviourClassificationTableAnnotationComposer get classificationId {
    final $$BehaviourClassificationTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.classificationId,
          referencedTable: $db.behaviourClassification,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BehaviourClassificationTableAnnotationComposer(
                $db: $db,
                $table: $db.behaviourClassification,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$PastoralistTableAnnotationComposer get pastoralistId {
    final $$PastoralistTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pastoralistId,
      referencedTable: $db.pastoralist,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PastoralistTableAnnotationComposer(
            $db: $db,
            $table: $db.pastoralist,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DistressAlertTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DistressAlertTable,
          DistressAlertData,
          $$DistressAlertTableFilterComposer,
          $$DistressAlertTableOrderingComposer,
          $$DistressAlertTableAnnotationComposer,
          $$DistressAlertTableCreateCompanionBuilder,
          $$DistressAlertTableUpdateCompanionBuilder,
          (DistressAlertData, $$DistressAlertTableReferences),
          DistressAlertData,
          PrefetchHooks Function({
            bool animalId,
            bool classificationId,
            bool pastoralistId,
          })
        > {
  $$DistressAlertTableTableManager(_$AppDatabase db, $DistressAlertTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DistressAlertTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DistressAlertTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DistressAlertTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> animalId = const Value.absent(),
                Value<String> classificationId = const Value.absent(),
                Value<String> pastoralistId = const Value.absent(),
                Value<String> alertType = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> severity = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
                Value<int> isAcknowledged = const Value.absent(),
                Value<int> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DistressAlertCompanion(
                id: id,
                animalId: animalId,
                classificationId: classificationId,
                pastoralistId: pastoralistId,
                alertType: alertType,
                message: message,
                severity: severity,
                timestamp: timestamp,
                isAcknowledged: isAcknowledged,
                synced: synced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String animalId,
                required String classificationId,
                required String pastoralistId,
                required String alertType,
                required String message,
                required String severity,
                required DateTime timestamp,
                Value<int> isAcknowledged = const Value.absent(),
                Value<int> synced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DistressAlertCompanion.insert(
                id: id,
                animalId: animalId,
                classificationId: classificationId,
                pastoralistId: pastoralistId,
                alertType: alertType,
                message: message,
                severity: severity,
                timestamp: timestamp,
                isAcknowledged: isAcknowledged,
                synced: synced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DistressAlertTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                animalId = false,
                classificationId = false,
                pastoralistId = false,
              }) {
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
                        if (animalId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.animalId,
                                    referencedTable:
                                        $$DistressAlertTableReferences
                                            ._animalIdTable(db),
                                    referencedColumn:
                                        $$DistressAlertTableReferences
                                            ._animalIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (classificationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.classificationId,
                                    referencedTable:
                                        $$DistressAlertTableReferences
                                            ._classificationIdTable(db),
                                    referencedColumn:
                                        $$DistressAlertTableReferences
                                            ._classificationIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }
                        if (pastoralistId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.pastoralistId,
                                    referencedTable:
                                        $$DistressAlertTableReferences
                                            ._pastoralistIdTable(db),
                                    referencedColumn:
                                        $$DistressAlertTableReferences
                                            ._pastoralistIdTable(db)
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

typedef $$DistressAlertTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DistressAlertTable,
      DistressAlertData,
      $$DistressAlertTableFilterComposer,
      $$DistressAlertTableOrderingComposer,
      $$DistressAlertTableAnnotationComposer,
      $$DistressAlertTableCreateCompanionBuilder,
      $$DistressAlertTableUpdateCompanionBuilder,
      (DistressAlertData, $$DistressAlertTableReferences),
      DistressAlertData,
      PrefetchHooks Function({
        bool animalId,
        bool classificationId,
        bool pastoralistId,
      })
    >;
typedef $$PastureMapTableCreateCompanionBuilder =
    PastureMapCompanion Function({
      required String id,
      required String region,
      required DateTime generatedAt,
      required double ndviScore,
      required String condition,
      required double biomassKgPerHa,
      required double areaHa,
      required double totalBiomassKg,
      Value<int?> carryingCapacity,
      Value<int?> durationDays,
      Value<String?> tilePath,
      Value<int> rowid,
    });
typedef $$PastureMapTableUpdateCompanionBuilder =
    PastureMapCompanion Function({
      Value<String> id,
      Value<String> region,
      Value<DateTime> generatedAt,
      Value<double> ndviScore,
      Value<String> condition,
      Value<double> biomassKgPerHa,
      Value<double> areaHa,
      Value<double> totalBiomassKg,
      Value<int?> carryingCapacity,
      Value<int?> durationDays,
      Value<String?> tilePath,
      Value<int> rowid,
    });

class $$PastureMapTableFilterComposer
    extends Composer<_$AppDatabase, $PastureMapTable> {
  $$PastureMapTableFilterComposer({
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

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ndviScore => $composableBuilder(
    column: $table.ndviScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get biomassKgPerHa => $composableBuilder(
    column: $table.biomassKgPerHa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get areaHa => $composableBuilder(
    column: $table.areaHa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalBiomassKg => $composableBuilder(
    column: $table.totalBiomassKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get carryingCapacity => $composableBuilder(
    column: $table.carryingCapacity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tilePath => $composableBuilder(
    column: $table.tilePath,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PastureMapTableOrderingComposer
    extends Composer<_$AppDatabase, $PastureMapTable> {
  $$PastureMapTableOrderingComposer({
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

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ndviScore => $composableBuilder(
    column: $table.ndviScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get condition => $composableBuilder(
    column: $table.condition,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get biomassKgPerHa => $composableBuilder(
    column: $table.biomassKgPerHa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get areaHa => $composableBuilder(
    column: $table.areaHa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalBiomassKg => $composableBuilder(
    column: $table.totalBiomassKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get carryingCapacity => $composableBuilder(
    column: $table.carryingCapacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tilePath => $composableBuilder(
    column: $table.tilePath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PastureMapTableAnnotationComposer
    extends Composer<_$AppDatabase, $PastureMapTable> {
  $$PastureMapTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<DateTime> get generatedAt => $composableBuilder(
    column: $table.generatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ndviScore =>
      $composableBuilder(column: $table.ndviScore, builder: (column) => column);

  GeneratedColumn<String> get condition =>
      $composableBuilder(column: $table.condition, builder: (column) => column);

  GeneratedColumn<double> get biomassKgPerHa => $composableBuilder(
    column: $table.biomassKgPerHa,
    builder: (column) => column,
  );

  GeneratedColumn<double> get areaHa =>
      $composableBuilder(column: $table.areaHa, builder: (column) => column);

  GeneratedColumn<double> get totalBiomassKg => $composableBuilder(
    column: $table.totalBiomassKg,
    builder: (column) => column,
  );

  GeneratedColumn<int> get carryingCapacity => $composableBuilder(
    column: $table.carryingCapacity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationDays => $composableBuilder(
    column: $table.durationDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tilePath =>
      $composableBuilder(column: $table.tilePath, builder: (column) => column);
}

class $$PastureMapTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PastureMapTable,
          PastureMapData,
          $$PastureMapTableFilterComposer,
          $$PastureMapTableOrderingComposer,
          $$PastureMapTableAnnotationComposer,
          $$PastureMapTableCreateCompanionBuilder,
          $$PastureMapTableUpdateCompanionBuilder,
          (
            PastureMapData,
            BaseReferences<_$AppDatabase, $PastureMapTable, PastureMapData>,
          ),
          PastureMapData,
          PrefetchHooks Function()
        > {
  $$PastureMapTableTableManager(_$AppDatabase db, $PastureMapTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PastureMapTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PastureMapTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PastureMapTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> region = const Value.absent(),
                Value<DateTime> generatedAt = const Value.absent(),
                Value<double> ndviScore = const Value.absent(),
                Value<String> condition = const Value.absent(),
                Value<double> biomassKgPerHa = const Value.absent(),
                Value<double> areaHa = const Value.absent(),
                Value<double> totalBiomassKg = const Value.absent(),
                Value<int?> carryingCapacity = const Value.absent(),
                Value<int?> durationDays = const Value.absent(),
                Value<String?> tilePath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastureMapCompanion(
                id: id,
                region: region,
                generatedAt: generatedAt,
                ndviScore: ndviScore,
                condition: condition,
                biomassKgPerHa: biomassKgPerHa,
                areaHa: areaHa,
                totalBiomassKg: totalBiomassKg,
                carryingCapacity: carryingCapacity,
                durationDays: durationDays,
                tilePath: tilePath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String region,
                required DateTime generatedAt,
                required double ndviScore,
                required String condition,
                required double biomassKgPerHa,
                required double areaHa,
                required double totalBiomassKg,
                Value<int?> carryingCapacity = const Value.absent(),
                Value<int?> durationDays = const Value.absent(),
                Value<String?> tilePath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PastureMapCompanion.insert(
                id: id,
                region: region,
                generatedAt: generatedAt,
                ndviScore: ndviScore,
                condition: condition,
                biomassKgPerHa: biomassKgPerHa,
                areaHa: areaHa,
                totalBiomassKg: totalBiomassKg,
                carryingCapacity: carryingCapacity,
                durationDays: durationDays,
                tilePath: tilePath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PastureMapTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PastureMapTable,
      PastureMapData,
      $$PastureMapTableFilterComposer,
      $$PastureMapTableOrderingComposer,
      $$PastureMapTableAnnotationComposer,
      $$PastureMapTableCreateCompanionBuilder,
      $$PastureMapTableUpdateCompanionBuilder,
      (
        PastureMapData,
        BaseReferences<_$AppDatabase, $PastureMapTable, PastureMapData>,
      ),
      PastureMapData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PastoralistTableTableManager get pastoralist =>
      $$PastoralistTableTableManager(_db, _db.pastoralist);
  $$HerdTableTableManager get herd => $$HerdTableTableManager(_db, _db.herd);
  $$AnimalTableTableManager get animal =>
      $$AnimalTableTableManager(_db, _db.animal);
  $$WearableTableTableManager get wearable =>
      $$WearableTableTableManager(_db, _db.wearable);
  $$SyncLogTableTableManager get syncLog =>
      $$SyncLogTableTableManager(_db, _db.syncLog);
  $$AccelerometerReadingTableTableManager get accelerometerReading =>
      $$AccelerometerReadingTableTableManager(_db, _db.accelerometerReading);
  $$BehaviourClassificationTableTableManager get behaviourClassification =>
      $$BehaviourClassificationTableTableManager(
        _db,
        _db.behaviourClassification,
      );
  $$DistressAlertTableTableManager get distressAlert =>
      $$DistressAlertTableTableManager(_db, _db.distressAlert);
  $$PastureMapTableTableManager get pastureMap =>
      $$PastureMapTableTableManager(_db, _db.pastureMap);
}
