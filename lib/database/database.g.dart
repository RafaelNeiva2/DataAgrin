// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TarefasTable extends Tarefas with TableInfo<$TarefasTable, Tarefa> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TarefasTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String> nome = GeneratedColumn<String>(
    'nome',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _talhaoMeta = const VerificationMeta('talhao');
  @override
  late final GeneratedColumn<String> talhao = GeneratedColumn<String>(
    'talhao_ou_area',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horaPrevistaMeta = const VerificationMeta(
    'horaPrevista',
  );
  @override
  late final GeneratedColumn<DateTime> horaPrevista = GeneratedColumn<DateTime>(
    'hora_prevista',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Status, int> status =
      GeneratedColumn<int>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Status>($TarefasTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nome,
    talhao,
    horaPrevista,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tarefas';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tarefa> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
        _nomeMeta,
        nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta),
      );
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('talhao_ou_area')) {
      context.handle(
        _talhaoMeta,
        talhao.isAcceptableOrUnknown(data['talhao_ou_area']!, _talhaoMeta),
      );
    } else if (isInserting) {
      context.missing(_talhaoMeta);
    }
    if (data.containsKey('hora_prevista')) {
      context.handle(
        _horaPrevistaMeta,
        horaPrevista.isAcceptableOrUnknown(
          data['hora_prevista']!,
          _horaPrevistaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_horaPrevistaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tarefa map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tarefa(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      nome:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}nome'],
          )!,
      talhao:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}talhao_ou_area'],
          )!,
      horaPrevista:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}hora_prevista'],
          )!,
      status: $TarefasTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $TarefasTable createAlias(String alias) {
    return $TarefasTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Status, int, int> $converterstatus =
      const EnumIndexConverter<Status>(Status.values);
}

