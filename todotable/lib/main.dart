import 'package:flutter/material.dart';
import 'package:todotable/screen/home_screen.dart';
import 'package:todotable/database/drift_database.dart';
import 'package:get_it/get_it.dart';

void main() {  
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}
