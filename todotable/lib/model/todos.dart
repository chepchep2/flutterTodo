import 'package:drift/drift.dart';

// https://drift.simonbinder.eu/docs/getting-started/advanced_dart_tables/
class Todos extends Table {
  IntColumn get id => integer().autoIncrement()(); // db id 값
  TextColumn get name => text()(); // todo 이름
  TextColumn get description =>
      text().nullable()(); // todo 설명인데, 처음엔 null 일 수 있음
  DateTimeColumn get createdAt => dateTime()(); // 생성 시각
  DateTimeColumn get completedAt =>
      dateTime().nullable()(); // 완료 시각인데, 처음엔 null 일 수 있음
}
