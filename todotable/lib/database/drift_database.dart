import 'package:todotable/model/todos.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart' as drift_native;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Todos,
    // 사용할 테이블을 등록
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  Stream<List<Todo>> watchTodos(DateTime createdAt) =>
      (select(todos)..where((tbl) => tbl.createdAt.equals(createdAt))).watch();

  Future<int> createdTodos({
    required String name,
  }) async {
    final companion = TodosCompanion(
      name: Value(name),
      createdAt: Value(DateTime.now()),
    );
    return await into(todos).insert(companion);
  }

  Future<int> removeTodos(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  // 삭제 버튼을 눌렀을 때 삭제를 해야하니깐

  // Future<List<Todo>> getTodos() => select(todos).get();
  Stream<List<Todo>> getTodos() => select(todos).watch();

  // Future<bool> updatedCheck() =>

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return drift_native.NativeDatabase(file);
    });
  }
}
