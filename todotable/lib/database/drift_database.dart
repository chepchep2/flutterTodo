// import 'dart:io';

// import 'package:drift/drift.dart';
// import 'package:todotable/model/lists.dart';

// import 'package:drift/native.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;

// part 'drift_database.g.dart';

// @DriftDatabase(
//   tables: [
//     Lists,
//   ],
// )
// class LocalDatabase extends _$LocalDatabase {
//   LocalDatabase() : super(_openConnection());
//   Stream<List<List>> watchLists(DateTime date) =>
//       (select(lists)..where((tbl) => tbl.date.equals(date))).watch();

//   Future<int> createList(ListsCompanion data) => into(lists).insert(data);

//   Future<int> removeList(int id) =>
//       (delete(lists)..where((tbl) => tbl.id.equals(id))).go();

//   @override
//   int get schemaVersion => 1;
// }

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'db.sqlite'));
//     return NativeDatabase(file);
//   });
// }
