import 'package:drift/drift.dart';

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get todo => text()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get time => dateTime()();
}
