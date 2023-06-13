import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todotable/database/drift_database.dart';
import 'package:todotable/screen/home_screen.dart';
import 'package:get_it/get_it.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await initializeDateFormatting();
//   final database = LocalDatabase();

//   GetIt.I.registerSingleton<LocalDatabase>(database);
//   runApp(
//     const MaterialApp(
//       home: HomeScreen(),
//     ),
//   );
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  final database = LocalDatabase();
  GetIt.I.registerSingleton<LocalDatabase>(database);
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}
