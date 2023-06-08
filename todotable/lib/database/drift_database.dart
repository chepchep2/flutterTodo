import 'package:todotable/model/todos.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Todos,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<List<Todo>> watchTodos(DateTime date) =>
      (select(todos)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createTodo(TodosCompanion data) => into(todos).insert(data);

  Future<int> removeTodos(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
