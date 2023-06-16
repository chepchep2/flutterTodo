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

  Stream<List<Todo>> watchTodos(DateTime date) =>
      (select(todos)..where((tbl) => tbl.date.equals(date))).watch();
  // 내 투두리스트앱에서 무언가를 선택하는 기능이 필요할까 싶음?

  Future<int> createTodos({
    required String name,
    required DateTime date,
    required DateTime time,
  }) async {
    final companion = TodosCompanion(
      name: Value(name),
      date: Value(date),
      time: Value(time),
    );
    return await into(todos).insert(companion);
  }
  // +버튼이나 키보드의 done/완료를 눌렀을 때 저장을 해야하니깐

  Future<int> removeTodos(int id) =>
      (delete(todos)..where((tbl) => tbl.id.equals(id))).go();
  // 삭제 버튼을 눌렀을 때 삭제를 해야하니깐

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
