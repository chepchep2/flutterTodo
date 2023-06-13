import 'package:todotable/model/schedule.dart';
import 'package:drift/drift.dart';

import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'drift_database.g.dart';

@DriftDatabase(
  tables: [
    Schedules,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());
  // select기능
  Stream<List<Schedule>> watchSchedules(DateTime date) =>
      // 데이터를 조회하고 변화 감지
      // 테이블의 date 컬럼과 매개변수에 입력된 date 변수가 같은지 비교하기 위해 equals()함수 사용
      (select(schedules)..where((tbl) => tbl.date.equals(date))).watch();

  Future<int> createSchedule(SchedulesCompanion data) =>
      // into()함수를 사용해서 어떤 테이블에 데이터를 넣을지 지정해준 다음
      // insert()함수를 사용한다.
      // 데이터를 생성할 때는 꼭 생성된 Companion 클래스를 통해서 값들을 넣어줘야한다.
      into(schedules).insert(data);

  Future<int> removeSchedule(int id) =>
      // go()함수를 실행해줘야 삭제가 완료된다.
      // 특정 id에 해당되는 값만 삭제해야 하니 매개변수에 id값을 입력받고
      // 해당 id에 해당되는 일정만 삭제해야한다.
      (delete(schedules)..where((tbl) => tbl.id.equals(id))).go();

  @override
  int get schemaVersion => 1;
  // schemaVersion 값을 지정해줘야한다.
  // 기본적으로 1부터 시작하고 테이블의 변화가 있을 때마다 1씩 올려줘서 테이블 구조가 변경된다는걸
  // 드리프트에 인지시켜주는 기능이다.
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