class Tarefa extends DataClass implements Insertable<Tarefa> {
  final int id;
  final String nome;
  final String talhao;
  final DateTime horaPrevista;
  final Status status;
  const Tarefa({
    required this.id,
    required this.nome,
    required this.talhao,
    required this.horaPrevista,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nome'] = Variable<String>(nome);
    map['talhao_ou_area'] = Variable<String>(talhao);
    map['hora_prevista'] = Variable<DateTime>(horaPrevista);
    {
      map['status'] = Variable<int>(
        $TarefasTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  TarefasCompanion toCompanion(bool nullToAbsent) {
    return TarefasCompanion(
      id: Value(id),
      nome: Value(nome),
      talhao: Value(talhao),
      horaPrevista: Value(horaPrevista),
      status: Value(status),
    );
  }

  factory Tarefa.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tarefa(
      id: serializer.fromJson<int>(json['id']),
      nome: serializer.fromJson<String>(json['nome']),
      talhao: serializer.fromJson<String>(json['talhao']),
      horaPrevista: serializer.fromJson<DateTime>(json['horaPrevista']),
      status: $TarefasTable.$converterstatus.fromJson(
        serializer.fromJson<int>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nome': serializer.toJson<String>(nome),
      'talhao': serializer.toJson<String>(talhao),
      'horaPrevista': serializer.toJson<DateTime>(horaPrevista),
      'status': serializer.toJson<int>(
        $TarefasTable.$converterstatus.toJson(status),
      ),
    };
  }

  Tarefa copyWith({
    int? id,
    String? nome,
    String? talhao,
    DateTime? horaPrevista,
    Status? status,
  }) => Tarefa(
    id: id ?? this.id,
    nome: nome ?? this.nome,
    talhao: talhao ?? this.talhao,
    horaPrevista: horaPrevista ?? this.horaPrevista,
    status: status ?? this.status,
  );
  Tarefa copyWithCompanion(TarefasCompanion data) {
    return Tarefa(
      id: data.id.present ? data.id.value : this.id,
      nome: data.nome.present ? data.nome.value : this.nome,
      talhao: data.talhao.present ? data.talhao.value : this.talhao,
      horaPrevista:
          data.horaPrevista.present
              ? data.horaPrevista.value
              : this.horaPrevista,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tarefa(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('talhao: $talhao, ')
          ..write('horaPrevista: $horaPrevista, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nome, talhao, horaPrevista, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tarefa &&
          other.id == this.id &&
          other.nome == this.nome &&
          other.talhao == this.talhao &&
          other.horaPrevista == this.horaPrevista &&
          other.status == this.status);
}

class TarefasCompanion extends UpdateCompanion<Tarefa> {
  final Value<int> id;
  final Value<String> nome;
  final Value<String> talhao;
  final Value<DateTime> horaPrevista;
  final Value<Status> status;
  const TarefasCompanion({
    this.id = const Value.absent(),
    this.nome = const Value.absent(),
    this.talhao = const Value.absent(),
    this.horaPrevista = const Value.absent(),
    this.status = const Value.absent(),
  });
  TarefasCompanion.insert({
    this.id = const Value.absent(),
    required String nome,
    required String talhao,
    required DateTime horaPrevista,
    required Status status,
  }) : nome = Value(nome),
       talhao = Value(talhao),
       horaPrevista = Value(horaPrevista),
       status = Value(status);
  static Insertable<Tarefa> custom({
    Expression<int>? id,
    Expression<String>? nome,
    Expression<String>? talhao,
    Expression<DateTime>? horaPrevista,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nome != null) 'nome': nome,
      if (talhao != null) 'talhao_ou_area': talhao,
      if (horaPrevista != null) 'hora_prevista': horaPrevista,
      if (status != null) 'status': status,
    });
  }

  TarefasCompanion copyWith({
    Value<int>? id,
    Value<String>? nome,
    Value<String>? talhao,
    Value<DateTime>? horaPrevista,
    Value<Status>? status,
  }) {
    return TarefasCompanion(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      talhao: talhao ?? this.talhao,
      horaPrevista: horaPrevista ?? this.horaPrevista,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (talhao.present) {
      map['talhao_ou_area'] = Variable<String>(talhao.value);
    }
    if (horaPrevista.present) {
      map['hora_prevista'] = Variable<DateTime>(horaPrevista.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
        $TarefasTable.$converterstatus.toSql(status.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TarefasCompanion(')
          ..write('id: $id, ')
          ..write('nome: $nome, ')
          ..write('talhao: $talhao, ')
          ..write('horaPrevista: $horaPrevista, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $WeatherCachesTable extends WeatherCaches
    with TableInfo<$WeatherCachesTable, WeatherCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeatherCachesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _jsonDataMeta = const VerificationMeta(
    'jsonData',
  );
  @override
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>(
    'json_data',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastUpdatedMeta = const VerificationMeta(
    'lastUpdated',
  );
  @override
  late final GeneratedColumn<DateTime> lastUpdated = GeneratedColumn<DateTime>(
    'last_updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, jsonData, lastUpdated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weather_caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeatherCache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('json_data')) {
      context.handle(
        _jsonDataMeta,
        jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('last_updated')) {
      context.handle(
        _lastUpdatedMeta,
        lastUpdated.isAcceptableOrUnknown(
          data['last_updated']!,
          _lastUpdatedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastUpdatedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeatherCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeatherCache(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      jsonData:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}json_data'],
          )!,
      lastUpdated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}last_updated'],
          )!,
    );
  }

  @override
  $WeatherCachesTable createAlias(String alias) {
    return $WeatherCachesTable(attachedDatabase, alias);
  }
}

class WeatherCache extends DataClass implements Insertable<WeatherCache> {
  final int id;
  final String jsonData;
  final DateTime lastUpdated;
  const WeatherCache({
    required this.id,
    required this.jsonData,
    required this.lastUpdated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['json_data'] = Variable<String>(jsonData);
    map['last_updated'] = Variable<DateTime>(lastUpdated);
    return map;
  }

  WeatherCachesCompanion toCompanion(bool nullToAbsent) {
    return WeatherCachesCompanion(
      id: Value(id),
      jsonData: Value(jsonData),
      lastUpdated: Value(lastUpdated),
    );
  }

  factory WeatherCache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeatherCache(
      id: serializer.fromJson<int>(json['id']),
      jsonData: serializer.fromJson<String>(json['jsonData']),
      lastUpdated: serializer.fromJson<DateTime>(json['lastUpdated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jsonData': serializer.toJson<String>(jsonData),
      'lastUpdated': serializer.toJson<DateTime>(lastUpdated),
    };
  }

  WeatherCache copyWith({int? id, String? jsonData, DateTime? lastUpdated}) =>
      WeatherCache(
        id: id ?? this.id,
        jsonData: jsonData ?? this.jsonData,
        lastUpdated: lastUpdated ?? this.lastUpdated,
      );
  WeatherCache copyWithCompanion(WeatherCachesCompanion data) {
    return WeatherCache(
      id: data.id.present ? data.id.value : this.id,
      jsonData: data.jsonData.present ? data.jsonData.value : this.jsonData,
      lastUpdated:
          data.lastUpdated.present ? data.lastUpdated.value : this.lastUpdated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCache(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, jsonData, lastUpdated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeatherCache &&
          other.id == this.id &&
          other.jsonData == this.jsonData &&
          other.lastUpdated == this.lastUpdated);
}

class WeatherCachesCompanion extends UpdateCompanion<WeatherCache> {
  final Value<int> id;
  final Value<String> jsonData;
  final Value<DateTime> lastUpdated;
  const WeatherCachesCompanion({
    this.id = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.lastUpdated = const Value.absent(),
  });
  WeatherCachesCompanion.insert({
    this.id = const Value.absent(),
    required String jsonData,
    required DateTime lastUpdated,
  }) : jsonData = Value(jsonData),
       lastUpdated = Value(lastUpdated);
  static Insertable<WeatherCache> custom({
    Expression<int>? id,
    Expression<String>? jsonData,
    Expression<DateTime>? lastUpdated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jsonData != null) 'json_data': jsonData,
      if (lastUpdated != null) 'last_updated': lastUpdated,
    });
  }

  WeatherCachesCompanion copyWith({
    Value<int>? id,
    Value<String>? jsonData,
    Value<DateTime>? lastUpdated,
  }) {
    return WeatherCachesCompanion(
      id: id ?? this.id,
      jsonData: jsonData ?? this.jsonData,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (lastUpdated.present) {
      map['last_updated'] = Variable<DateTime>(lastUpdated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeatherCachesCompanion(')
          ..write('id: $id, ')
          ..write('jsonData: $jsonData, ')
          ..write('lastUpdated: $lastUpdated')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TarefasTable tarefas = $TarefasTable(this);
  late final $WeatherCachesTable weatherCaches = $WeatherCachesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tarefas, weatherCaches];
}

typedef $$TarefasTableCreateCompanionBuilder =
    TarefasCompanion Function({
      Value<int> id,
      required String nome,
      required String talhao,
      required DateTime horaPrevista,
      required Status status,
    });
typedef $$TarefasTableUpdateCompanionBuilder =
    TarefasCompanion Function({
      Value<int> id,
      Value<String> nome,
      Value<String> talhao,
      Value<DateTime> horaPrevista,
      Value<Status> status,
    });

class $$TarefasTableFilterComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableFilterComposer({
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

  ColumnFilters<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get talhao => $composableBuilder(
    column: $table.talhao,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get horaPrevista => $composableBuilder(
    column: $table.horaPrevista,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Status, Status, int> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$TarefasTableOrderingComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableOrderingComposer({
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

  ColumnOrderings<String> get nome => $composableBuilder(
    column: $table.nome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get talhao => $composableBuilder(
    column: $table.talhao,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get horaPrevista => $composableBuilder(
    column: $table.horaPrevista,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TarefasTableAnnotationComposer
    extends Composer<_$AppDatabase, $TarefasTable> {
  $$TarefasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nome =>
      $composableBuilder(column: $table.nome, builder: (column) => column);

  GeneratedColumn<String> get talhao =>
      $composableBuilder(column: $table.talhao, builder: (column) => column);

  GeneratedColumn<DateTime> get horaPrevista => $composableBuilder(
    column: $table.horaPrevista,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Status, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$TarefasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TarefasTable,
          Tarefa,
          $$TarefasTableFilterComposer,
          $$TarefasTableOrderingComposer,
          $$TarefasTableAnnotationComposer,
          $$TarefasTableCreateCompanionBuilder,
          $$TarefasTableUpdateCompanionBuilder,
          (Tarefa, BaseReferences<_$AppDatabase, $TarefasTable, Tarefa>),
          Tarefa,
          PrefetchHooks Function()
        > {
  $$TarefasTableTableManager(_$AppDatabase db, $TarefasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$TarefasTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$TarefasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$TarefasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nome = const Value.absent(),
                Value<String> talhao = const Value.absent(),
                Value<DateTime> horaPrevista = const Value.absent(),
                Value<Status> status = const Value.absent(),
              }) => TarefasCompanion(
                id: id,
                nome: nome,
                talhao: talhao,
                horaPrevista: horaPrevista,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nome,
                required String talhao,
                required DateTime horaPrevista,
                required Status status,
              }) => TarefasCompanion.insert(
                id: id,
                nome: nome,
                talhao: talhao,
                horaPrevista: horaPrevista,
                status: status,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TarefasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TarefasTable,
      Tarefa,
      $$TarefasTableFilterComposer,
      $$TarefasTableOrderingComposer,
      $$TarefasTableAnnotationComposer,
      $$TarefasTableCreateCompanionBuilder,
      $$TarefasTableUpdateCompanionBuilder,
      (Tarefa, BaseReferences<_$AppDatabase, $TarefasTable, Tarefa>),
      Tarefa,
      PrefetchHooks Function()
    >;
typedef $$WeatherCachesTableCreateCompanionBuilder =
    WeatherCachesCompanion Function({
      Value<int> id,
      required String jsonData,
      required DateTime lastUpdated,
    });
typedef $$WeatherCachesTableUpdateCompanionBuilder =
    WeatherCachesCompanion Function({
      Value<int> id,
      Value<String> jsonData,
      Value<DateTime> lastUpdated,
    });

class $$WeatherCachesTableFilterComposer
    extends Composer<_$AppDatabase, $WeatherCachesTable> {
  $$WeatherCachesTableFilterComposer({
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

  ColumnFilters<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeatherCachesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeatherCachesTable> {
  $$WeatherCachesTableOrderingComposer({
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

  ColumnOrderings<String> get jsonData => $composableBuilder(
    column: $table.jsonData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeatherCachesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeatherCachesTable> {
  $$WeatherCachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get jsonData =>
      $composableBuilder(column: $table.jsonData, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdated => $composableBuilder(
    column: $table.lastUpdated,
    builder: (column) => column,
  );
}

class $$WeatherCachesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeatherCachesTable,
          WeatherCache,
          $$WeatherCachesTableFilterComposer,
          $$WeatherCachesTableOrderingComposer,
          $$WeatherCachesTableAnnotationComposer,
          $$WeatherCachesTableCreateCompanionBuilder,
          $$WeatherCachesTableUpdateCompanionBuilder,
          (
            WeatherCache,
            BaseReferences<_$AppDatabase, $WeatherCachesTable, WeatherCache>,
          ),
          WeatherCache,
          PrefetchHooks Function()
        > {
  $$WeatherCachesTableTableManager(_$AppDatabase db, $WeatherCachesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$WeatherCachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$WeatherCachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$WeatherCachesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> jsonData = const Value.absent(),
                Value<DateTime> lastUpdated = const Value.absent(),
              }) => WeatherCachesCompanion(
                id: id,
                jsonData: jsonData,
                lastUpdated: lastUpdated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String jsonData,
                required DateTime lastUpdated,
              }) => WeatherCachesCompanion.insert(
                id: id,
                jsonData: jsonData,
                lastUpdated: lastUpdated,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeatherCachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeatherCachesTable,
      WeatherCache,
      $$WeatherCachesTableFilterComposer,
      $$WeatherCachesTableOrderingComposer,
      $$WeatherCachesTableAnnotationComposer,
      $$WeatherCachesTableCreateCompanionBuilder,
      $$WeatherCachesTableUpdateCompanionBuilder,
      (
        WeatherCache,
        BaseReferences<_$AppDatabase, $WeatherCachesTable, WeatherCache>,
      ),
      WeatherCache,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TarefasTableTableManager get tarefas =>
      $$TarefasTableTableManager(_db, _db.tarefas);
  $$WeatherCachesTableTableManager get weatherCaches =>
      $$WeatherCachesTableTableManager(_db, _db.weatherCaches);
}
