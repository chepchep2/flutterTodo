import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            const Text("6월 1일 목요일"),
            const Text("오늘의 투두"),
            Row(
              children: [
                Checkbox(
                  fillColor: const MaterialStatePropertyAll(Colors.black),
                  value: isChecked,
                  onChanged: (value) {
                    setState(
                      () {
                        isChecked = value;
                      },
                    );
                  },
                ),
                const Text("투두 타이틀"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
