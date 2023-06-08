// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drift_database.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Todo extends DataClass implements Insertable<Todo> {
  final int id;
  final String todo;
  final DateTime date;
  final DateTime time;
  const Todo(
      {required this.id,
      required this.todo,
      required this.date,
      required this.time});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['todo'] = Variable<String>(todo);
    map['date'] = Variable<DateTime>(date);
    map['time'] = Variable<DateTime>(time);
    return map;
  }

  TodosCompanion toCompanion(bool nullToAbsent) {
    return TodosCompanion(
      id: Value(id),
      todo: Value(todo),
      date: Value(date),
      time: Value(time),
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Todo(
      id: serializer.fromJson<int>(json['id']),
      todo: serializer.fromJson<String>(json['todo']),
      date: serializer.fromJson<DateTime>(json['date']),
      time: serializer.fromJson<DateTime>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'todo': serializer.toJson<String>(todo),
      'date': serializer.toJson<DateTime>(date),
      'time': serializer.toJson<DateTime>(time),
    };
  }

  Todo copyWith({int? id, String? todo, DateTime? date, DateTime? time}) =>
      Todo(
        id: id ?? this.id,
        todo: todo ?? this.todo,
        date: date ?? this.date,
        time: time ?? this.time,
      );
  @override
  String toString() {
    return (StringBuffer('Todo(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('date: $date, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, todo, date, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Todo &&
          other.id == this.id &&
          other.todo == this.todo &&
          other.date == this.date &&
          other.time == this.time);
}

class TodosCompanion extends UpdateCompanion<Todo> {
  final Value<int> id;
  final Value<String> todo;
  final Value<DateTime> date;
  final Value<DateTime> time;
  const TodosCompanion({
    this.id = const Value.absent(),
    this.todo = const Value.absent(),
    this.date = const Value.absent(),
    this.time = const Value.absent(),
  });
  TodosCompanion.insert({
    this.id = const Value.absent(),
    required String todo,
    required DateTime date,
    required DateTime time,
  })  : todo = Value(todo),
        date = Value(date),
        time = Value(time);
  static Insertable<Todo> custom({
    Expression<int>? id,
    Expression<String>? todo,
    Expression<DateTime>? date,
    Expression<DateTime>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (todo != null) 'todo': todo,
      if (date != null) 'date': date,
      if (time != null) 'time': time,
    });
  }

  TodosCompanion copyWith(
      {Value<int>? id,
      Value<String>? todo,
      Value<DateTime>? date,
      Value<DateTime>? time}) {
    return TodosCompanion(
      id: id ?? this.id,
      todo: todo ?? this.todo,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (todo.present) {
      map['todo'] = Variable<String>(todo.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TodosCompanion(')
          ..write('id: $id, ')
          ..write('todo: $todo, ')
          ..write('date: $date, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $TodosTable extends Todos with TableInfo<$TodosTable, Todo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TodosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _todoMeta = const VerificationMeta('todo');
  @override
  late final GeneratedColumn<String> todo = GeneratedColumn<String>(
      'todo', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  final VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
      'time', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, todo, date, time];
  @override
  String get aliasedName => _alias ?? 'todos';
  @override
  String get actualTableName => 'todos';
  @override
  VerificationContext validateIntegrity(Insertable<Todo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('todo')) {
      context.handle(
          _todoMeta, todo.isAcceptableOrUnknown(data['todo']!, _todoMeta));
    } else if (isInserting) {
      context.missing(_todoMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
          _timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Todo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Todo(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      todo: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}todo'])!,
      date: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      time: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}time'])!,
    );
  }

  @override
  $TodosTable createAlias(String alias) {
    return $TodosTable(attachedDatabase, alias);
  }
}

abstract class _$LocalDatabase extends GeneratedDatabase {
  _$LocalDatabase(QueryExecutor e) : super(e);
  late final $TodosTable todos = $TodosTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [todos];
}
