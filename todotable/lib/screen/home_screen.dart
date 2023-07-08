import 'package:flutter/material.dart';
import 'package:todotable/component/main_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MainList(),
      ),
    );
  }
}
